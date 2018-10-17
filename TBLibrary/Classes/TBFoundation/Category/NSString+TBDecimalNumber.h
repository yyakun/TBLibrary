//
//  NSString+TBDecimalNumber.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/9/4.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TBDecimalNumber)
// 加
- (NSString *)priceByAdding:(NSString *)number;
// 减
- (NSString *)priceBySubtracting:(NSString *)number;
// 乘
- (NSString *)priceByMultiplyingBy:(NSString *)number;
// 除
- (NSString *)priceByDividingBy:(NSString *)number;
// 幂
- (NSString *)priceByRaisingToPower:(NSUInteger)count;

+ (NSString *)stringByNotRounding:(NSString *)price afterPoint:(int)position roundingMode:(NSRoundingMode)roundingMode;
@end
