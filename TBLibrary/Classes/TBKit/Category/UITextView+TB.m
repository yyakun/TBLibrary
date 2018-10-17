//
//  UITextView+TB.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/7/12.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "UITextView+TB.h"
#import <objc/runtime.h>

@implementation UITextView (TB)

+ (void)load {
    // 获取类方法 class_getClassMethod
    // 获取对象方法 class_getInstanceMethod
    Method setFontMethod = class_getInstanceMethod(self, @selector(setFont:));
    Method was_setFontMethod = class_getInstanceMethod(self, @selector(was_setFont:));
    
    // 交换方法的实现
    method_exchangeImplementations(setFontMethod, was_setFontMethod);
}

- (void)was_setFont:(UIFont *)font{
    // 调用原方法 setFont:
    [self was_setFont:font];
    // 设置占位字符串的font
    UILabel *label = [self valueForKey:@"_placeholderLabel"];
    label.font = font;
}

- (void)setPlaceholderWithText:(NSString *)text color:(UIColor *)color {
    // 设置占位label
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.font = self.font;
    label.textColor = color;
    
    [self addSubview:label];
    // 通过运行时，发现UITextView有一个叫做“_placeHolderLabel”的私有变量
    
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 8.3) {
        [self setValue:label forKey:@"_placeholderLabel"];
    }
}

/**
 设置textView placeholder
 
 @param text 文字
 @param textColor 颜色
 @param font 字体
 */
- (void)addPlaceholderWithText:(NSString *)text
                     textColor:(UIColor *)textColor
                          font:(UIFont *)font {
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = text;
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = textColor;
    [placeHolderLabel sizeToFit];
    [self addSubview:placeHolderLabel];
    // same font
    placeHolderLabel.font = font;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.3) {
        [self setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    }
}

@end
