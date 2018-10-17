//
//  TBServiceBaseManager.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBServiceBaseManager.h"
#import "TBAPIServiceSettingManager.h"

@implementation TBServiceBaseManager

- (BOOL)isOnline {
    if (!self.serviceConfig.isOnline) {
        return [[TBAPIServiceSettingManager sharedInstance] isOnlineApi];
    }
    return [self.serviceConfig.isOnline boolValue];
}

- (NSString *)apiDomain {
    return [self isOnline] ? self.serviceConfig.onlineApiDomain : self.serviceConfig.offlineApiDomain;
}

- (NSString *)apiWebDomain {
    return [self isOnline] ? self.serviceConfig.onlineApiWebDomain : self.serviceConfig.offlineApiWebDomain;
}

- (NSString *)apiServiceName {
    return [self isOnline] ? self.serviceConfig.onlineServiceName : self.serviceConfig.offlineServiceName;
}

- (NSString *)publicKey {
    return [self isOnline] ? self.serviceConfig.onlinePublicKey : self.serviceConfig.offlinePublicKey;
}

- (NSString *)privateKey {
    return [self isOnline] ? self.serviceConfig.onlinePrivateKey : self.serviceConfig.offlinePrivateKey;
}

- (void)setServiceConfig:(id<TBServiceProtocol>)serviceConfig {
    if ([serviceConfig conformsToProtocol:@protocol(TBServiceProtocol)]) {
        _serviceConfig = serviceConfig;
    } else {
        _serviceConfig = nil;
    }
}

@end
