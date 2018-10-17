//
//  NSObject+UIViewController.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/6/25.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSObject+UIViewController.h"

@implementation NSObject (UIViewController)

- (UIViewController *)tb_viewController {
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    // modal
    if (vc.presentedViewController) {
        if ([vc.presentedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navVc = (UINavigationController *)vc.presentedViewController;
            vc = navVc.visibleViewController;
        } else if ([vc.presentedViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabVc = (UITabBarController *)vc.presentedViewController;
            if ([tabVc.selectedViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *navVc = (UINavigationController *)tabVc.selectedViewController;
                return navVc.visibleViewController;
            } else {
                return tabVc.selectedViewController;
            }
        } else {
            vc = vc.presentedViewController;
        }
    } else {
        // push
        if ([vc isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabVc = (UITabBarController *)vc;
            if ([tabVc.selectedViewController isKindOfClass:[UINavigationController class]]) {
                UINavigationController *navVc = (UINavigationController *)tabVc.selectedViewController;
                return navVc.visibleViewController;
            } else {
                return tabVc.selectedViewController;
            }
        } else if ([vc isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navVc = (UINavigationController *)vc;
            vc = navVc.visibleViewController;
        }
    }
    vc.view.backgroundColor = [UIColor whiteColor];
    return vc;
}

@end
