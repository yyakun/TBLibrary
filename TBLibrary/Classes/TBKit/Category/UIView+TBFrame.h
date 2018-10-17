//
//  UIView+TBFrame.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidth  [UIView fullScreenWidth]
#define kScreenHeight  [UIView fullScreenHeight]

#define SP_iPhone5_Width(width) ((width) / 320.0 * kScreenWidth)
#define SP_iPhone5_Height(height) ((height) / 568.0 * kScreenHeight)
#define SP_iPhone6_Width(width) ((width) / 375.0 * kScreenWidth)
#define SP_iPhone6_Height(height) ((height) / 667.0 * kScreenHeight)

#define kStatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
#define kNavBarHeight 44.0
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height > 20 ? 83 : 49)
#define kTopHeight (kStatusBarHeight + kNavBarHeight)

@interface UIView (TBFrame)

+ (CGFloat)fullScreenWidth;
+ (CGFloat)fullScreenHeight;

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

- (void)setTop:(CGFloat)top;
- (void)setLeft:(CGFloat)left;
- (void)setBottom:(CGFloat)bottom;
- (void)setRight:(CGFloat)right;

- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;

- (void)setOrigin:(CGPoint)origin;
- (void)setSize:(CGSize)size;

- (void)setLeftTop:(CGPoint)leftTop;
- (void)setLeftBottom:(CGPoint)leftBottom;
- (void)setRightTop:(CGPoint)rightTop;
- (void)setRightBottom:(CGPoint)rightBottom;


- (CGFloat)x;
- (CGFloat)y;

- (CGFloat)top;
- (CGFloat)left;
- (CGFloat)bottom;
- (CGFloat)right;

- (CGFloat)width;
- (CGFloat)height;

- (CGFloat)centerX;
- (CGFloat)centerY;

- (CGPoint)origin;
- (CGSize)size;

- (CGPoint)leftTop;
- (CGPoint)leftBottom;
- (CGPoint)rightTop;
- (CGPoint)rightBottom;

@end

@interface CALayer (TBFrame)

- (void)setX:(CGFloat)x;
- (void)setY:(CGFloat)y;

- (void)setTop:(CGFloat)top;
- (void)setLeft:(CGFloat)left;
- (void)setBottom:(CGFloat)bottom;
- (void)setRight:(CGFloat)right;

- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;

- (void)setCenterX:(CGFloat)centerX;
- (void)setCenterY:(CGFloat)centerY;

- (void)setOrigin:(CGPoint)origin;
- (void)setSize:(CGSize)size;

- (void)setLeftTop:(CGPoint)leftTop;
- (void)setLeftBottom:(CGPoint)leftBottom;
- (void)setRightTop:(CGPoint)rightTop;
- (void)setRightBottom:(CGPoint)rightBottom;

- (CGFloat)x;
- (CGFloat)y;

- (CGFloat)top;
- (CGFloat)left;
- (CGFloat)bottom;
- (CGFloat)right;

- (CGFloat)width;
- (CGFloat)height;

- (CGFloat)centerX;
- (CGFloat)centerY;

- (CGPoint)origin;
- (CGSize)size;

- (CGPoint)leftTop;
- (CGPoint)leftBottom;
- (CGPoint)rightTop;
- (CGPoint)rightBottom;

@end
