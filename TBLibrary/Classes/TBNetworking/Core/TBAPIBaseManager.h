//
//  TBAPIBaseManager.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBURLResponse.h"
#import "TBURLSessionTaskManager.h"
#import "TBURLRequestGenerator.h"
#import "TBServiceBaseManager.h"

@protocol TBAPIConfigProtocol <NSObject>

@optional
/**
 *  模拟数据，在api线上接口没有完成时可以自行模拟
 */
@property (nonatomic, copy) NSDictionary *mockReturnObject;
@property (nonatomic, assign) NSTimeInterval timeOutInterval;
@property (nonatomic, copy) NSString *customURL;
@property (nonatomic, copy) NSString *methodName;
@property (nonatomic, copy) NSDictionary *customParams;
@property (nonatomic, copy) NSDictionary *customHeader;
/**
 *  用户信息，调用成功以后会返回
 */
@property (nonatomic, copy) NSDictionary *userInfo;
/**
 *  restful URI中需要替换的变量对应数据字典
 */
@property (nonatomic, copy) NSDictionary *substituteMappingDictionary;
@property (nonatomic, assign) TBRequestContentType contentType;
@property (nonatomic, assign) TBRequestHTTPMethodType httpMethod;//!<默认为get
@end

@protocol TBAPIDelegate <NSObject>

@optional

/**
 *  可用来APIManager发出请求前，检查上传的参数是否正确
 *
 *  @return 错误信息
 */
- (NSString *)getErrorForRequestParam;


/**
 *  可用来APIManager成功会回去数据后的回调，检查返回的数据的是否正确
 *
 *  @param response 可以在这里对response的内容进行修改
 *
 *  @return 是否符合之前的确定
 */
- (BOOL)checkResponse:(TBURLResponse *)response;

@end

@protocol TBModelMappingProtocol <NSObject>

@optional
/**
 *  解析返回数据
 *
 *  @param response 需要解析的数据
 *
 *  @return 解析之后的数据
 */
- (id)modelMappingFromObject:(id)response;
@end

@interface TBAPIBaseManager : NSObject <TBAPIConfigProtocol, TBAPIDelegate, TBModelMappingProtocol>

@property (nonatomic, strong) id<TBServiceProtocol> serviceConfig;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong, readonly) TBServiceBaseManager *serviceManager;

/**
 *  API的调用，会自动使用self.params做请求参数
 *
 *  @param complete  完成后的回调
 *
 *  @return requestID
 */
- (NSNumber *)loadRequestComplete:(TBRequestComplete)complete;

/**
 *  根据api的当前配置返回请求
 *
 *  @return 请求
 */
- (NSURLRequest *)generateRequest;

/**
 *  生成当前配置下所得到的url
 *
 *  @return url
 */
- (NSString *)generateURL;

/**
 *  生成request前的钩子函数
 */
- (void)beforeGenerateRequestHook;

@end
