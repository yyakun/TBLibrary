//
//  NSDate+TB.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSDate+TB.h"

@implementation NSDate (TB)

+ (NSString *)timeIntervalFromDate:(NSDate *)date {
    return [NSString stringWithFormat:@"%.0f", [date timeIntervalSince1970] * 1000];
}

+ (NSDate *)dateFromTimeInterval:(NSTimeInterval)timeInterval {
    return [NSDate dateWithTimeIntervalSince1970:timeInterval/1000.f];
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)timeInterval withDateFormat:(NSString *)dateFormat {
    return [NSDate stringFromDate:[NSDate dateFromTimeInterval:timeInterval] withDateFormat:dateFormat];
}

+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    dateFormatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
    dateFormatter.dateFormat = dateFormat;
    return [dateFormatter stringFromDate:date];
}

@end
