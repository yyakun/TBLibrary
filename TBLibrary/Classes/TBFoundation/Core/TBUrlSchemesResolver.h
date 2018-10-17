//
//  TBUrlSchemesResolver.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TBUrlSchemesResolver <NSObject>

/**
 *  服务器返回的属性与本地属性不对等的列表，以 服务器属性名:本地属性名 为一个单元
 *  如果服务器与本地属性相同不需要加入此列表
 *
 *  这是一个钩子方法，解析器会判断类中是否实现该方法，不一定需要实现这个接口
 *  类中如果存在属性名与服务器不一致的情况，需要在类中实现本方法
 *
 *  @return 差异属性名称列表
 */
- (NSDictionary *)discrepantKeys;

@end

@interface NSString (TBURLQueryResolver)

/**
 *  解析URL中得参数
 *
 *  @return 参数、参数值对应的字典
 */
- (NSDictionary *)QR_queryItems;

/**
 *  url decode
 *
 *  @return decode过的url string
 */
- (NSString *)QR_urlDecode;

/**
 *  url encode
 *
 *  @return encode过的url string
 */
- (NSString *)QR_urlEncode;

@end

@interface TBUrlSchemesResolver : NSObject

+ (id)createObjectFromUrlScheme:(NSString *)urlScheme;

@end
