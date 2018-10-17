//
//  UIButton+TBImagePositionButton.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/9/19.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TBImagePositionStyle) {
    // 图片在左，文字在右
    TBImagePositionStyleDefault,
    // 图片在右，文字在左
    TBImagePositionStyleRight,
    // 图片在上，文字在下
    TBImagePositionStyleTop,
    // 图片在下，文字在上
    TBImagePositionStyleBottom
};

@interface UIButton (TBImagePositionButton)
/**
 *  设置图片与文字样式
 *
 *  @param imagePosition     图片位置样式
 *  @param spacing           图片与文字之间的间距
 */
- (void)TB_imagePosition:(TBImagePositionStyle)imagePosition spacing:(CGFloat)spacing;
@end
