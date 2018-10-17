//
//  UINavigationController+TB.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "UINavigationController+TB.h"
#import <objc/runtime.h>

@implementation UINavigationController (TB)

static char backIconNameKey;

- (void)setBackIconName:(NSString *)backIconName {
    objc_setAssociatedObject(self, &backIconNameKey, backIconName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)backIconName {
    return objc_getAssociatedObject(self, &backIconNameKey);
}

- (void)TB_PushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 60, 44);
    [button setImage:[UIImage imageNamed:self.backIconName] forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    viewController.hidesBottomBarWhenPushed = YES;
    [self pushViewController:viewController animated:animated];
    // 修改tabBra的frame
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (void)clicked:(id)sender {
    [self popViewControllerAnimated:YES];
}

@end
