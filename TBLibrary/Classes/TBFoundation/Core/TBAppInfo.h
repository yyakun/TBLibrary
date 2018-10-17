//
//  TBAppInfo.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBAppInfo : NSObject

+ (NSDictionary *)infoDictionary;

+ (NSString *)appBundleIdentifier;//  应用程序的唯一标识符
+ (NSString *)appName;//  应用程序的名字，如：支付宝、微信
+ (NSString *)appVersion;//  应用程序的发布版本
+ (NSString *)appBuildVersion;//  应用程序的开发版本，一般是遵循：开发版本 > 发布版本

@end
