//
//  NSURL+TB.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSURL+TB.h"

@implementation NSURL (TB)

+ (instancetype)TB_URLWithString:(NSString *)URLString {
    NSString *string = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return [self URLWithString:string];
}

@end
