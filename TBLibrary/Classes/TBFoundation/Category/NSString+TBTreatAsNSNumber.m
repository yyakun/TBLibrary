//
//  NSString+TBTreatAsNSNumber.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSString+TBTreatAsNSNumber.h"

@implementation NSString (TBTreatAsNSNumber)

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(isEqualToNumber:)) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *number = [formatter numberFromString:self];
        return number;
    }
    return nil;
}

@end
