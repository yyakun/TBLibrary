//
//  TBSegmentBar.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/7/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBSegmentBarConfiguration.h"

@class TBSegmentBar;

typedef NS_ENUM(NSInteger, TBSegmentBarStyle) {
    TBSegmentBarStyleDefault,
    TBSegmentBarStylePreferred
};

@protocol TBSegmentBarDelegate <NSObject>

/**
  通知外界内部的点击数据

 @param segmentBar segmentBar
 @param toIndex 选中的索引从0 开始
 @param fromIndex 上一个索引
 */
- (void)segmentBar:(TBSegmentBar *)segmentBar didSelectIndex: (NSInteger)toIndex fromIndex: (NSInteger)fromIndex;

@end


@interface TBSegmentBar : UIView

/**
 快速创建一个选项卡控件

 @param frame frame
 @return segment
 */
+ (instancetype)segmentBarWithFrame: (CGRect)frame;
/**代理*/
@property (nonatomic,weak) id<TBSegmentBarDelegate> delegate;
/**数据源*/
@property (nonatomic, strong)NSArray<NSString *> *items;
/** 添加的按钮数据 */
@property (nonatomic, strong) NSMutableArray <UIButton *>*itemBtns;
/**当前选中的索引，双向设置*/
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic, assign) TBSegmentBarStyle style;
- (void)btnClick:(UIButton *)button;

- (void)updateWithConfig:(void(^)(TBSegmentBarConfiguration *config))configBlock;

@end
