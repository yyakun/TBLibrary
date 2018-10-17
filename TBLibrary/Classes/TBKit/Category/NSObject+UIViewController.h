//
//  NSObject+UIViewController.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/6/25.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (UIViewController)

/**
 *  获取当前显示的控制器
 */
- (UIViewController *)tb_viewController;

@end
