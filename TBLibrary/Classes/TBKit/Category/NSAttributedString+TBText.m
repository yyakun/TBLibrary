//
//  NSAttributedString+TBText.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSAttributedString+TBText.h"

@implementation NSAttributedString (TBText)

+ (NSDictionary *)attributesWithFont:(UIFont *)font textColor:(UIColor *)textColor {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    !font ?: [dictionary setObject:font forKey:NSFontAttributeName];
    !textColor ?: [dictionary setObject:textColor forKey:NSForegroundColorAttributeName];
    return dictionary;
}

@end
