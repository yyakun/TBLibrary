//
//  TBURLRequestGenerator.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  http请求的Content-Type类型
 */
typedef NS_ENUM(NSInteger, TBRequestContentType) {
    TBRequestContentTypeURLEncode = 0,
    TBRequestContentTypeFormData,
    TBRequestContentTypeJson
};

/**
 *  restful风格中对远程资源的操作类型
 */
typedef NS_ENUM(NSInteger, TBRequestHTTPMethodType) {
    TBRequestHTTPMethodPOST = 0,
    TBRequestHTTPMethodGET,
    TBRequestHTTPMethodPUT,
    TBRequestHTTPMethodDELETE
};

/**
 *  该类用于根据上层需求生成NSURLRequest
 */
@interface TBURLRequestGenerator : NSObject

+ (instancetype)sharedInstance;

/**
 *  timeout时间
 *  所有请求一致，不对某个请求做单独设置
 *  默认20秒
 */
@property (nonatomic, assign) NSTimeInterval timeOutInterval;

/**
 *  生产NSURLRequest的生产方法
 *
 *  @param url           http请求的url
 *  @param contentType   TBRequestContentType
 *  @param httpMethod    TBRequestHTTPMethodType
 *  @param httpHeader    需要添加到http请求头中的信息
 *  @param requestParams http请求中得参数
 *
 *  @return 按需生成的NSURLRequest
 */
- (NSURLRequest *)generateRequestWithURL:(NSString *)url contentType:(TBRequestContentType)contentType httpMethod:(TBRequestHTTPMethodType)httpMethod httpHeader:(NSDictionary *)httpHeader requestParams:(NSDictionary *)requestParams;
@end
