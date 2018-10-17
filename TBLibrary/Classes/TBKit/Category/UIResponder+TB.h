//
//  UIResponder+TB.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (TB)

- (void)setupUI;
- (void)setupLayout;
- (void)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer;
- (void)clicked:(id)sender;
- (void)addViewsTapGestureRecognizer:(NSArray *)views;

@end
