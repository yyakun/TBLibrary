//
//  UIColor+TBHex.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "UIColor+TBHex.h"

@implementation UIColor (TBHex)

+ (UIColor *)colorWithHex:(NSUInteger)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:(((hex) & 0xFF0000) >> 16)/255.0f green:(((hex) & 0x00FF00) >> 8)/255.0f blue:((hex) & 0x0000FF)/255.0f alpha:alpha];
}

+ (NSString *)hexWithColor:(UIColor *)color {
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#ffffff"];
    }
    return [NSString stringWithFormat:@"#%02x%02x%02x",
            (unsigned int)((CGColorGetComponents(color.CGColor))[0] * 255.0f),
            (unsigned int)((CGColorGetComponents(color.CGColor))[1] * 255.0f),
            (unsigned int)((CGColorGetComponents(color.CGColor))[2] * 255.0f)];
}

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha {
    return [UIColor colorWithRed:arc4random()%256/255.0f green:arc4random()%256/255.0f blue:arc4random()%256/255.0f alpha:alpha];
}

@end
