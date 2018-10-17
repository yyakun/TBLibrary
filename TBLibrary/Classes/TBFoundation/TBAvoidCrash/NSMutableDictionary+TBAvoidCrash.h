//
//  NSMutableDictionary+TBAvoidCrash.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/7/15.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (TBAvoidCrash)

+ (void)avoidCrashExchangeMethod;

@end


/**
 *  Can avoid crash method
 *
 *  1. - (void)setObject:(id)anObject forKey:(id<NSCopying>)aKey
 *  2. - (void)removeObjectForKey:(id)aKey
 *
 */
