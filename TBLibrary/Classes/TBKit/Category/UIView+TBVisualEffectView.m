//
//  UIView+TBVisualEffectView.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "UIView+TBVisualEffectView.h"

@implementation UIView (TBVisualEffectView)

- (UIVisualEffectView *)addVisualEffectView {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:blurEffect];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    visualEffectView.contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:visualEffectView];
    visualEffectView.frame = self.bounds;
    return visualEffectView;
}

@end
