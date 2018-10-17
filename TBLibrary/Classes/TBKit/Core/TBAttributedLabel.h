//
//  TBAttributedLabel.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@protocol TBAttributedLabelDelegate <NSObject>

- (void)clickTextWithIndex:(CFIndex)index;

@end

@interface TBAttributedLabel : UILabel

@property (nonatomic, weak) id<TBAttributedLabelDelegate> delegate;

/**
 *  设置某段字的颜色
 *
 *  @param color color to set
 *  @param location from index
 *  @param length length of text to change
 */
- (void)setColor:(UIColor *)color fromIndex:(NSInteger)location length:(NSInteger)length;

/**
 *  设置某段字的字体
 *
 *  @param font     font to be set
 *  @param location from index
 *  @param length length of text to change
 */
- (void)setFont:(UIFont *)font fromIndex:(NSInteger)location length:(NSInteger)length;

/**
 *  设置某段字的下划线风格
 *
 *  @param style    style to be set
 *  @param location from index
 *  @param length   length of text to change
 */
- (void)setStyle:(CTUnderlineStyle)style fromIndex:(NSInteger)location length:(NSInteger)length;

@end
