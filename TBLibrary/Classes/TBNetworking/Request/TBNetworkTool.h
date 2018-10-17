//
//  TBNetworkTool.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBNetworkTool : NSObject

+ (void)uploadImageWithURLString:(NSString *)urlString parameters:(NSDictionary *)dict images:(NSArray *)images names:(NSArray *)names completion:(void(^)(id responseObject))block;

/**
 方便C#语言写的WebService接口的网络请求，关键是对soap字符串的理解和拼接。

 @param urlString 接口url, 如: http://carsapi.dadahuoche.com:9000/?wsdl
 @param soapString soap格式的字符串
 @param separatedString 用来提取XML字符串里的一段关键值，如：<ApiResult>xxx</ApiResult>里的 <ApiResult>
 @param httpHeaderField 请求Head
 @param block 可以把关键字符串通过block回调返回
 */
+ (void)webServiceRequestWithURLString:(NSString *)urlString soapString:(NSString *)soapString separatedString:(NSString *)separatedString httpHeaderField:(NSDictionary *)httpHeaderField completion:(void(^)(NSString *responseString))block;

@end
