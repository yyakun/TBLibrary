//
//  UIColor+TBHex.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (TBHex)

/**
 *  通过16进制数字创建颜色，hex格式应为0x开头，如：0xff55ec
 */
+ (UIColor *)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha;

/**
 *  获取颜色的hex值，hex字符串格式应为#开头，如：#ee33aa
 */
+ (NSString *)hexWithColor:(UIColor *)color;

/**
 *  创建随机颜色
 */
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;

@end
