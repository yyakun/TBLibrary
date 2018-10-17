//
//  TBTool.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/9/4.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 加载Icons.bundle里的.png格式图片
#define UIImageWithFileName(_fileName)  [UIImage imageWithContentsOfFile:[TBTool pathForResourceWithBundleName:@"Icons" fileName:_fileName fileType:@"png"]]
// 加载 .png格式图片
#define UIImageFromBundle(_bundleName, _fileName)  [UIImage imageWithContentsOfFile:[TBTool pathForResourceWithBundleName:_bundleName fileName:_fileName fileType:@"png"]]
// 加载其它类型的图片,如 .jpg等
#define UIImageFromBundleWithType(_bundleName, _fileName, _fileType)  [UIImage imageWithContentsOfFile:[TBTool pathForResourceWithBundleName:_bundleName fileName:_fileName fileType:_fileType]]

@interface TBTool : NSObject

+ (NSInteger)getRandomNumber:(NSInteger)from to:(NSInteger)to;
+ (void)openScheme:(NSString *)scheme;

/**
 加载xxx.bundle包文件里的资源,返回此资源的路径字符串,可加载图片,音频,视频等

 @param bundleName 取 .bundle前面的字符串,如上面举例的xxx
 @param fileName 文件名
 @param fileType 文件类型, png,mp4,mp3等
 @return 资源的路径
 */
+ (NSString *)pathForResourceWithBundleName:(NSString *)bundleName fileName:(NSString *)fileName fileType:(NSString *)fileType;

+ (CGSize)sizeOfString:(NSString *)sting andFont:(UIFont *)font andMaxSize:(CGSize)size;
+ (CABasicAnimation *)addAnimationForKeypath:(NSString *)keyPath
                                   fromValue:(CGFloat)fromValue
                                     toValue:(CGFloat)toValue
                                    duration:(CGFloat)duration
                                    delegate:(id)delegate
                                       layer:(CAShapeLayer *)layer;
+ (CATextLayer *)textLayerWithRect:(CGRect)rect position:(CGPoint)position text:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor currentView:(UIView *)view;
+ (CATextLayer *)textLayerWithRect:(CGRect)rect text:(NSString *)text fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor currentView:(UIView *)view;

@end
