//
//  UIViewController+TBSlideMenu.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/9/19.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "UIViewController+TBSlideMenu.h"
#import "TBSlideMenuViewController.h"

@implementation UIViewController (TBSlideMenu)

- (TBSlideMenuViewController *)slideMenu {
    UIViewController *slideMenu = self.parentViewController;
    while (slideMenu) {
        if ([slideMenu isKindOfClass:[TBSlideMenuViewController class]]) {
            return (TBSlideMenuViewController *)slideMenu;
        } else if (slideMenu.parentViewController && slideMenu.parentViewController != slideMenu) {
            slideMenu = slideMenu.parentViewController;
        } else {
            slideMenu = nil;
        }
    }
    return nil;
}

@end
