//
//  UIImage+TBClipCorner.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (TBClipCorner)

- (UIImage *)clipCornerRadius:(CGFloat)radius;//  推荐，裁剪效率更高
- (UIImage *)UIBezierPathClip:(UIImage *)img cornerRadius:(CGFloat)c;
- (UIImage *)CGContextClip:(UIImage *)img cornerRadius:(CGFloat)c;

@end
