//
//  UIView+MotionEffect.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/7/27.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MotionEffect)

@property (nonatomic, strong) UIMotionEffectGroup  *effectGroup;

- (void)addXAxisWithValue:(CGFloat)xValue YAxisWithValue:(CGFloat)yValue;
- (void)removeSelfMotionEffect;

@end
