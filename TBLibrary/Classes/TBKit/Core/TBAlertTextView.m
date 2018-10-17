//
//  TBAlertTextView.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/11/1.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBAlertTextView.h"
#import "NSObject+MBProgressHUD.h"

#define kWidthMargin 16
#define kHeightMargin 10

@interface TBAlertTextView ()

@end

@implementation TBAlertTextView

+ (TBAlertTextView *)alertTextViewWithDelegate:(id <TBAlertTextViewDelegate>)delegate {
    TBAlertTextView *alertTextView = [[TBAlertTextView alloc] initUseInner];
    alertTextView.delegate = delegate;
    return alertTextView;
}

- (instancetype)initUseInner {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)init {
    NSAssert(NO, @"换别的初始化方法吧，file : %s, method : %@", __FILE__, NSStringFromSelector(_cmd));
    return nil;
}

- (void)showText:(NSString *)text {
    [self showText:text yOffset:0.0f];
}

- (void)showText:(NSString *)text yOffset:(CGFloat)yOffset {
    [self showText:text yOffset:yOffset autoCloseTime:1.0f];
}

- (void)showText:(NSString *)text yOffset:(CGFloat)yOffset autoCloseTime:(CGFloat)closeTime {
    if (text.length == 0) {
        NSLog(@"弹出信息失败，text为空字符串");
        return;
    }
    if ([text isEqualToString:kErrorDebugText]) {
        NSLog(@"%@", kErrorDebugText);
        return;
    }
    UIWindow *keyWindow = [[[UIApplication sharedApplication] delegate] window];
    [keyWindow addSubview:self];
    UILabel *label = [[UILabel alloc] init];
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    label.text = text;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    self.alpha = 0.8f;
    self.layer.cornerRadius = 4;
    self.layer.backgroundColor =[[UIColor blackColor] CGColor];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertTextViewWillDisplay:withContentLabel:)]) {
        [self.delegate alertTextViewWillDisplay:self withContentLabel:label];
    }
    
    CGRect titleRect = [text boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width - 40 - kWidthMargin * 2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading | NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName: label.font} context:nil];
    self.bounds = CGRectMake(0, 0, titleRect.size.width + kWidthMargin * 2, titleRect.size.height + kHeightMargin * 2);
    self.center = CGPointMake(keyWindow.center.x, keyWindow.center.y + yOffset);
    label.frame = CGRectMake(kWidthMargin, kHeightMargin, titleRect.size.width, titleRect.size.height);
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    [self hideTextWithAutoCloseTime:closeTime];
}

- (void)hideTextWithAutoCloseTime:(CGFloat)closeTime {
    [self performSelector:@selector(hide)
               withObject:self
               afterDelay:closeTime];
}

- (void)hide {
    [UIView animateWithDuration:0.2f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (_delegate && [_delegate respondsToSelector:@selector(alertTextViewDidDismiss:)]) {
            [_delegate alertTextViewDidDismiss:self];
        }
    }];
}

@end
