//
//  UIView+TBAutoLayout.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "UIView+TBAutoLayout.h"

@implementation NSArray (TBAutoLayout)

- (void)setViewsAutoAlignInSuperview:(TBAutoLayoutAlignType)alignType {
    for (UIView *view in self) {
        [view autoAlignInSuperview:alignType];
    }
}

- (void)setViewsAutoAlignRelatedView:(UIView *)relatedView align:(TBAutoLayoutAlignType)alignType {
    for (UIView *view in self) {
        [view autoAlign:alignType relatedView:relatedView constant:0.0f];
    }
}

- (void)setViewsAutoAlign:(TBAutoLayoutAlignType)alignType relatedView:(UIView *)relatedView constant:(CGFloat)constant {
    for (UIView *view in self) {
        [view autoAlign:alignType relatedView:relatedView constant:constant];
    }
}

- (void)setViewsAutoAlign:(TBAutoLayoutAlignType)alignType relatedView:(UIView *)relatedView alignType:(TBAutoLayoutAlignType)alignType2 constant:(CGFloat)constant {
    for (UIView *view in self) {
        [view autoAlign:alignType relatedView:relatedView relatedAlign:alignType2 constant:constant];
    }
}

@end

@implementation UIView (TBAutoLayout)

#pragma mark - for self
- (void)useAutoLayout {
    self.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)autoCenterInSuperview {
    [self autoAlignInSuperview:TBAutoLayoutAlignCenterX];
    [self autoAlignInSuperview:TBAutoLayoutAlignCenterY];
}

- (NSLayoutConstraint *)autoAlignInSuperview:(TBAutoLayoutAlignType)alignType {
    return [self autoAlignInSuperview:alignType constant:0.0f];
}

- (void)addFullContentView:(UIView *)contentView {
    [self addContentView:contentView insets:UIEdgeInsetsZero];
}

- (void)addContentView:(UIView *)contentView insets:(UIEdgeInsets)insets {
    NSDictionary *view = NSDictionaryOfVariableBindings(contentView);
    NSDictionary *metrics = @{@"top": @(insets.top), @"left": @(insets.left), @"bottom": @(insets.bottom), @"right": @(insets.right)};
    NSString *H01 = @"H:|-left-[contentView]-right-|";
    NSString *V01 = @"V:|-top-[contentView]-bottom-|";
    [self autoAddConstraintsWithVisualFormatArray:@[H01, V01] options:0 metrics:metrics views:view];
}

- (NSLayoutConstraint *)autoAlignInSuperview:(TBAutoLayoutAlignType)alignType constant:(CGFloat)constant {
    UIView *superview = self.superview;
    NSAssert(superview, @"View's superview must not be nil.\nView: %@", self);
    return [self autoAlign:alignType relatedView:superview constant:constant];
}

- (NSLayoutConstraint *)autoAlign:(TBAutoLayoutAlignType)alignType relatedView:(UIView *)relatedView constant:(CGFloat)constant {
    return [self autoAlign:alignType relatedView:relatedView rate:1.0f constant:constant];
}

- (NSLayoutConstraint *)autoAlign:(TBAutoLayoutAlignType)alignType relatedView:(UIView *)relatedView rate:(CGFloat)rate constant:(CGFloat)constant {
    UIView *superview = self.superview;
    NSAssert(superview, @"View's superview must not be nil.\nView: %@", self);
    NSLayoutConstraint *layoutConstraint = [NSLayoutConstraint constraintWithItem:self attribute:(NSLayoutAttribute)alignType relatedBy:NSLayoutRelationEqual toItem:relatedView attribute:(NSLayoutAttribute)alignType multiplier:rate constant:constant];
    [superview addConstraint:layoutConstraint];
    return layoutConstraint;
}

- (NSLayoutConstraint *)autoAlignRelatedMainView:(TBAutoLayoutAlignType)alignType relatedAlign:(TBAutoLayoutAlignType)relatedAlign constant:(CGFloat)constant {
    UIView *superview = self.superview;
    NSAssert(superview, @"View's superview must not be nil.\nView: %@", self);
    UIView *realSuperview = nil;
    while (superview) {
        realSuperview = superview;
        superview = superview.superview;
    }
    NSLayoutConstraint *layoutConstraint = [NSLayoutConstraint constraintWithItem:self attribute:(NSLayoutAttribute)alignType relatedBy:NSLayoutRelationEqual toItem:realSuperview attribute:(NSLayoutAttribute)relatedAlign multiplier:1.0f constant:constant];
    [realSuperview addConstraint:layoutConstraint];
    return layoutConstraint;
}

- (NSLayoutConstraint *)autoAlign:(TBAutoLayoutAlignType)alignType relatedView:(UIView *)relatedView relatedAlign:(TBAutoLayoutAlignType)relatedAlign constant:(CGFloat)constant {
    UIView *superview = self.superview;
    NSAssert(superview, @"View's superview must not be nil.\nView: %@", self);
    NSLayoutConstraint *layoutConstraint = [NSLayoutConstraint constraintWithItem:self attribute:(NSLayoutAttribute)alignType relatedBy:NSLayoutRelationEqual toItem:relatedView attribute:(NSLayoutAttribute)relatedAlign multiplier:1.0f constant:constant];
    [superview addConstraint:layoutConstraint];
    return layoutConstraint;
}

- (void)autoMatchSizeWithWidth:(CGFloat)width height:(CGFloat)heigth {
    [self autoMatchSizeType:TBAutoLayoutSizeWidth constant:width];
    [self autoMatchSizeType:TBAutoLayoutSizeHeight constant:heigth];
}

- (NSLayoutConstraint *)autoMatchSizeType:(TBAutoLayoutSizeType)sizeType constant:(CGFloat)constant {
    return [self autoMatchSizeType:sizeType relatedView:nil sizeType2:TBAutoLayoutSizeNotAnAttribute rate:0.0f constant:constant];
}

- (NSLayoutConstraint *)autoMatchSizeType:(TBAutoLayoutSizeType)sizeType1 sizeType2:(TBAutoLayoutSizeType)sizeType2 rate:(CGFloat)rate {
    UIView *superview = self.superview;
    NSAssert(superview, @"View's superview must not be nil.\nView: %@", self);
    NSLayoutConstraint *layoutConstraint = [NSLayoutConstraint constraintWithItem:self attribute:(NSLayoutAttribute)sizeType1 relatedBy:NSLayoutRelationEqual toItem:self attribute:(NSLayoutAttribute)sizeType2 multiplier:rate constant:.0];
    [superview addConstraint:layoutConstraint];
    return layoutConstraint;
}

- (NSLayoutConstraint *)autoMatchSizeType:(TBAutoLayoutSizeType)sizeType1 relatedView:(UIView *)relatedView  sizeType2:(TBAutoLayoutSizeType)sizeType2 rate:(CGFloat)rate constant:(CGFloat)constant {
    UIView *superview = self.superview;
    NSAssert(superview, @"View's superview must not be nil.\nView: %@", self);
    NSLayoutConstraint *layoutConstraint = [NSLayoutConstraint constraintWithItem:self attribute:(NSLayoutAttribute)sizeType1 relatedBy:NSLayoutRelationEqual toItem:relatedView attribute:(NSLayoutAttribute)sizeType2 multiplier:rate constant:constant];
    [superview addConstraint:layoutConstraint];
    return layoutConstraint;
}

- (void)clearAllConstraints {
    [self removeConstraints:self.constraints];
    for (UIView *sub in [self subviews]) {
        [sub clearAllConstraints];
    }
}

#pragma mark - for superView
- (void)autoAddConstraintsWithVisualFormatArray:(NSArray *)formatArray options:(NSLayoutFormatOptions)opts metrics:(NSDictionary *)metrics views:(NSDictionary *)views {
    for (NSString *format in formatArray) {
        NSAssert([format isKindOfClass:[NSString class]], @"formatArr must be array of NSString");
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:format options:opts metrics:metrics views:views]];
    }
}

- (void)autoAddConstraintsWithVisualFormatArray:(NSArray *)formatArray optionsArray:(NSArray *)optsArray metrics:(NSDictionary *)metrics views:(NSDictionary *)views {
    [formatArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLayoutFormatOptions opts = [[optsArray objectAtIndex:idx] integerValue];
        NSAssert([obj isKindOfClass:[NSString class]], @"formatArr must be array of NSString");
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:obj options:opts metrics:metrics views:views]];
    }];
}

@end
