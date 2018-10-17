//
//  NSNumber+TBTreatAsNSString.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSNumber+TBTreatAsNSString.h"

@implementation NSNumber (TBTreatAsNSString)

//  目前暂时添加操作字符串的最常用的这几个方法
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(isEqualToString:) || aSelector == @selector(length) || aSelector == @selector(characterAtIndex:) || aSelector == @selector(rangeOfString:)) {
        NSString *string = [NSString stringWithFormat:@"%@", self];
        return string;
    }
    return nil;
}

@end
