//
//  TBURLRequestGenerator.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBURLRequestGenerator.h"
#import "AFURLRequestSerialization.h"
#include <sys/utsname.h>

NS_INLINE NSString * TBRequestHTTPMethod(TBRequestHTTPMethodType type) {
    switch (type) {
        case TBRequestHTTPMethodGET:
            return @"GET";
        case TBRequestHTTPMethodPOST:
            return @"POST";
        case TBRequestHTTPMethodPUT:
            return @"PUT";
        case TBRequestHTTPMethodDELETE:
            return @"DELETE";
        default: {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
            return nil;
#pragma clang diagnostic pop
        }
    }
}

@interface TBURLRequestGenerator()
@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;
@property (nonatomic, strong) AFJSONRequestSerializer *jsonRequestSerializer;
@end

@implementation TBURLRequestGenerator

+ (instancetype)sharedInstance {
    static TBURLRequestGenerator *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[TBURLRequestGenerator alloc] initUseInner];
    });
    return singleton;
}

- (instancetype)init {
    NSAssert(NO, @"\nfile: %s  line: %d  function: %s  content: 换别的初始化方法吧", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  __LINE__, __FUNCTION__);
    return nil;
}

- (instancetype)initUseInner {
    self = [super init];
    if (self) {
        _timeOutInterval = 20.f;
    }
    return self;
}

- (NSURLRequest *)generateRequestWithURL:(NSString *)url contentType:(TBRequestContentType)contentType httpMethod:(TBRequestHTTPMethodType)httpMethod httpHeader:(NSDictionary *)httpHeader requestParams:(NSDictionary *)requestParams {
    NSURLRequest *request = nil;
    if (requestParams.count == 0) {
        requestParams = nil;
    }
    switch (contentType) {
        case TBRequestContentTypeURLEncode:
            request = [self generateURLEncodeRequestWithURL:url httpMethod:httpMethod httpHeader:httpHeader requestParams:requestParams];
            break;
        case TBRequestContentTypeJson:
            request =  [self generateJSONRequestWithURL:url httpMethod:httpMethod httpHeader:httpHeader requestParams:requestParams];
            break;
        case TBRequestContentTypeFormData:
            request =  [self generateFormDataRequestWithURL:url httpMethod:httpMethod httpHeader:httpHeader requestParams:requestParams];
            break;
    }
    
    NSLog(@"request url %@", request.URL);
    NSLog(@"request HTTPMethod %@", request.HTTPMethod);
    NSLog(@"request requestParams %@", requestParams);
    NSLog(@"request HTTPHeaderFields %@", request.allHTTPHeaderFields);
    return request;
}

#pragma mark - Privite

- (NSURLRequest *)generateURLEncodeRequestWithURL:(NSString *)url httpMethod:(TBRequestHTTPMethodType)HTTPMethod httpHeader:(NSDictionary *)httpHeader requestParams:(NSDictionary *)requestParams
{
    [httpHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [self.httpRequestSerializer setValue:[obj stringValue] forHTTPHeaderField:key];
        } else {
            [self.httpRequestSerializer setValue:obj forHTTPHeaderField:key];
        }
    }];
    
    return [self.httpRequestSerializer requestWithMethod:TBRequestHTTPMethod(HTTPMethod) URLString:url parameters:requestParams error:nil];
}

- (NSURLRequest *)generateJSONRequestWithURL:(NSString *)url httpMethod:(TBRequestHTTPMethodType)HTTPMethod httpHeader:(NSDictionary *)httpHeader requestParams:(NSDictionary *)requestParams
{
    [httpHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [self.jsonRequestSerializer setValue:[obj stringValue] forHTTPHeaderField:key];
        } else {
            [self.jsonRequestSerializer setValue:obj forHTTPHeaderField:key];
        }
    }];
    return [self.jsonRequestSerializer requestWithMethod:TBRequestHTTPMethod(HTTPMethod) URLString:url parameters:requestParams error:nil];
}

- (NSString *)userAgent
{
    NSString *userAgent = nil;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
#if TARGET_OS_IOS
    // User-Agent Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
    userAgent = [NSString stringWithFormat:@"%@/%@ (iOS %@;%@)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[UIDevice currentDevice] systemVersion],[self platformString]];
#elif TARGET_OS_WATCH
    // User-Agent Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.43
    userAgent = [NSString stringWithFormat:@"%@/%@ (watchOS %@;%@)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[WKInterfaceDevice currentDevice] systemVersion], [[WKInterfaceDevice currentDevice] model]];
#elif defined(__MAC_OS_X_VERSION_MIN_REQUIRED)
    userAgent = [NSString stringWithFormat:@"%@/%@ (Mac OS X %@,MAC)", [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleExecutableKey] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleIdentifierKey], [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"] ?: [[NSBundle mainBundle] infoDictionary][(__bridge NSString *)kCFBundleVersionKey], [[NSProcessInfo processInfo] operatingSystemVersionString]];
#endif
#pragma clang diagnostic pop
    return userAgent;
}

- (NSString *)platformString{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return platform;
}

- (NSURLRequest *)generateFormDataRequestWithURL:(NSString *)url httpMethod:(TBRequestHTTPMethodType)HTTPMethod httpHeader:(NSDictionary *)httpHeader requestParams:(NSDictionary *)requestParams
{
    [httpHeader enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [self.httpRequestSerializer setValue:[obj stringValue] forHTTPHeaderField:key];
        } else {
            [self.httpRequestSerializer setValue:obj forHTTPHeaderField:key];
        }
    }];
    
    return [self.httpRequestSerializer multipartFormRequestWithMethod:TBRequestHTTPMethod(HTTPMethod) URLString:url parameters:requestParams constructingBodyWithBlock:nil error:nil];
}

- (void)addUserAgentWithRequestSerializer:(AFHTTPRequestSerializer *)requestSerializer {
    NSString *userAgent = [self userAgent];
    if (userAgent) {
        if (![userAgent canBeConvertedToEncoding:NSASCIIStringEncoding]) {
            NSMutableString *mutableUserAgent = [userAgent mutableCopy];
            if (CFStringTransform((__bridge CFMutableStringRef)(mutableUserAgent), NULL, (__bridge CFStringRef)@"Any-Latin; Latin-ASCII; [:^ASCII:] Remove", false)) {
                userAgent = mutableUserAgent;
            }
        }
        [requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    }
}

#pragma mark - setter
- (void)setTimeOutInterval:(NSTimeInterval)timeOutInterval
{
    if (_timeOutInterval != timeOutInterval) {
        _timeOutInterval = timeOutInterval;
        self.httpRequestSerializer.timeoutInterval = _timeOutInterval;
        self.jsonRequestSerializer.timeoutInterval = _timeOutInterval;
    }
}

#pragma mark - getter

- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (!_httpRequestSerializer) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = self.timeOutInterval;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
        [self addUserAgentWithRequestSerializer:_httpRequestSerializer];
    }
    return _httpRequestSerializer;
}

- (AFJSONRequestSerializer *)jsonRequestSerializer
{
    if (!_jsonRequestSerializer) {
        _jsonRequestSerializer = [AFJSONRequestSerializer serializer];
        _jsonRequestSerializer.timeoutInterval = self.timeOutInterval;
        _jsonRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
        [self addUserAgentWithRequestSerializer:_jsonRequestSerializer];
    }
    return _jsonRequestSerializer;
}
@end
