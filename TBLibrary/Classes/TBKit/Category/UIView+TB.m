//
//  UIView+TB.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "UIView+TB.h"
#import "NSObject+TBRuntime.h"
#import "UIColor+TBHex.h"
#import "TBKit.h"

@implementation NSArray (TBView)

- (void)setViewsRandomBackgroundColor {
    [self makeObjectsPerformSelector:@selector(setViewRandomBackgroundColor)];
}

- (void)setViewsClearBackgroundColor {
    [self makeObjectsPerformSelector:@selector(setViewClearBackgroundColor)];
}

- (void)setViewsBackgroundColor:(UIColor *)backgroundColor {
    [self makeObjectsPerformSelector:@selector(setViewBackgroundColor:) withObject:backgroundColor];
}

- (void)addToSuperview:(UIView *)superview {
    if (self.count) {
        if (superview) {
            for (UIView *view in self) {
                [superview addSubview:view];
            }
            return;
        }
        NSLog(@"superview is nil");
        return;
    }
    NSLog(@"array is empty");
}

@end

@implementation UIView (TB)

+ (instancetype)sharedView {
    static UIView *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[UIView alloc] init];
    });
    return singleton;
}

- (void)setViewLayerCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)setViewLayerBorderWidth:(CGFloat)width borderColor:(UIColor *)borderColor {
    self.layer.borderWidth = width;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)hideView {
    if (self.superview) {
        self.hidden = YES;
        [self.superview sendSubviewToBack:self];
    } else {
        NSLog(@"view(%@ ：%@) need to be a subview", self.objectIdentifier, [self class]);
    }
}

- (void)showView {
    if (self.superview) {
        self.hidden = NO;
        [self.superview bringSubviewToFront:self];
    } else {
        NSLog(@"view(%@ ：%@) need to be a subview", self.objectIdentifier, [self class]);
    }
}

- (void)removeAllSubviews {
    if (self.subviews.count == 0) {
        NSLog(@"view(%@ ：%@) might be not a superview", self.objectIdentifier, [self class]);
        return;
    }
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)setViewRandomBackgroundColor {
    [self setViewBackgroundColor:UIColorFromRandom];
}

- (void)setViewClearBackgroundColor {
    [self setViewBackgroundColor:UIColorClear];
}

- (void)setViewBackgroundColor:(UIColor *)backgroundColor {
    self.backgroundColor = backgroundColor;
}

- (void)setViewAndSubViewsRandomBackgroundColor {
    self.backgroundColor = UIColorFromRandom;
    NSArray *views = self.subviews;
    if (views.count == 0) {
        NSLog(@"view(%@) might be not a superview", [self class]);
        return;
    }
    for (UIView *view in views) {
        if (view.subviews.count == 0) {
            view.backgroundColor = UIColorFromRandom;
            continue;
        }
        [view setViewAndSubViewsRandomBackgroundColor];
    }
}

- (void)setViewAndSubViewsClearBackgroundColor {
    self.backgroundColor = UIColorClear;
    NSArray *views = self.subviews;
    if (views.count == 0) {
        NSLog(@"view(%@) might be not a superview", [self class]);
        return;
    }
    for (UIView *view in views) {
        if (view.subviews.count == 0) {
            view.backgroundColor = UIColorClear;
            continue;
        }
        [view setViewAndSubViewsRandomBackgroundColor];
    }
}

- (UIView *)getSubviewByObjectIdentifier:(NSString *)objectIdentifier {
    if (self.subviews.count) {
        id viewObject = nil;
        for (UIView *view in self.subviews) {
            if ([view.objectIdentifier isEqualToString:objectIdentifier]) {
                viewObject = view;
            }
        }
        if (!viewObject) {
            NSLog(@"objectIdentifier(>>>：%@) might be not exist", objectIdentifier);
        }
        return viewObject;
    }
    NSLog(@"view(%@ ：%@) might be not a superview", self.objectIdentifier, [self class]);
    return nil;
}

- (void)setViewAnimationDuration:(NSTimeInterval)duration transition:(UIViewAnimationTransition)transition {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:duration];
    [UIView setAnimationTransition:transition forView:self cache:YES];
    [UIView commitAnimations];
}

@end
