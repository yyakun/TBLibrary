//
//  UIView+TBFrame.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "UIView+TBFrame.h"

@implementation UIView (TBFrame)

#pragma mark - screen size
+ (CGFloat)fullScreenWidth {
    return [[UIScreen mainScreen] bounds].size.width;
}

+ (CGFloat)fullScreenHeight {
    return [[UIScreen mainScreen] bounds].size.height;
}

#pragma mark - setter
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.height;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - self.width;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.centerY);
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.centerX, centerY);
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setLeftTop:(CGPoint)leftTop {
    CGRect frame = self.frame;
    frame.origin.x = leftTop.x;
    frame.origin.y = leftTop.y;
    self.frame = frame;
}

- (void)setLeftBottom:(CGPoint)leftBottom {
    CGRect frame = self.frame;
    frame.origin.x = leftBottom.x;
    frame.origin.y = leftBottom.y - self.height;
    self.frame = frame;
}

- (void)setRightTop:(CGPoint)rightTop {
    CGRect frame = self.frame;
    frame.origin.x = rightTop.x - self.width;
    frame.origin.y = rightTop.y;
    self.frame = frame;
}

- (void)setRightBottom:(CGPoint)rightBottom {
    CGRect frame = self.frame;
    frame.origin.x = rightBottom.x - self.width;
    frame.origin.y = rightBottom.y - self.height;
    self.frame = frame;
}

#pragma mark - getter
- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)centerX {
    return self.left + self.width/2.0f;
}

- (CGFloat)centerY {
    return self.top + self.height/2.0f;
}

- (CGPoint)origin {
    return CGPointMake(self.left, self.top);
}

- (CGSize)size {
    return CGSizeMake(self.width, self.height);
}

- (CGPoint)leftTop {
    return self.origin;
}

- (CGPoint)leftBottom {
    return CGPointMake(self.left, self.bottom);
}

- (CGPoint)rightTop {
    return CGPointMake(self.right, self.top);
}

- (CGPoint)rightBottom {
    return CGPointMake(self.right, self.bottom);
}

@end

@implementation CALayer (TBFrame)

#pragma mark - setter
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setTop:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}

- (void)setLeft:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - self.height;
    self.frame = frame;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - self.width;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setCenterX:(CGFloat)centerX {
    CGRect frame = self.frame;
    frame.origin.x = centerX - self.anchorPoint.x * self.width;
    self.frame = frame;
}

- (void)setCenterY:(CGFloat)centerY {
    CGRect frame = self.frame;
    frame.origin.y = centerY - self.anchorPoint.y * self.height;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setLeftTop:(CGPoint)leftTop {
    CGRect frame = self.frame;
    frame.origin.x = leftTop.x;
    frame.origin.y = leftTop.y;
    self.frame = frame;
}

- (void)setLeftBottom:(CGPoint)leftBottom {
    CGRect frame = self.frame;
    frame.origin.x = leftBottom.x;
    frame.origin.y = leftBottom.y - self.height;
    self.frame = frame;
}

- (void)setRightTop:(CGPoint)rightTop {
    CGRect frame = self.frame;
    frame.origin.x = rightTop.x - self.width;
    frame.origin.y = rightTop.y;
    self.frame = frame;
}

- (void)setRightBottom:(CGPoint)rightBottom {
    CGRect frame = self.frame;
    frame.origin.x = rightBottom.x - self.width;
    frame.origin.y = rightBottom.y - self.height;
    self.frame = frame;
}

#pragma mark - getter
- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (CGFloat)centerX {
    return self.left + self.width/2.0f;
}

- (CGFloat)centerY {
    return self.top + self.height/2.0f;
}

- (CGPoint)origin {
    return CGPointMake(self.left, self.top);
}

- (CGSize)size {
    return CGSizeMake(self.width, self.height);
}

- (CGPoint)leftTop {
    return self.origin;
}

- (CGPoint)leftBottom {
    return CGPointMake(self.left, self.bottom);
}

- (CGPoint)rightTop {
    return CGPointMake(self.right, self.top);
}

- (CGPoint)rightBottom {
    return CGPointMake(self.right, self.bottom);
}

@end
