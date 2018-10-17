//
//  UIImage+TBResizeCreate.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "UIImage+TBResizeCreate.h"

@implementation UIImage (TBResizeCreate)

#pragma mark - Create
+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)createMaskWithImage:(UIImage *)image outColor:(UIColor *)outColor innerColor:(UIColor *)innerColor {
    CGRect imageRect = CGRectMake(0, 0, CGImageGetWidth(image.CGImage), CGImageGetHeight(image.CGImage));
    
    // Create a new bitmap context
    CGContextRef context = CGBitmapContextCreate(NULL, imageRect.size.width, imageRect.size.height, 8, 0, CGImageGetColorSpace(image.CGImage), kCGBitmapAlphaInfoMask);
    
    CGContextSetFillColorWithColor(context, outColor.CGColor);
    CGContextFillRect(context, imageRect);
    
    // Use the passed in image as a clipping mask
    CGContextClipToMask(context, imageRect, image.CGImage);
    
    CGContextSetFillColorWithColor(context, innerColor.CGColor);
    CGContextFillRect(context, imageRect);
    
    // Generate a new image
    CGImageRef newCGImage = CGBitmapContextCreateImage(context);
    UIImage* newImage = [UIImage imageWithCGImage:newCGImage scale:image.scale orientation:image.imageOrientation];
    
    // Cleanup
    CGContextRelease(context);
    CGImageRelease(newCGImage);
    
    return newImage;
}

#pragma mark - Reset
- (UIImage *)imageWithTintColor:(UIColor *)tintColor {
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, self.size.width, self.size.height);
    UIRectFill(bounds);
    //Draw the tinted image in context
    [self drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

#pragma mark - Resize
- (UIImage *)autoResizableWidthForCenter {
    UIEdgeInsets insets = UIEdgeInsetsMake(0, self.size.width/2.0f - 0.5, 0, self.size.width/2.0f - 0.5);
    return  [self resizableImageWithCapInsets:insets];
}

- (UIImage *)autoResizableHeightForCenter {
    UIEdgeInsets insets = UIEdgeInsetsMake(self.size.height/2.0f - 0.5, 0, self.size.height/2.0f - 0.5, 0);
    return  [self resizableImageWithCapInsets:insets];
}

- (UIImage *)autoResizableForCenter {
    UIEdgeInsets insets = UIEdgeInsetsMake(self.size.height/2.0f - 0.5, self.size.width/2.0f - 0.5, self.size.height/2.0f - 0.5, self.size.width/2.0f - 0.5);;
    return  [self resizableImageWithCapInsets:insets];
}

- (UIImage *)resizeImageSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    
    // Create a stretchable image using the TabBarSelection image but offset 4 pixels down
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    // Generate a new image
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
