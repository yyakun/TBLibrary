//
//  TBAPIServiceSettingManager.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBAPIServiceSettingManager.h"

NSString * const TBNetworkingAPIIsOnline = @"net.evergrande.nettingworking.isOnlineApi";

@implementation TBAPIServiceSettingManager

@synthesize isOnlineApi = _isOnlineApi;

#pragma mark - initial

+ (instancetype)sharedInstance {
    static TBAPIServiceSettingManager *settingManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        settingManager = [[TBAPIServiceSettingManager alloc] initUseInner];
    });
    return settingManager;
}

- (instancetype)init {
    NSAssert(NO, @"换条路吧，别用这个了");
    return nil;
}

- (instancetype)initUseInner {
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - setter & getter

- (void)setIsOnlineApi:(BOOL)isOnlineApi {
    _isOnlineApi = isOnlineApi;
    [[NSUserDefaults standardUserDefaults] setObject:@(_isOnlineApi) forKey:TBNetworkingAPIIsOnline];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isOnlineApi {
    if (!_isOnlineApi) {
        NSNumber *cachedData = [[NSUserDefaults standardUserDefaults] objectForKey:TBNetworkingAPIIsOnline];
        if (!cachedData) {
            cachedData = @(YES);
        }
        _isOnlineApi = [cachedData boolValue];
    }
    return _isOnlineApi;
}

@end
