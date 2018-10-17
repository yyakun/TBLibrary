//
//  NSObject+TBAlert.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TBAlertDelegate <NSObject>

@optional
- (void)alertControllerWillShow:(UIAlertController *)alertController;

@end

@interface NSObject (TBAlert)

- (nullable instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message buttonTitles:(nullable NSArray <NSString *>*)buttonTitles handler:(void (^ __nullable)(UIAlertController *alertController, NSString *buttonTitle))handler;// 推荐统一使用这个方法。

- (nullable instancetype)alertWithMessage:(NSString *)message;
- (nullable instancetype)alertWithMessage:(NSString *)message title:(NSString *)title;

/**
 *  弹系统默认样式的提示框
 *
 *  @param message          提示具体信息
 *  @param title            提示标题
 *  @param leftButtonTitle  左边按钮标题
 *  @param rightButtonTitle 右边按钮标题
 *
 *  @return UIAlertController类的对象
 */
- (nullable instancetype)alertWithMessage:(NSString *)message title:(NSString *)title leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle;

- (void)didClickAlertConfirmButtonCompletion:(UIResponder *)sender;//  点击确定按钮的触发事件
- (void)didClickAlertCancelButtonCompletion:(UIResponder *)sender;//  点击取消按钮的触发事件

@end

@interface NSObject (TBAlert_Deprecated)

- (instancetype)alertWithMessage:(NSString *)message showInViewController:(UIViewController *)viewController __attribute__((deprecated("Use `alertWithMessage:`.")));
- (instancetype)alertWithMessage:(NSString *)message title:(NSString *)title showInViewController:(UIViewController *)viewController __attribute__((deprecated("Use `alertWithMessage:title:`.")));
- (instancetype)alertWithMessage:(NSString *)message title:(NSString *)title leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle showInViewController:(UIViewController *)viewController __attribute__((deprecated("Use `alertWithMessage:title:message:leftButtonTitle:rightButtonTitle:`.")));
- (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle haveTextFieldStyle:(BOOL)haveTextField showInViewController:(UIViewController *)viewController __attribute__((deprecated("Use `alertWithMessage:title:message:leftButtonTitle:rightButtonTitle:`.")));

@end

NS_ASSUME_NONNULL_END
