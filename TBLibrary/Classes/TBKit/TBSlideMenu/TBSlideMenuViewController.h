//
//  TBSlideMenuViewController.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/9/19.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+TBSlideMenu.h"

@protocol TBSlideMenuDelegate <NSObject>

@optional

- (void)willShowRootViewController:(TBSlideMenuViewController *)slideMenu;
- (void)willShowLeftViewController:(TBSlideMenuViewController *)slideMenu;
- (void)willShowRightViewController:(TBSlideMenuViewController *)slideMenu;
- (BOOL)shouldShowRootViewController:(TBSlideMenuViewController *)slideMenu;
- (BOOL)shouldShowLeftViewController:(TBSlideMenuViewController *)slideMenu;
- (BOOL)shouldShowRightViewController:(TBSlideMenuViewController *)slideMenu;
- (BOOL)enablePanGusture:(TBSlideMenuViewController *)slideMenu;
- (BOOL)enableTapGusture:(TBSlideMenuViewController *)slideMenu;

@end

@interface TBSlideMenuViewController : UIViewController
@property (nonatomic, weak) id <TBSlideMenuDelegate> delegate;
//正在展现的是主视图
@property (nonatomic, assign) BOOL isShowingRoot;
//正在展现的是左侧视图
@property (nonatomic, assign) BOOL isShowingLeft;
//正在展现的是右侧视图
@property (nonatomic, assign) BOOL isShowingRight;
//拖拽手势
@property (nonatomic, strong) UIPanGestureRecognizer *pan;
//主视图
@property (nonatomic, strong) UIViewController *rootViewController;
//左侧视图
@property (nonatomic, strong) UIViewController *leftViewController;
//右侧视图
@property (nonatomic, strong) UIViewController *rightViewController;
//菜单宽度
@property (nonatomic, assign, readonly) CGFloat menuWidth;
//留白宽度
@property (nonatomic, assign, readonly) CGFloat emptyWidth;
//是否允许滚动
@property (nonatomic ,assign) BOOL slideEnabled;
//创建方法
- (instancetype)initWithRootViewController:(UIViewController*)rootViewController;
//显示主视图
- (void)showRootViewControllerAnimated:(BOOL)animated;
//显示左侧菜单
- (void)showLeftViewControllerAnimated:(BOOL)animated;
//显示右侧菜单
- (void)showRightViewControllerAnimated:(BOOL)animated;

@end
