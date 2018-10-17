//
//  NSObject+MBProgressHUD.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSObject+MBProgressHUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "TBAlertTextView.h"
#import <UIKit/UIKit.h>

NSString * const kErrorDebugText = @"请求参数错误";

@implementation NSObject (TBAlertTextView)

- (void)showText:(NSString *)text {
    [[TBAlertTextView alertTextViewWithDelegate:(id<TBAlertTextViewDelegate>)self] showText:text];
}

- (void)showText:(NSString *)text yOffset:(CGFloat)yOffset {
    [[TBAlertTextView alertTextViewWithDelegate:(id<TBAlertTextViewDelegate>)self] showText:text yOffset:yOffset];
}

- (void)showText:(NSString *)text yOffset:(CGFloat)yOffset autoCloseTime:(CGFloat)closeTime {
    [[TBAlertTextView alertTextViewWithDelegate:(id<TBAlertTextViewDelegate>)self] showText:text yOffset:yOffset autoCloseTime:closeTime];
}

@end


@interface NSObject () <MBProgressHUDDelegate>

@end

@implementation NSObject (MBProgressHUD)

#pragma mark - hud methods

- (void)hideLoadWithAnimated:(BOOL)animated {
    [self.hud hideAnimated:animated];
}

- (MBProgressHUD *)showLoadWithAnimated:(BOOL)animated {
    return [self showLoadWithAnimated:animated title:@""];
}

- (MBProgressHUD *)showLoadWithAnimated:(BOOL)animated title:(NSString *)title {
    return [self showLoadWithAnimated:animated title:title detailTitle:@""];
}

- (MBProgressHUD *)showLoadWithAnimated:(BOOL)animated title:(NSString *)title detailTitle:(NSString *)detailTitle {
    return [self showInfo:title detailTitle:detailTitle image:nil hiddenDelay:1.5f yOffset:0.0f containTextOnly:NO animated:animated];
}

- (MBProgressHUD *)showInfoAutoHidden:(NSString *)info {
    if ([info isEqualToString:kErrorDebugText]) {
        NSLog(@"%@", kErrorDebugText);
        return nil;
    }
    return [self showInfoAutoHidden:info animated:YES];
}

- (MBProgressHUD *)showInfoAutoHidden:(NSString *)info animated:(BOOL)animated {
    return [self showInfo:info image:nil hiddenDelay:1.5f yOffset:0.0f animated:animated];
}

- (MBProgressHUD *)showInfoAutoHidden:(NSString *)info yOffset:(CGFloat)yOffset {
    return [self showInfo:info image:nil hiddenDelay:1.5f yOffset:yOffset animated:YES];
}

- (MBProgressHUD *)showInfoAutoHidden:(NSString *)info yOffset:(CGFloat)yOffset animated:(BOOL)animated {
    return [self showInfo:info image:nil hiddenDelay:1.5f yOffset:yOffset animated:animated];
}

- (MBProgressHUD *)showInfo:(NSString *)info image:(UIImage *)icon hiddenDelay:(NSTimeInterval)delay yOffset:(CGFloat)yOffset animated:(BOOL)animated {
    return [self showInfo:info detailTitle:nil image:icon hiddenDelay:delay yOffset:yOffset containTextOnly:YES animated:animated];
}

- (MBProgressHUD *)showInfo:(NSString *)title detailTitle:(NSString *)detailTitle image:(UIImage *)icon hiddenDelay:(NSTimeInterval)delay yOffset:(CGFloat)yOffset containTextOnly:(BOOL)containTextOnly animated:(BOOL)animated {
    if ((title.length == 0 && detailTitle.length == 0 && containTextOnly) && !icon) {
        return nil;
    }
    MBProgressHUD *hud = self.hud;
    hud.mode = MBProgressHUDModeIndeterminate;
    if (icon) {
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [[UIImageView alloc] initWithImage:icon];
    }
    if (containTextOnly) {
        hud.mode = MBProgressHUDModeText;
    }
    hud.label.text = title;
    hud.detailsLabel.text = detailTitle;
    hud.offset = CGPointMake(hud.offset.x, yOffset);
    [hud showAnimated:animated];
    if (delay > 0) {
        [hud hideAnimated:animated afterDelay:delay];
    }
    return hud;
}

#pragma mark - MBProgressHUDDelegate

- (void)hudWasHidden:(MBProgressHUD *)hud {
    
}

#pragma mark - getter
- (MBProgressHUD *)hud {
    static MBProgressHUD *hud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hud = [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
        hud.delegate = self;
        hud.removeFromSuperViewOnHide = NO;
    });
    return hud;
}

@end
