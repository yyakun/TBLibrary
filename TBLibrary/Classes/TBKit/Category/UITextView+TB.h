//
//  UITextView+TB.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/7/12.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (TB)

- (void)setPlaceholderWithText:(NSString *)text color:(UIColor *)color;
/**
 设置textView placeholder
 
 @param text 文字
 @param textColor 颜色
 @param font 字体
 */
- (void)addPlaceholderWithText:(NSString *)text
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font;

@end
