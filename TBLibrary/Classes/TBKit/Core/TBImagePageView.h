//
//  TBImagePageView.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, TBImagePageViewDirection) {
    TBImagePageViewDirection_Rightward     = 0b001,      //!< 水平方向上从左往右滚动
    TBImagePageViewDirection_Leftward      = 0b111,      //!< 水平方向上从右往左滚动
    TBImagePageViewDirection_Downward      = 0b010,      //!< 竖直方向上从上往下滚动
    TBImagePageViewDirection_Upward        = 0b100       //!< 竖直方向上从下往上滚动
};

/**
 *  图片轮播
 */
//TODO:移到UIComponent
@interface TBImagePageView : UIView

@property (nonatomic, assign) NSTimeInterval rollingDelayTime;//!< 开启自动滚动时，滚动间隔时长，默认4秒
@property (nonatomic, assign) TBImagePageViewDirection direction;//!< 开启自动滚动时，滚动方向，默认从左往右
@property (nonatomic, copy) NSArray *images;//!<图片URL数组
@property (nonatomic, strong) UIImage *placeholder;
@property (nonatomic, assign) UIViewContentMode contentMode;
@property (nonatomic, copy) void (^didClickOnImage)(NSUInteger index);//图片点击回调
@property (nonatomic, copy) void (^didShowOnImage)(NSUInteger index);
@property (nonatomic, strong, readonly) UIPageControl *pageControl;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images;

- (void)startRolling;
- (void)stopRolling;

@end
