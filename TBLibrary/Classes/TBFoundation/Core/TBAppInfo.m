//
//  TBAppInfo.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBAppInfo.h"
#import "NSObject+TB.h"
#import "TBUDIDGenerator.h"

@implementation TBAppInfo

+ (NSDictionary *)infoDictionary {
    return [[NSBundle mainBundle] infoDictionary];
}

+ (NSString *)appBundleIdentifier {
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)appName {
    NSString *appName = [[self infoDictionary] objectForKey:@"CFBundleDisplayName"];
    return (!appName || appName.length == 0) ? [[TBUDIDGenerator sharedInstance] appBundleName] : appName;
}

+ (NSString *)appVersion {
    NSString *appVersion = [[self infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return (!appVersion || appVersion.length == 0) ? @"0.0" : appVersion;
}

+ (NSString *)appBuildVersion {
    NSString *appBuildVersion = [[self infoDictionary] objectForKey:@"CFBundleVersion"];
    return appBuildVersion.length == 0 ? @"0" : appBuildVersion;
}

@end
