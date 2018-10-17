//
//  UIView+TBFileOwner.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "UIView+TBFileOwner.h"

@implementation TBFileOwner

+ (id)viewFromNibName:(NSString *)nibName {
    TBFileOwner *owner = [self new];
    [[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil];
    return owner.view;
}

@end

@implementation UIView (TBFileOwner)

+ (id)loadFromNib {
    return [self loadFromNibNamed:NSStringFromClass(self)];
}

+ (id)loadFromNibNamed:(NSString *)nibName {
    return [TBFileOwner viewFromNibName:nibName];
}

+ (id)loadFromNibNoOwner:(NSString *)nibName {
    return [[[NSBundle mainBundle] loadNibNamed:(nibName ? nibName : NSStringFromClass([self class])) owner:nil options:nil] lastObject];
}

@end
