//
//  UIView+TBConfig.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "UIView+TBConfig.h"

@implementation UIView (TBConfig)

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)configViewWithData:(id)data {
    NSLog(@"the method do not work only if rewritten");
}

@end
