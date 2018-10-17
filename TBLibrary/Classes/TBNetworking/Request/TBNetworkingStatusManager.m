//
//  TBNetworkingStatusManager.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/7/3.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBNetworkingStatusManager.h"
#import "AFNetworkReachabilityManager.h"

@implementation TBNetworkingStatusManager

+ (void)reachability:(void (^)(BOOL isAvailable))completion {
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 连接状态回调处理
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
            switch (status) {
                case AFNetworkReachabilityStatusUnknown:
                    completion ? completion(YES) : nil;
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                    completion ? completion(NO) : nil;
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    completion ? completion(YES) : nil;
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    completion ? completion(YES) : nil;
                    break;
                default:
                    break;
            }
        }];
    });
}

@end
