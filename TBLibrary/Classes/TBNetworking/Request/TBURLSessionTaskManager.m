//
//  TBURLSessionTaskManager.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBURLSessionTaskManager.h"
#import "AFHTTPSessionManager.h"
#import "TBURLResponse.h"

@interface TBURLSessionTaskManager ()

@property (nonatomic, strong) AFURLSessionManager *manager;
@property (nonatomic, strong) NSMutableDictionary *allTasks;

@end

@implementation TBURLSessionTaskManager

+ (instancetype)sharedInstance {
    static TBURLSessionTaskManager *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[TBURLSessionTaskManager alloc] initUseInner];
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
        _allTasks = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - outer interface
- (NSUInteger)requestWithURLRequest:(NSURLRequest *)request userInfo:(NSDictionary *)userInfo complete:(TBRequestComplete)complete {
    __weak typeof(userInfo) weakUserInfo = userInfo;
    __weak typeof(self) weakself = self;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    __block NSURLSessionDataTask *task = [self.manager dataTaskWithRequest:request
                                                         completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
                                                             if ([weakself isCancel:@(task.taskIdentifier)]) {
#pragma clang diagnostic pop
                                                                 return ;
                                                             }
                                                             __strong typeof(weakUserInfo) strongUserInfo = weakUserInfo;
                                                             TBURLResponse *urlResponse = [[TBURLResponse alloc] init];
                                                             urlResponse.userInfo = strongUserInfo;
                                                             urlResponse.response = response;
                                                             urlResponse.returnObject = responseObject;
                                                             if (error) {
                                                                 urlResponse.responseStatusCode = TBResponseStatusCodeErrorReturn;
                                                                 if (error.domain == AFURLResponseSerializationErrorDomain) {
                                                                     urlResponse.responseStatusCode = TBResponseStatusCodeErrorFormat;
                                                                 }
                                                             } else {
                                                                 urlResponse.responseStatusCode = TBResponseStatusCodeSuccess;
                                                             }
                                                             complete ? complete(urlResponse, error) : nil;
                                                         }];
    [task resume];
    self.allTasks[@(task.taskIdentifier)] = task;
    return task.taskIdentifier;
}

- (void)cancelRequestWithTaskIdentifier:(NSNumber *)taskIdentifier {
    NSURLSessionTask *task = self.allTasks[taskIdentifier];
    if (task) {
        [task cancel];
        [self removeTaskWithTaskIdentifier:taskIdentifier];
    }
}

#pragma mark - inner methods
- (BOOL)isCancel:(NSNumber *)taskIdentifier {
    NSURLSessionTask *task = self.allTasks[taskIdentifier];
    if (task) {
        [self removeTaskWithTaskIdentifier:taskIdentifier];
        return NO;
    }
    return YES;
}

- (void)removeTaskWithTaskIdentifier:(NSNumber *)taskIdentifier {
    if (taskIdentifier) {
        [self.allTasks removeObjectForKey:taskIdentifier];
    }
}

#pragma mark - getter
- (AFURLSessionManager *)manager {
    if (!_manager) {
        _manager = [[AFURLSessionManager alloc] init];
    }
    return _manager;
}

@end
