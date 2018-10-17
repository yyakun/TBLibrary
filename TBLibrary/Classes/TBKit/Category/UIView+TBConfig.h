//
//  UIView+TBConfig.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TBConfig)

+ (NSString *)reuseIdentifier;
- (void)configViewWithData:(id)data;

@end
