//
//  TBAPIServiceSettingManager.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TBAPIServiceSettingManager : NSObject

+ (instancetype)sharedInstance;

/**
 *  是否取线上API
 */
@property (nonatomic, assign) BOOL isOnlineApi;

@end
