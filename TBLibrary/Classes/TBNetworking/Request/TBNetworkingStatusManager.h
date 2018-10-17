//
//  TBNetworkingStatusManager.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/7/3.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBNetworkingStatusManager : NSObject

+ (void)reachability:(void (^)(BOOL isAvailable))completion;

@end
