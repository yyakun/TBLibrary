//
//  NSObject+MBProgressHUD.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>
FOUNDATION_EXTERN NSString * const kErrorDebugText;

@class MBProgressHUD;

@interface NSObject (TBAlertTextView)

- (void)showText:(NSString *)text;
- (void)showText:(NSString *)text yOffset:(CGFloat)yOffset;
- (void)showText:(NSString *)text yOffset:(CGFloat)yOffset autoCloseTime:(CGFloat)closeTime;

@end

@interface NSObject (MBProgressHUD)

- (void)hideLoadWithAnimated:(BOOL)animated;
- (MBProgressHUD *)showLoadWithAnimated:(BOOL)animated;
- (MBProgressHUD *)showLoadWithAnimated:(BOOL)animated title:(NSString *)title;
- (MBProgressHUD *)showLoadWithAnimated:(BOOL)animated title:(NSString *)title detailTitle:(NSString *)detailTitle;
- (MBProgressHUD *)showInfoAutoHidden:(NSString *)info;
- (MBProgressHUD *)showInfoAutoHidden:(NSString *)info animated:(BOOL)animated;
- (MBProgressHUD *)showInfoAutoHidden:(NSString *)info yOffset:(CGFloat)yOffset;
- (MBProgressHUD *)showInfoAutoHidden:(NSString *)info yOffset:(CGFloat)yOffset animated:(BOOL)animated;
- (MBProgressHUD *)showInfo:(NSString *)info image:(UIImage *)icon hiddenDelay:(NSTimeInterval)delay yOffset:(CGFloat)yOffset animated:(BOOL)animated;
- (MBProgressHUD *)showInfo:(NSString *)title detailTitle:(NSString *)detailTitle image:(UIImage *)icon hiddenDelay:(NSTimeInterval)delay yOffset:(CGFloat)yOffset containTextOnly:(BOOL)containTextOnly animated:(BOOL)animated;

@end
