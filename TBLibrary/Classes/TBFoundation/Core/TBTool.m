//
//  TBTool.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/9/4.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBTool.h"

@implementation TBTool

// 获取一个随机整数，范围在[from,to]，包括from，包括to
+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to {
    if (to - from + 1 <= 0) {
        NSAssert(NO, @"数值传入有错误");
    }
    return from + arc4random() % (to - from + 1);
}

+ (void)openScheme:(NSString *)scheme {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:scheme];
    
    if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [application openURL:URL options:@{}
           completionHandler:^(BOOL success) {
               NSLog(@"Open %@: %d", scheme, success);
           }];
    } else {
        BOOL success = [application openURL:URL];
        NSLog(@"Open %@: %d", scheme, success);
    }
}

+ (NSString *)pathForResourceWithBundleName:(NSString *)bundleName fileName:(NSString *)fileName fileType:(NSString *)fileType {
    return [[NSBundle bundleWithPath:[[NSBundle bundleForClass:[TBTool class]] pathForResource:bundleName ofType:@"bundle"]] pathForResource:fileName ofType:fileType];
}

+ (CGSize)sizeOfString:(NSString *)sting andFont:(UIFont *)font andMaxSize:(CGSize)size {
    CGSize textSize;
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    [mdic setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    [mdic setObject:font forKey:NSFontAttributeName];
    textSize = [sting boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                       attributes:mdic context:nil].size;
    return textSize;
}

+ (CABasicAnimation *)addAnimationForKeypath:(NSString *)keyPath
                                   fromValue:(CGFloat)fromValue
                                     toValue:(CGFloat)toValue
                                    duration:(CGFloat)duration
                                    delegate:(id)delegate
                                       layer:(CAShapeLayer *)layer{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.fromValue = @(fromValue);
    animation.toValue = @(toValue);
    animation.duration = duration;
    animation.delegate = delegate;
    animation.fillMode = kCAFillModeRemoved;
    animation.autoreverses = NO;
    [layer addAnimation:animation forKey:keyPath];
    return animation;
}

+ (CATextLayer *)textLayerWithRect:(CGRect)rect position:(CGPoint)position text:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor currentView:(UIView *)view {
    CATextLayer *textLayer = [self textLayerWithRect:rect text:text fontSize:fontSize textColor:textColor currentView:view];
    textLayer.position = position;
    return textLayer;
}

+ (CATextLayer *)textLayerWithRect:(CGRect)rect text:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor currentView:(UIView *)view {
    CATextLayer *textLayer = [CATextLayer layer];
    textLayer.contentsScale = [UIScreen mainScreen].scale;
    textLayer.string = text;
    textLayer.alignmentMode = kCAAlignmentCenter;
    textLayer.foregroundColor = textColor.CGColor;
    textLayer.frame = rect;
    textLayer.fontSize = fontSize;
    [view.layer addSublayer:textLayer];
    return textLayer;
}

@end
