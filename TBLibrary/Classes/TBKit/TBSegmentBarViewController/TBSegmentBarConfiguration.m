//
//  TBSegmentBarConfiguration.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/7/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBSegmentBarConfiguration.h"

@implementation TBSegmentBarConfiguration

+ (instancetype)defaultConfig {
    TBSegmentBarConfiguration *config = [[TBSegmentBarConfiguration alloc] init];
    config.sBBackColor = [UIColor clearColor];
    config.itemF = [UIFont systemFontOfSize:15];
    config.itemNC = [UIColor lightGrayColor];
    config.itemSC = [UIColor redColor];
    config.indicatorC = [UIColor redColor];
    config.indicatorH = 2;
    config.indicatorW = 10;
    return config;
    
}

- (TBSegmentBarConfiguration *(^)(UIColor *))segmentBarBackColor{
    return ^(UIColor *color){
        self.sBBackColor = color;
        return self;
    };
}

- (TBSegmentBarConfiguration *(^)(UIFont *))itemFont{
    return ^(UIFont *font){
        self.itemF = font;
        return self;
    };
}

- (TBSegmentBarConfiguration *(^)(UIColor *))itemNormalColor{
    return ^(UIColor *color){
        self.itemNC = color;
        return self;
    };
}

- (TBSegmentBarConfiguration *(^)(UIColor *))itemSelectColor{
    return ^(UIColor *color){
        self.itemSC = color;
        return self;
    };
}

- (TBSegmentBarConfiguration *(^)(UIColor *))indicatorColor{
    return ^(UIColor *color){
        self.indicatorC = color;
        return self;
    };
}

- (TBSegmentBarConfiguration *(^)(CGFloat))indicatorHeight{
    return ^(CGFloat H){
        self.indicatorH = H;
        return self;
    };
}

- (TBSegmentBarConfiguration *(^)(CGFloat))indicatorExtraW{
    return ^(CGFloat W){
        self.indicatorW = W;
        return self;
    };
}


@end
