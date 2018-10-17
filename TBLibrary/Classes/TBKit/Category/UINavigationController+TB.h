//
//  UINavigationController+TB.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (TB)

@property (nonatomic, copy) NSString *backIconName;

- (void)TB_PushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
