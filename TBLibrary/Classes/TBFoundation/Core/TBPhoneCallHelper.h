//
//  TBPhoneCallHelper.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  拨打失败以后默认的接通时间
 *  any value less than 0
 */
FOUNDATION_EXTERN NSInteger const TBPHONECALLFAILEDTIME;

/**
 *  拨号完成的回调方法
 *
 *  CFAbsoluteTime类型的参数为通话时间，如果通话时间小于0表示电话未拨出
 */
typedef void (^TBPhoneCallOverBlock) (NSInteger);

@interface TBPhoneCallHelper : NSObject

/**
 *  单例实例获取方法
 *
 *  @return 单例实例
 */
+ (instancetype)sharedInstance;

/**
 *  检查设备是否支持电话通讯
 *
 *  @return 设备是否支持电话通讯
 */
- (BOOL)supportPhoneFunction;

/**
 *  打电话
 *
 *  @param phoneNumber 需要拨通的电话号码
 *  @param completion  拨号完成的回调方法
 */
- (void)call:(NSString *)phoneNumber completion:(TBPhoneCallOverBlock)completion;

@end
