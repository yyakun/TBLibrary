//
//  NSDate+TB.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TB)

+ (NSString *)timeIntervalFromDate:(NSDate *)date;
+ (NSDate *)dateFromTimeInterval:(NSTimeInterval)timeInterval;
+ (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval withDateFormat:(NSString *)dateFormat;
+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)dateFormat;

@end
