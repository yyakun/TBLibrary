//
//  TBSegmentBarViewController.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/7/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBSegmentBar.h"

@interface TBSegmentBarViewController : UIViewController

@property (nonatomic, strong) TBSegmentBar * segmentBar;

- (void)setUpWithItems: (NSArray <NSString *>*)items childVCs: (NSArray <UIViewController *>*)childVCs;

@end
