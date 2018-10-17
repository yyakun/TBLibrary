//
//  UIView+TBAutoLayout.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TBAutoLayoutAlignType) {
    TBAutoLayoutAlignCenterX = NSLayoutAttributeCenterX,
    TBAutoLayoutAlignCenterY = NSLayoutAttributeCenterY,
    TBAutoLayoutAlignTop = NSLayoutAttributeTop,
    TBAutoLayoutAlignLeft = NSLayoutAttributeLeft,
    TBAutoLayoutAlignBottom = NSLayoutAttributeBottom,
    TBAutoLayoutAlignRight = NSLayoutAttributeRight,
    TBAutoLayoutAlignLeading = NSLayoutAttributeLeading,
    TBAutoLayoutAlignLeadingMargin = NSLayoutAttributeLeadingMargin,
    TBAutoLayoutAlignTrailing = NSLayoutAttributeTrailing,
    TBAutoLayoutAlignTrailingMargin = NSLayoutAttributeTrailingMargin,
    TBAutoLayoutAlignTopMargin = NSLayoutAttributeTopMargin,
    TBAutoLayoutAlignLeftMargin = NSLayoutAttributeLeftMargin,
    TBAutoLayoutAlignBottomMargin = NSLayoutAttributeBottomMargin,
    TBAutoLayoutAlignRightMargin = NSLayoutAttributeRightMargin,
    TBAutoLayoutAlignCenterXWithinMargins = NSLayoutAttributeCenterXWithinMargins,
    TBAutoLayoutAlignCenterYWithinMargins = NSLayoutAttributeCenterYWithinMargins,
    TBAutoLayoutAlignBaseline = NSLayoutAttributeBaseline,
    TBAutoLayoutAlignFirstBaseline = NSLayoutAttributeFirstBaseline,
    TBAutoLayoutAlignLastBaseline = NSLayoutAttributeLastBaseline
};

typedef NS_ENUM(NSInteger, TBAutoLayoutSizeType) {
    TBAutoLayoutSizeWidth           = NSLayoutAttributeWidth,
    TBAutoLayoutSizeHeight          = NSLayoutAttributeHeight,
    TBAutoLayoutSizeNotAnAttribute  = NSLayoutAttributeNotAnAttribute
};

@interface NSArray (TBAutoLayout)

- (void)setViewsAutoAlignInSuperview:(TBAutoLayoutAlignType)alignType;//  设置一组视图统一相对父视图的一个约束对齐
- (void)setViewsAutoAlignRelatedView:(UIView *)relatedView align:(TBAutoLayoutAlignType)alignType;
- (void)setViewsAutoAlign:(TBAutoLayoutAlignType)alignType relatedView:(UIView *)relatedView constant:(CGFloat)constant;//  设置一组视图统一相对其relatedView视图的一个约束对齐
- (void)setViewsAutoAlign:(TBAutoLayoutAlignType)alignType relatedView:(UIView *)relatedView alignType:(TBAutoLayoutAlignType)alignType2 constant:(CGFloat)constant;

@end

@interface UIView (TBAutoLayout)

#pragma mark - for self
/**
 * 是否启用autoLayout
 *
 */
- (void)useAutoLayout;

/**
 相对superView对齐，水平，垂直居中
 **/
- (void)autoCenterInSuperview;

/**
 *  全屏加子view
 *
 *  @param contentView 子view
 *
 */
- (void)addFullContentView:(UIView *)contentView;

/**
 *  添加子view
 *
 *  @param contentView 子view
 *  @param insets 相对父view上下左右空多少
 *
 */
- (void)addContentView:(UIView *)contentView insets:(UIEdgeInsets)insets;

/**
 相对superView对齐，根据type
 **/
- (NSLayoutConstraint *)autoAlignInSuperview:(TBAutoLayoutAlignType)alignType;

/**
 相对superView对齐，根据type, constant
 **/
- (NSLayoutConstraint *)autoAlignInSuperview:(TBAutoLayoutAlignType)alignType constant:(CGFloat)constant;

/**
 *  相对relatedView对齐，self.alignType = relatedView.alignType + constant
 */

- (NSLayoutConstraint *)autoAlign:(TBAutoLayoutAlignType)alignType relatedView:(UIView *)relatedView constant:(CGFloat)constant;

/**
 *  相对relatedView对齐，self.alignType = relatedView.alignType * rate + constant
 */
- (NSLayoutConstraint *)autoAlign:(TBAutoLayoutAlignType)alignType relatedView:(UIView *)relatedView rate:(CGFloat)rate constant:(CGFloat)constant;

/**
 *  相对视图控制器ViewController中的self.view对齐，self.alignType = self.view.relatedAlign + constant
 */
- (NSLayoutConstraint *)autoAlignRelatedMainView:(TBAutoLayoutAlignType)alignType relatedAlign:(TBAutoLayoutAlignType)relatedAlign constant:(CGFloat)constant;

/**
 *  相对relatedView对齐，self.alignType = relatedView.relatedAlign + constant
 */
- (NSLayoutConstraint *)autoAlign:(TBAutoLayoutAlignType)alignType relatedView:(UIView *)relatedView relatedAlign:(TBAutoLayoutAlignType)relatedAlign constant:(CGFloat)constant;

/**
 *  一次性设置view宽高
 */
- (void)autoMatchSizeWithWidth:(CGFloat)width height:(CGFloat)heigth;

/**
 *  设置view的宽或高
 */
- (NSLayoutConstraint *)autoMatchSizeType:(TBAutoLayoutSizeType)sizeType constant:(CGFloat)constant;

/**
 *  添加宽高比约束 sizeType1 = sizeType2 * rate
 */
- (NSLayoutConstraint *)autoMatchSizeType:(TBAutoLayoutSizeType)sizeType1 sizeType2:(TBAutoLayoutSizeType)sizeType2 rate:(CGFloat)rate;

/**
 *  添加宽高相关约束 self.sizeType1 = relatedView.sizeType2 * rate + constant
 */
- (NSLayoutConstraint *)autoMatchSizeType:(TBAutoLayoutSizeType)sizeType1 relatedView:(UIView *)relatedView  sizeType2:(TBAutoLayoutSizeType)sizeType2 rate:(CGFloat)rate constant:(CGFloat)constant;

/**
 *  清除所有Constraint, 包括subview
 */
- (void)clearAllConstraints;

#pragma mark - for superView
/**
 *  VFL 方式
 *
 *  @param formatArray VFL数组
 *
 */
- (void)autoAddConstraintsWithVisualFormatArray:(NSArray *)formatArray options:(NSLayoutFormatOptions)opts metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

/**
 *  VFL 方式 和上一个的区别就是opts 也是数组
 */
- (void)autoAddConstraintsWithVisualFormatArray:(NSArray *)formatArray optionsArray:(NSArray *)optsArray metrics:(NSDictionary *)metrics views:(NSDictionary *)views;

@end
