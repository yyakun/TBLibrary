//
//  UIImage+TBResizeCreate.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TBResizeCreate)

#pragma mark - Create
+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)createMaskWithImage:(UIImage *)image outColor:(UIColor *)outColor innerColor:(UIColor *)innerColor;

#pragma mark - Reset
- (UIImage *)imageWithTintColor:(UIColor *)color;

#pragma mark - Resize
- (UIImage *)autoResizableWidthForCenter;
- (UIImage *)autoResizableHeightForCenter;
- (UIImage *)autoResizableForCenter;
- (UIImage *)resizeImageSize:(CGSize)size;

@end
