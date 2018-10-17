//
//  TBServiceProtocol.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TBURLResponse;

@protocol TBServiceProtocol <NSObject>

@required
/**
 *  是否调用线上API
 */
- (NSNumber *)isOnline;

- (NSString *)offlineApiDomain;
- (NSString *)offlineApiWebDomain;
- (NSString *)offlineServiceName;
- (NSString *)offlinePublicKey;
- (NSString *)offlinePrivateKey;

- (NSString *)onlineApiDomain;
- (NSString *)onlineApiWebDomain;
- (NSString *)onlineServiceName;
- (NSString *)onlinePublicKey;
- (NSString *)onlinePrivateKey;

@optional

/**
 *  共用参数信息
 */
@property (nonatomic, strong) NSDictionary *commonRequestParams;
/**
 *  共用header信息
 */
@property (nonatomic, strong) NSDictionary *commonRequestHeader;
/**
 *  指定本地化语言文件
 *
 *  @return 文件名（不包括后缀名.strings）
 */
@property (nonatomic, copy) NSString *NSLocalizedFileName;

/**
 *  可用来APIManager成功会回去数据后的回调，检查返回的数据的是否正确只要正对是code，结构上
 *
 *  @param response 返回的数据字典
 *
 *  @return 是否符合之前的确定
 */
- (BOOL)checkReturnStructureIsOK:(TBURLResponse *)response;

/**
 *  自定义网络层错误信息
 */
- (NSString *)getHttpMessageWithResponse:(TBURLResponse *)response;

/**
 *  根据错误码返回错误描述
 *
 *  @param statusCode 错误码或者返回的error code
 *
 *  @return 对应的错误描述
 */
- (NSString *)getLocalizedDescriptionWithStatusCode:(NSInteger)statusCode;

@end
