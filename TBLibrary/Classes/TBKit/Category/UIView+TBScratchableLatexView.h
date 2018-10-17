//
//  UIView+TBScratchableLatexView.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

struct TBRowLine {
    NSUInteger row;//  水平间距
    NSUInteger line;//  垂直间距
};
typedef struct TBRowLine TBRowLine;//  定义多少行，多少列的结构体

CG_INLINE TBRowLine
TBRowLineMake(NSUInteger row, NSUInteger line) {
    TBRowLine rowLine;
    rowLine.row = row; rowLine.line = line;
    return rowLine;
}

struct TBInterval {
    CGFloat horizontal;//  水平间距
    CGFloat vertical;//  垂直间距
};
typedef struct TBInterval TBInterval;//  间距

struct TBLocation {
    CGPoint origin;
    CGSize size;
    TBInterval interval;
};
typedef struct TBLocation TBLocation;//  为创建九宫格视图而自定义的结构体类型，用来描述位置大小间距。

CG_INLINE TBLocation
TBLocationMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height, CGFloat horizontal, CGFloat vertical)
{
    TBLocation location;
    location.origin.x = x; location.origin.y = y;
    location.size.width = width; location.size.height = height;
    location.interval.horizontal = horizontal;
    location.interval.vertical = vertical;
    return location;
}


typedef NS_ENUM(NSInteger, TBScratchableLatexViewStyle) {
    TBScratchableLatexViewNoneLineViewStyle,//  内部和外部都无细线
    TBScratchableLatexViewStyleNoneLeftAndRightLineViewStyle,//  整个视图的左边和右边没细线
    TBScratchableLatexViewStyleNoneAroundLineViewStyle,//  整个视图的四周没细线
    TBScratchableLatexViewStyleAroundLineViewStyle//  整个视图的四周带有细线
};

@interface UIView (TBScratchableLatexView)

//  创建九宫格视图，如：按钮，图像视图，自定义视图等
+ (NSArray *)createViewsWithRowLine:(TBRowLine)rowLine location:(TBLocation)location viewClassName:(NSString *)viewClassName superView:(UIView *)superView;

+ (NSArray *)createViewsWithRowLine:(TBRowLine)rowLine location:(TBLocation)location viewClassName:(NSString *)viewClassName superView:(UIView *)superView lineWidth:(CGFloat)lineWidth lineColor:(UIColor *)lineColor lineStyle:(TBScratchableLatexViewStyle)lineStyle;

@end
