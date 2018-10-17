//
//  TBLineChart.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/9/19.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBLineChart : UIView


/**
 赋值value

 @param valueArray valueArray
 @param count Y轴标注值的个数
 */
- (void)setValue:(NSArray *)valueArray withYLineCount:(int)count;
// x轴文字
@property (nonatomic, strong) NSArray *titleArray;
// 标注
@property (nonatomic, weak) UIColor *markTextColor;
@property (nonatomic, weak) UIFont *markTextFont;
// 线颜色
@property (nonatomic, weak) UIColor *lineColor;
// 填充颜色
@property (nonatomic, weak) UIColor *fillColor;
// 背景线颜色
@property (nonatomic, weak) UIColor *backgroundLineColor;
@end
