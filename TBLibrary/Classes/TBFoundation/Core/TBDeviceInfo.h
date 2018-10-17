//
//  TBDeviceInfo.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBDeviceInfo : NSObject

+ (NSString *)deviceUDID;//  设备唯一标示
+ (NSString *)deviceHostName;
+ (NSString *)deviceTotalDiskspace;//设备总存储空间大小
+ (NSString *)deviceFreeDiskspace;//设备剩余存储空间大小

+ (NSString *)deviceUUID;//  设备（手机）序列号
+ (NSString *)deviceName;//  设备（手机）别名：用户自定义的名称
+ (NSString *)deviceSystemName;//  设备（手机）名称
+ (NSString *)deviceSystemVersion;//  设备（手机）系统版本
+ (NSString *)deviceModel;//  设备（手机）型号
+ (NSString *)deviceLocalizedModel;//  地方型号（国际化区域名称）
+ (NSString *)deviceIPhoneType;//  设备（手机）型号

+ (UIDeviceBatteryState)deviceBatteryState;//  电池状态
+ (BOOL)deviceIsPlus;//  设备是不是plus

@end
