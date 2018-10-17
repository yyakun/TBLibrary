//
//  TBCircleChart.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/9/19.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBCircleChart : UIView

// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame withMaxValue:(CGFloat)maxValue value:(CGFloat)value;
// 值相关
@property (nonatomic, copy) NSString *valueTitle;
@property (nonatomic, weak) UIColor *valueColor;
@property (nonatomic, weak) UIFont *valueFont;
// 渐变色数组
@property (nonatomic, strong) NSArray *colorArray;
// 渐变色数组所占位置
@property (nonatomic, strong) NSArray *locations;
// 底圆颜色
@property (nonatomic, strong) UIColor *insideCircleColor;
// 单色
@property (nonatomic, strong) UIColor *singleColor;

@end
