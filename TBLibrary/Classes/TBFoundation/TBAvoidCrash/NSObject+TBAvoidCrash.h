//
//  NSObject+TBAvoidCrash.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/7/15.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (TBAvoidCrash)

+ (void)avoidCrashExchangeMethod;

@end

/**
 *  Can avoid crash method
 *
 *  1.- (void)setValue:(id)value forKey:(NSString *)key
 *  2.- (void)setValue:(id)value forKeyPath:(NSString *)keyPath
 *  3.- (void)setValue:(id)value forUndefinedKey:(NSString *)key //这个方法一般用来重写，不会主动调用
 *  4.- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues
 *
 */
