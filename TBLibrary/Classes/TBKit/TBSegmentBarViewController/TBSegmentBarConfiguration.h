//
//  TBSegmentBarConfiguration.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/7/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBSegmentBarConfiguration : NSObject

+ (instancetype)defaultConfig;

@property (nonatomic, strong) UIColor *sBBackColor;
@property (nonatomic, strong) UIColor *itemNC;
@property (nonatomic, strong) UIColor *itemSC;
@property (nonatomic, strong) UIFont *itemF;
@property (nonatomic, strong) UIColor *indicatorC;
@property (nonatomic, assign) CGFloat indicatorH;
@property (nonatomic, assign) CGFloat indicatorW;


/**默认颜色*/
@property (nonatomic, copy, readonly) TBSegmentBarConfiguration *(^itemNormalColor)(UIColor *color);
/**选中颜色*/
@property (nonatomic, copy, readonly) TBSegmentBarConfiguration *(^itemSelectColor)(UIColor *color);
/**背景颜色*/
@property (nonatomic, copy, readonly) TBSegmentBarConfiguration *(^segmentBarBackColor)(UIColor *color);
/**文字字体大小*/
@property (nonatomic, copy, readonly) TBSegmentBarConfiguration *(^itemFont)(UIFont *font);
/**指示器颜色*/
@property (nonatomic, copy, readonly) TBSegmentBarConfiguration *(^indicatorColor)(UIColor *color);
/**指示器高度*/
@property (nonatomic, copy, readonly) TBSegmentBarConfiguration *(^indicatorHeight)(CGFloat h);
/**指示器宽度*/
@property (nonatomic, copy, readonly) TBSegmentBarConfiguration *(^indicatorExtraW)(CGFloat w);

@end
