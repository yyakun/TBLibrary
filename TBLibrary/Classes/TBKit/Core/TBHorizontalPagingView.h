//
//  TBHorizontalPagingView.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/6/25.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBHorizontalPagingView : UIView

/**
 *  segment据顶部的距离
 */
@property (nonatomic, assign) CGFloat segmentTopSpace;

/**
 *  自定义segmentButton的size
 */
@property (nonatomic, assign) CGSize segmentButtonSize;

/**
 *  下拉时如需要放大，则传入的图片的上边距约束，默认为不放大
 */
@property (nonatomic, strong) NSLayoutConstraint *magnifyTopConstraint;

/**
 *  切换视图
 */
@property (nonatomic, strong, readonly) UIView *segmentView;

/**
 *  视图切换的回调block
 */
@property (nonatomic, copy) void (^pagingViewSwitchBlock)(NSInteger switchIndex);

/**
 *  视图点击的回调block
 */
@property (nonatomic, copy) void (^clickEventViewsBlock)(UIView *eventView);

/**
 *  视图滚动的回调block
 */
@property (nonatomic, copy) void (^scrollViewDidScrollBlock)(CGFloat offset);

/**
 *  实例化横向分页控件
 *
 *  @param headerView     tableHeaderView
 *  @param headerHeight   tableHeaderView高度
 *  @param segmentButtons 切换按钮的数组
 *  @param segmentHeight  切换视图高度
 *  @param contentViews   内容视图的数组
 *
 *  @return  控件对象
 */
+ (TBHorizontalPagingView*)pagingViewWithHeaderView:(UIView *)headerView
                                        headerHeight:(CGFloat)headerHeight
                                      segmentButtons:(NSArray *)segmentButtons
                                       segmentHeight:(CGFloat)segmentHeight
                                        contentViews:(NSArray *)contentViews;

/**
 *  手动控制滚动到某个视图
 *
 *  @param pageIndex 页号
 */
- (void)scrollToIndex:(NSInteger)pageIndex;

/**
 *  是否允许切换视图
 *  为NO时不能左右滑动视图，且segmentBar点击无效
 *
 *  @param enable 是否允许切换
 */
- (void)switchEnable:(BOOL)enable;

/**
 *  是否允许左右滑动
 *  为NO时不能左右滑动视图，但segmentBar点击有效
 *
 *  @param enable 是否允许滑动（为NO时segmentBar点击有效）
 */
- (void)scrollEnable:(BOOL)enable;

@end
