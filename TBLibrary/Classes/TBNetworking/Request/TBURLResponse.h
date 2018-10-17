//
//  TBURLResponse.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TBResponseStatusCode) {
    TBResponseStatusCodeSuccess = 0,                 /**< api格式返回正确  **/
    TBResponseStatusCodeErrorParam = 2000,          /**< 上传参数错误  **/
    TBResponseStatusCodeErrorRequest = 2001,        /**< request失败  **/
    TBResponseStatusCodeErrorFormat = 2002,         /**< api返回数据编码错误  **/
    TBResponseStatusCodeErrorJSON = 2003,           /**< 转换JSON失败  **/
    TBResponseStatusCodeErrorReturn = 2004,         /**< 返回数据主体结构错误  **/
    TBResponseStatusCodeErrorData = 2005,           /**< 返回数据业务结构错误  **/
    TBResponseStatusCodeErrorUnauthorized = 2006,   /**< 权限不足  **/
    //其他错误之后和服务器接口端协商
};

@interface TBURLResponse : NSObject
/**
 *  发送请求时设置的数据
 */
@property (nonatomic, copy) NSDictionary *userInfo;
/**
 *  服务器、客户端约束的错误类型
 */
@property (nonatomic, assign) TBResponseStatusCode responseStatusCode;
/**
 *  一些服务器回传的信息，一般用于弹用户提示
 */
@property (nonatomic, copy) NSString *message;
/**
 *  服务器返回的数据
 */
@property (nonatomic, copy) NSURLResponse *response;
/**
 *  ResponseSerialization解析过的对象
 */
@property (nonatomic, strong) id returnObject;

@end
