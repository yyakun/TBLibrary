//
//  TBAlertTextView.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/11/1.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TBAlertTextView;

@protocol TBAlertTextViewDelegate <NSObject>

@optional
- (void)alertTextViewWillDisplay:(TBAlertTextView *)alertTextView withContentLabel:(UILabel *)label;
- (void)alertTextViewDidDismiss:(TBAlertTextView *)alertTextView;

@end

@interface TBAlertTextView : UIView

@property (nonatomic, weak) id <TBAlertTextViewDelegate> delegate;

+ (TBAlertTextView *)alertTextViewWithDelegate:(id <TBAlertTextViewDelegate>)delegate;
- (void)showText:(NSString *)text;
- (void)hideTextWithAutoCloseTime:(CGFloat)time;
- (void)showText:(NSString *)text yOffset:(CGFloat)yOffset;
- (void)showText:(NSString *)text yOffset:(CGFloat)yOffset autoCloseTime:(CGFloat)closeTime;

@end
