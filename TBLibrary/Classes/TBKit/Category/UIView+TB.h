//
//  UIView+TB.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSArray (TBView)

- (void)setViewsRandomBackgroundColor;//  设置一组视图的背景颜色为随机色
- (void)setViewsClearBackgroundColor;//  设置一组视图的背景颜色为透明色
- (void)setViewsBackgroundColor:(UIColor *)backgroundColor;
- (void)addToSuperview:(UIView *)superview;//  添加一组视图到父视图上

@end

@interface UIView (TB)

+ (instancetype)sharedView;

- (void)setViewLayerCornerRadius:(CGFloat)radius;
- (void)setViewLayerBorderWidth:(CGFloat)width borderColor:(UIColor *)borderColor;

- (void)hideView;
- (void)showView;
- (void)removeAllSubviews;

- (void)setViewRandomBackgroundColor;
- (void)setViewClearBackgroundColor;
- (void)setViewBackgroundColor:(UIColor *)backgroundColor;

- (void)setViewAndSubViewsRandomBackgroundColor;
- (void)setViewAndSubViewsClearBackgroundColor;

- (UIView *)getSubviewByObjectIdentifier:(NSString *)objectIdentifier;

- (void)setViewAnimationDuration:(NSTimeInterval)duration transition:(UIViewAnimationTransition)transition;

@end
