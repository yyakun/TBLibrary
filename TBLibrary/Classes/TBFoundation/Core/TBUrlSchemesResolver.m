//
//  TBUrlSchemesResolver.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBUrlSchemesResolver.h"

NSString * const TBClassTypeToCreateKey = @"classTypeToCreate";

@implementation NSString (TBURLQueryResolver)

- (NSDictionary *)p_createQueryDictionary {
    NSMutableDictionary *temp = [NSMutableDictionary dictionary];
    NSArray *array = [self componentsSeparatedByString:@"&"];
    for (NSString *str in array) {
        NSRange rang = [str rangeOfString:@"="];
        if (rang.location != NSNotFound) {
            NSString *key = [str substringWithRange:NSMakeRange(0, rang.location)];
            NSInteger loc = rang.location + 1;
            NSString *value = [str substringWithRange:NSMakeRange(loc, str.length - loc)];
            value = [value QR_urlDecode];
            [temp setObject:value forKey:key];
        }
    }
    return  temp;
}

- (NSDictionary *)QR_queryItems {
    NSRange range = [self rangeOfString:@"?"];
    NSString *paramsString = self;
    if (range.location != NSNotFound) {
        paramsString = [self substringFromIndex:range.location + 1];
    }
    return [paramsString p_createQueryDictionary];
}

- (NSString *)QR_urlDecode {
    NSString *result = [self stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    return result.stringByRemovingPercentEncoding;
}

- (NSString *)QR_urlEncode {
    NSMutableString *output = [NSMutableString string];
    const unsigned char *source = (const unsigned char *)[self UTF8String];
    size_t sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

@end

@implementation TBUrlSchemesResolver

+ (id)createObjectFromUrlScheme:(NSString *)urlScheme {
    urlScheme = [self decode:urlScheme];
    NSMutableDictionary *queryItems = [[urlScheme QR_queryItems] mutableCopy];
    NSString *classTypeToCreate = nil;
    classTypeToCreate = queryItems[TBClassTypeToCreateKey];
    [queryItems removeObjectForKey:TBClassTypeToCreateKey];
    if (classTypeToCreate && classTypeToCreate.length > 0) {
        Class classType = NSClassFromString(classTypeToCreate);
        if (classType) {
            return [self createInstanceWithClassType:classType andParameterItems:queryItems];
        }
    }
    return nil;
}

+ (id)createInstanceWithClassType:(Class)classType andParameterItems:(NSDictionary *)queryItems {
    id classInstance = [classType new];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    NSDictionary *discrepantKeys = nil;
    if ([classInstance respondsToSelector:@selector(discrepantKeys)]  ) {
        discrepantKeys = [classInstance performSelector:@selector(discrepantKeys)];
    }
#pragma clang diagnostic pop
    for (NSString *key in [queryItems allKeys]) {
        NSString *propertyName = key;
        NSString *value = queryItems[key];
        if (discrepantKeys[propertyName]) {
            propertyName = discrepantKeys[propertyName];
        }
        if ([classInstance respondsToSelector:NSSelectorFromString(propertyName)]) {
            NSString *setterName = [NSString stringWithFormat:@"set%@%@:",
                                    [[propertyName substringToIndex:1] uppercaseString],
                                    [propertyName substringFromIndex:1]];
            SEL setter = NSSelectorFromString(setterName);
            NSMethodSignature *signature = [classInstance methodSignatureForSelector:setter];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
            [invocation setSelector:setter];
            [invocation setTarget:classInstance];
            void *parameter;
            const char* argType = [signature getArgumentTypeAtIndex:2];
            switch (argType[0]) {
                case 'i': case 's':case 'I':case 'S':{
                    NSInteger para = [value integerValue];
                    parameter = &para;
                    break;
                }
                case 'q':case 'Q':{
                    long long para = [value longLongValue];
                    parameter = &para;
                    break;
                }
                case 'f':{
                    float para = [value floatValue];
                    parameter = &para;
                    break;
                }
                case 'd':{
                    double para = [value doubleValue];
                    parameter = &para;
                    break;
                }
                case 'B':
                case 'c':{
                    BOOL para = [value boolValue];
                    parameter = &para;
                    break;
                }
                case '@':{
                    void *para = (__bridge void*)value;
                    parameter = &para;
                    break;
                }
                default:{
                    parameter = NULL;
                }
                    break;
            }
            [invocation setArgument:parameter atIndex:2];
            [invocation invoke];
        }
    }
    return classInstance;
}

/**
 *  解密用,可能需要,暂时没有实现
 *
 *  @param urlScheme 需要解码的字符串
 *
 *  @return 解码后的字符串
 */
+ (NSString *)decode:(NSString *)urlScheme {
    return urlScheme;
}

@end
