//
//  NSObject+TBAlert.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSObject+TBAlert.h"
#import "NSObject+TBRuntime.h"
#import "NSObject+UIViewController.h"

@implementation NSObject (TBAlert)

- (nullable instancetype)alertControllerWithTitle:(nullable NSString *)title message:(nullable NSString *)message buttonTitles:(nullable NSArray <NSString *>*)buttonTitles handler:(void (^ __nullable)(UIAlertController *alertController, NSString *buttonTitle))handler {
    if (message.length == 0) {
        NSLog(@"弹出框提示语为空");
        return nil;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(alertController) weakAlertController = alertController;
    __weak typeof(self) weakself = self;
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [weakself didClickAlertCancelButtonCompletion:weakAlertController];
    }];
    [alertController addAction:cancelAlertAction];
    
    for (NSInteger i = 0; i < buttonTitles.count; i++) {
        NSString *buttonTitle = buttonTitles[i];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            handler ? handler(weakAlertController, buttonTitle) : nil;
        }];
        [alertController addAction:alertAction];
    }
    
    // 定制、拓展原有的弹出框样式，可以添加文本框、移除原来已添加的action等。
    if ([self conformsToProtocol:@protocol(TBAlertDelegate)] && [self respondsToSelector:@selector(alertControllerWillShow:)]) {
        [self performSelector:@selector(alertControllerWillShow:) withObject:alertController];
    }
    
    [self.tb_viewController presentViewController:alertController animated:YES completion:nil];
    return alertController;
}

- (nullable instancetype)alertWithMessage:(NSString *)message {
    return [self alertWithMessage:message title:nil];
}

- (nullable instancetype)alertWithMessage:(NSString *)message title:(NSString *)title {
    return [self alertWithMessage:message title:title leftButtonTitle:@"确定" rightButtonTitle:@"取消"];
}

- (nullable instancetype)alertWithMessage:(NSString *)message title:(NSString *)title leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle {
    if (message.length == 0) {
        NSLog(@"弹出框提示语为空");
        return nil;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    __weak typeof(self) weakself = self;
    __weak typeof(alertController) weakAlertController = alertController;
    if (leftButtonTitle.length > 0) {
        UIAlertAction *leftAlertAction = [UIAlertAction actionWithTitle:leftButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [weakself didClickAlertConfirmButtonCompletion:weakAlertController];
        }];
        [alertController addAction:leftAlertAction];
    }
    if (rightButtonTitle.length > 0) {
        UIAlertAction *rightAlertAction = [UIAlertAction actionWithTitle:rightButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [weakself didClickAlertCancelButtonCompletion:weakAlertController];
        }];
        [alertController addAction:rightAlertAction];
    }
    
    // 定制、拓展原有的弹出框样式，可以添加文本框、移除原来已添加的action等。
    if ([self conformsToProtocol:@protocol(TBAlertDelegate)] && [self respondsToSelector:@selector(alertControllerWillShow:)]) {
        [self performSelector:@selector(alertControllerWillShow:) withObject:alertController];
    }
    
    [self.tb_viewController presentViewController:alertController animated:YES completion:nil];
    // 用于区分是哪个弹出提示框
    alertController.objectIdentifier = message;
    return alertController;
}

- (void)didClickAlertConfirmButtonCompletion:(UIResponder *)sender {
    NSLog(@"this method（confirmButton is Clicked） needs to be override");
    //  override to do something when user did click confirm button, if use alertView or alertController
}

- (void)didClickAlertCancelButtonCompletion:(UIResponder *)sender {
    NSLog(@"this method（cancelButton is Clicked） needs to be override");
    //  override to do something when user did click cancel button, if use alertView or alertController
}

@end

@implementation NSObject (TBAlert_Deprecated)

- (instancetype)alertWithMessage:(NSString *)message showInViewController:(UIViewController *)viewController {
    return [self alertWithMessage:message title:nil showInViewController:viewController];
}

- (instancetype)alertWithMessage:(NSString *)message title:(NSString *)title showInViewController:(UIViewController *)viewController {
    return [self alertWithMessage:message title:title leftButtonTitle:@"取消" rightButtonTitle:@"确定" showInViewController:viewController];
}

- (instancetype)alertWithMessage:(NSString *)message title:(NSString *)title leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle showInViewController:(UIViewController *)viewController {
    return [self alertControllerWithTitle:title message:message leftButtonTitle:leftButtonTitle rightButtonTitle:rightButtonTitle haveTextFieldStyle:NO showInViewController:viewController];
}

- (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message leftButtonTitle:(NSString *)leftButtonTitle rightButtonTitle:(NSString *)rightButtonTitle haveTextFieldStyle:(BOOL)haveTextField showInViewController:(UIViewController *)viewController {
    if (message.length == 0) {
        NSLog(@"弹出框提示语为空");
        return nil;
    }
    __weak typeof(self) weakself = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (leftButtonTitle) {
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:leftButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [weakself didClickAlertCancelButtonCompletion:alertController];
        }];
        [alertController addAction:alertAction];
    }
    if (rightButtonTitle) {
        UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:rightButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [weakself didClickAlertConfirmButtonCompletion:alertController];
        }];
        [alertController addAction:alertAction2];
    }
    if (haveTextField) {
        [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            
        }];
    }
    [viewController presentViewController:alertController animated:YES completion:nil];
    alertController.objectIdentifier = message;
    return alertController;
}

@end
