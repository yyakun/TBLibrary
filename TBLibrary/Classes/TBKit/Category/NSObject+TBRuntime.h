//
//  NSObject+TBRuntime.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSObject (TBRuntime)

@property (nonatomic, strong) id userInfo;
@property (nonatomic, copy) NSString *objectIdentifier;

@end
