//
//  NSString+TBDecimalNumber.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/9/4.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSString+TBDecimalNumber.h"

@implementation NSString (TBDecimalNumber)

- (NSString *)priceByAdding:(NSString *)number {
    NSDecimalNumber *numberA = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *numberB = [NSDecimalNumber decimalNumberWithString:number];
    NSDecimalNumber *result = [numberA decimalNumberByAdding:numberB];
    return result.stringValue;
}

- (NSString *)priceBySubtracting:(NSString *)number {
    NSDecimalNumber *numberA = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *numberB = [NSDecimalNumber decimalNumberWithString:number];
    NSDecimalNumber *result = [numberA decimalNumberBySubtracting:numberB];
    return result.stringValue;
}

- (NSString *)priceByMultiplyingBy:(NSString *)number {
    NSDecimalNumber *numberA = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *numberB = [NSDecimalNumber decimalNumberWithString:number];
    NSDecimalNumber *result = [numberA decimalNumberByMultiplyingBy:numberB];
    return result.stringValue;
}

- (NSString *)priceByDividingBy:(NSString *)number {
    NSDecimalNumber *numberA = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *numberB = [NSDecimalNumber decimalNumberWithString:number];
    NSDecimalNumber *result = [numberA decimalNumberByDividingBy:numberB];
    return result.stringValue;
}

- (NSString *)priceByRaisingToPower:(NSUInteger)count {
    NSDecimalNumber *numberA = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber *result = [numberA decimalNumberByRaisingToPower:count];
    return result.stringValue;
}

+ (NSString *)stringByNotRounding:(NSString *)price afterPoint:(int)position roundingMode:(NSRoundingMode)roundingMode {
    NSDecimalNumberHandler* roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:roundingMode scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSDecimalNumber *ouncesDecimal;
    NSDecimalNumber *roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithString:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    return [NSString stringWithFormat:@"%@",roundedOunces];
}

@end
