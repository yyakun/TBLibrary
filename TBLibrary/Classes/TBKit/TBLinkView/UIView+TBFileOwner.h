//
//  UIView+TBFileOwner.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TBFileOwner : NSObject

@property (nonatomic, weak) IBOutlet UIView *view;

+ (id)viewFromNibName:(NSString *)nibName;

@end

@interface UIView (TBFileOwner)

+ (id)loadFromNib;
+ (id)loadFromNibNamed:(NSString *)nibName;
+ (id)loadFromNibNoOwner:(NSString *)nibName;

@end
