//
//  NSString+TBAvoidCrash.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/7/15.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSString+TBAvoidCrash.h"

#import "TBAvoidCrash.h"

@implementation NSString (TBAvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class stringClass = NSClassFromString(@"__NSCFConstantString");
        
        //characterAtIndex
        [TBAvoidCrash exchangeInstanceMethod:stringClass method1Sel:@selector(characterAtIndex:) method2Sel:@selector(avoidCrashCharacterAtIndex:)];
        
        //substringFromIndex
        [TBAvoidCrash exchangeInstanceMethod:stringClass method1Sel:@selector(substringFromIndex:) method2Sel:@selector(avoidCrashSubstringFromIndex:)];
        
        //substringToIndex
        [TBAvoidCrash exchangeInstanceMethod:stringClass method1Sel:@selector(substringToIndex:) method2Sel:@selector(avoidCrashSubstringToIndex:)];
        
        //substringWithRange:
        [TBAvoidCrash exchangeInstanceMethod:stringClass method1Sel:@selector(substringWithRange:) method2Sel:@selector(avoidCrashSubstringWithRange:)];
        
        //stringByReplacingOccurrencesOfString:
        [TBAvoidCrash exchangeInstanceMethod:stringClass method1Sel:@selector(stringByReplacingOccurrencesOfString:withString:) method2Sel:@selector(avoidCrashStringByReplacingOccurrencesOfString:withString:)];
        
        //stringByReplacingOccurrencesOfString:withString:options:range:
        [TBAvoidCrash exchangeInstanceMethod:stringClass method1Sel:@selector(stringByReplacingOccurrencesOfString:withString:options:range:) method2Sel:@selector(avoidCrashStringByReplacingOccurrencesOfString:withString:options:range:)];
        
        //stringByReplacingCharactersInRange:withString:
        [TBAvoidCrash exchangeInstanceMethod:stringClass method1Sel:@selector(stringByReplacingCharactersInRange:withString:) method2Sel:@selector(avoidCrashStringByReplacingCharactersInRange:withString:)];
    });
    
}


//=================================================================
//                           characterAtIndex:
//=================================================================
#pragma mark - characterAtIndex:

- (unichar)avoidCrashCharacterAtIndex:(NSUInteger)index {
    
    unichar characteristic;
    @try {
        characteristic = [self avoidCrashCharacterAtIndex:index];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = @"This framework default is to return a without assign unichar.";
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return characteristic;
    }
}

//=================================================================
//                           substringFromIndex:
//=================================================================
#pragma mark - substringFromIndex:

- (NSString *)avoidCrashSubstringFromIndex:(NSUInteger)from {
    
    NSString *subString = nil;
    
    @try {
        subString = [self avoidCrashSubstringFromIndex:from];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = TBAvoidCrashDefaultReturnNil;
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        subString = nil;
    }
    @finally {
        return subString;
    }
}

//=================================================================
//                           substringToIndex
//=================================================================
#pragma mark - substringToIndex

- (NSString *)avoidCrashSubstringToIndex:(NSUInteger)to {
    
    NSString *subString = nil;
    
    @try {
        subString = [self avoidCrashSubstringToIndex:to];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = TBAvoidCrashDefaultReturnNil;
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        subString = nil;
    }
    @finally {
        return subString;
    }
}


//=================================================================
//                           substringWithRange:
//=================================================================
#pragma mark - substringWithRange:

- (NSString *)avoidCrashSubstringWithRange:(NSRange)range {
    
    NSString *subString = nil;
    
    @try {
        subString = [self avoidCrashSubstringWithRange:range];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = TBAvoidCrashDefaultReturnNil;
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        subString = nil;
    }
    @finally {
        return subString;
    }
}

//=================================================================
//                stringByReplacingOccurrencesOfString:
//=================================================================
#pragma mark - stringByReplacingOccurrencesOfString:

- (NSString *)avoidCrashStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self avoidCrashStringByReplacingOccurrencesOfString:target withString:replacement];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = TBAvoidCrashDefaultReturnNil;
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}

//=================================================================
//  stringByReplacingOccurrencesOfString:withString:options:range:
//=================================================================
#pragma mark - stringByReplacingOccurrencesOfString:withString:options:range:

- (NSString *)avoidCrashStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    
    NSString *newStr = nil;
    
    @try {
        newStr = [self avoidCrashStringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = TBAvoidCrashDefaultReturnNil;
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}


//=================================================================
//       stringByReplacingCharactersInRange:withString:
//=================================================================
#pragma mark - stringByReplacingCharactersInRange:withString:

- (NSString *)avoidCrashStringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {

    
    NSString *newStr = nil;
    
    @try {
        newStr = [self avoidCrashStringByReplacingCharactersInRange:range withString:replacement];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = TBAvoidCrashDefaultReturnNil;
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        newStr = nil;
    }
    @finally {
        return newStr;
    }
}


@end
