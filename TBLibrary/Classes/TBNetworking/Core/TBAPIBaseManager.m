//
//  TBAPIBaseManager.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBAPIBaseManager.h"

@interface TBAPIBaseManager ()

@property (nonatomic, strong) NSNumber *taskIdentifier;
@property (nonatomic, strong) TBServiceBaseManager *serviceManager;

@end

@implementation TBAPIBaseManager

@synthesize timeOutInterval = _timeOutInterval;
@synthesize customHeader = _customHeader;
@synthesize customParams = _customParams;
@synthesize userInfo = _userInfo;
@synthesize httpMethod = _httpMethod;
@synthesize methodName = _methodName;
@synthesize customURL = _customURL;
@synthesize substituteMappingDictionary = _substituteMappingDictionary;

- (void)dealloc {
    [self cancelRequest];
}

- (void)cancelRequest {
    if (self.taskIdentifier) {
        [[TBURLSessionTaskManager sharedInstance] cancelRequestWithTaskIdentifier:self.taskIdentifier];
    }
}

- (NSNumber *)loadRequestComplete:(TBRequestComplete)complete {
    self.isLoading = YES;
    __weak typeof(self) weakself = self;
    if ([self respondsToSelector:@selector(getErrorForRequestParam)]) {
        NSString *errorMessage =  [self getErrorForRequestParam];
        if (errorMessage.length > 0) {
            TBURLResponse *response = [TBURLResponse new];
            response.responseStatusCode = TBResponseStatusCodeErrorParam;
            response.message = errorMessage;
            weakself.isLoading = NO;
            !complete ?: complete(response, nil);
            return nil;
        }
    }
    self.taskIdentifier = @([[TBURLSessionTaskManager sharedInstance] requestWithURLRequest:[self generateRequest] userInfo:self.userInfo complete:^(TBURLResponse *response, NSError *error) {
        weakself.isLoading = NO;
        if ([weakself respondsToSelector:@selector(mockReturnObject)] && weakself.mockReturnObject) {
            response.returnObject = self.mockReturnObject;
        } else if (error) {
            NSString *message = nil;
            if ([weakself.serviceConfig respondsToSelector:@selector(getHttpMessageWithResponse:)]) {
                message = [weakself.serviceConfig getHttpMessageWithResponse:response];
            }
            if (message.length == 0) {
                if ([response.response isKindOfClass:[NSHTTPURLResponse class]]) {
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response.response;
                    message = [weakself getLocalizedDescriptionWithStatusCode:httpResponse.statusCode];
                }
            }
            if (message.length == 0) {
                message = [weakself getLocalizedDescriptionWithStatusCode:error.code];
            }
            response.message = message;
            complete ? complete(response, error) : nil;
            return;
        }
        id returnObject = response.returnObject;
        if (!returnObject) {
            response.responseStatusCode = TBResponseStatusCodeErrorJSON;
            response.message = [weakself getLocalizedDescriptionWithStatusCode:response.responseStatusCode];
            !complete ?: complete(response, nil);
            return;
        }
        if (weakself) {
            if ([weakself.serviceConfig respondsToSelector:@selector(checkReturnStructureIsOK:)] && ![weakself.serviceConfig checkReturnStructureIsOK:response]) {
                if (response.responseStatusCode == TBResponseStatusCodeSuccess) {
                    response.responseStatusCode = TBResponseStatusCodeErrorReturn;
                }
                if (response.message.length == 0) {
                    response.message = [weakself getLocalizedDescriptionWithStatusCode:response.responseStatusCode];
                }
                !complete ?: complete(response, nil);
                return;
            }
            if ([weakself respondsToSelector:@selector(checkResponse:)] && ![weakself checkResponse:response]) {
                response.responseStatusCode = TBResponseStatusCodeErrorData;
                if (response.message.length == 0) {
                    response.message = [weakself getLocalizedDescriptionWithStatusCode:response.responseStatusCode];
                }
                !complete ?: complete(response, nil);
                return;
            }
            if ([weakself conformsToProtocol:@protocol(TBModelMappingProtocol)] && [weakself respondsToSelector:@selector(modelMappingFromObject:)]) {
                response.returnObject = [weakself modelMappingFromObject:returnObject];
            }
        }
        response.responseStatusCode = TBResponseStatusCodeSuccess;
        !complete ?: complete(response, nil);
    }]);
    return self.taskIdentifier;
}

- (NSURLRequest *)generateRequest {
    [self beforeGenerateRequestHook];
    NSString *url = [self generateURL];
    TBRequestContentType contentType = [self contentType];
    TBRequestHTTPMethodType httpMethod = [self httpMethod];
    NSDictionary *commonRequestHeader = [self commonRequestHeader];
    NSDictionary *commonRequestParams = [self commonRequestParams];
    NSDictionary *customHeaderOrigin = [self customHeader] ? [self customHeader] : @{};
    NSDictionary *customParamsOrigin = [self customParams] ? [self customParams] : @{};
    
    NSMutableDictionary *customHeader = [customHeaderOrigin mutableCopy];
    NSMutableDictionary *customParams = [customParamsOrigin mutableCopy];
    
    [customHeader addEntriesFromDictionary:commonRequestHeader];
    [customParams addEntriesFromDictionary:commonRequestParams];
    
    [[TBURLRequestGenerator sharedInstance] setTimeOutInterval:self.timeOutInterval];
    
    return [[TBURLRequestGenerator sharedInstance] generateRequestWithURL:url contentType:contentType httpMethod:httpMethod httpHeader:customHeader requestParams:customParams];
}

- (NSString *)generateURL {
    if ([self respondsToSelector:@selector(customURL)] && self.customURL.length > 0) {
        return self.customURL;
    }
    NSMutableString *url = [[NSMutableString alloc] init];
    if (self.serviceManager) {
        NSString *apiDomain = [self.serviceManager apiDomain];
        if (!apiDomain) {
            apiDomain = @"";
        }
        NSString *apiServiceName = [self.serviceManager apiServiceName];
        if (!apiServiceName) {
            apiServiceName = @"";
        }
        [url appendFormat:@"%@%@%@", apiDomain, apiServiceName, [self methodName]];
    }
    NSDictionary *substituteMappingDictionary = self.substituteMappingDictionary;
    if (substituteMappingDictionary.count) {
        for (NSString *key in [substituteMappingDictionary keyEnumerator]) {
            NSRange r = [url rangeOfString:key];
            if (r.length > 0) {
                [url replaceCharactersInRange:r withString:[NSString stringWithFormat:@"%@", substituteMappingDictionary[key]]];
            }
        }
    }
    if (url.length == 0) {
        NSLog(@"serviceConfig is nil");
    }
    return url;
}

- (NSString *)getLocalizedDescriptionWithStatusCode:(NSInteger)statusCode {
    return [self.serviceConfig getLocalizedDescriptionWithStatusCode:statusCode];
}

#pragma mark - TBAPIDelegate methods
- (NSString *)getErrorForRequestParam {
    return nil;
}

#pragma mark - getter
- (NSTimeInterval)timeOutInterval {
    if (_timeOutInterval) {
        _timeOutInterval = 20.f;
    }
    return _timeOutInterval;
}

- (TBRequestContentType)contentType {
    return TBRequestContentTypeURLEncode;
}

- (NSDictionary *)customParams {
    if (!_customParams) {
        _customParams = @{};
    }
    return _customParams;
}

- (NSDictionary *)userInfo {
    if (!_userInfo) {
        _userInfo = @{};
    }
    return _userInfo;
}

- (NSDictionary *)substituteMappingDictionary {
    if (!_substituteMappingDictionary) {
        _substituteMappingDictionary = @{};
    }
    return _substituteMappingDictionary;
}

- (NSDictionary *)commonRequestHeader {
    if ([self.serviceConfig respondsToSelector:@selector(commonRequestHeader)]) {
        return [self.serviceConfig commonRequestHeader];
    }
    return nil;
}

- (NSDictionary *)commonRequestParams {
    if ([self.serviceConfig respondsToSelector:@selector(commonRequestParams)]) {
        return [self.serviceConfig commonRequestParams];
    }
    return nil;
}

- (NSString *)methodName {
    NSAssert(_methodName, @"methodName should not be nil");
    return _methodName;
}

- (TBRequestHTTPMethodType)httpMethod {
    return _httpMethod;
}

- (id<TBServiceProtocol>)serviceConfig {
    NSAssert(NO, @"serviceConfig getter need to be rewrote in subclasses");
    return nil;
}

- (TBServiceBaseManager *)serviceManager {
    if (!_serviceManager) {
        _serviceManager = [TBServiceBaseManager new];
        id serviceConfig = self.serviceConfig;
        if (![serviceConfig conformsToProtocol:@protocol(TBServiceProtocol)]) {
            NSAssert(NO, @"serviceConfig must conforms to protocol TBServiceProtocol");
        }
        _serviceManager.serviceConfig = serviceConfig;
    }
    return _serviceManager;
}

- (void)beforeGenerateRequestHook {
    
}

@end
