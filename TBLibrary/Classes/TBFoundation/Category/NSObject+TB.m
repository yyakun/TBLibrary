//
//  NSObject+TB.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSObject+TB.h"
#import "NSObject+TBJSonModel.h"

static NSString *TBNSObjectPropertyTypeListString = @"csiqlCSIQLfdBv*@#:[{(b";

@implementation TBPropertyInfo

@end

@implementation NSObject (TB)

+ (NSMutableDictionary *)TB_propertyInfosContainsReadOnly:(BOOL)containsReadOnly {
    NSMutableDictionary *keyPairs = [NSMutableDictionary dictionary];
    [self p_TB_enumeratePropertiesUsingBlock:^(objc_property_t property, BOOL *stop) {
        const char *propertyAttributes = property_getAttributes(property);
        NSArray *attributes = [[NSString stringWithUTF8String:propertyAttributes] componentsSeparatedByString:@","];
        BOOL isReadOnly = [attributes containsObject:@"R"];
        if (containsReadOnly || !isReadOnly) {
            NSString *key = @(property_getName(property));
            TBPropertyInfo *propertyInfo = [TBPropertyInfo new];
            propertyInfo.propertyName = key;
            
            //解析属性修饰符
            NSString *propertyEncode = nil;
            for (NSString *attributesString in attributes) {
                if ([attributesString characterAtIndex:0] == 'T') {
                    propertyEncode = [attributesString substringFromIndex:1];
                    continue;
                }
                if ([attributesString characterAtIndex:0] == 'G') {
                    propertyInfo.getter = NSSelectorFromString([attributesString substringFromIndex:1]);
                    continue;
                }
                if (!isReadOnly && [attributesString characterAtIndex:0] == 'S') {
                    propertyInfo.setter = NSSelectorFromString([attributesString substringFromIndex:1]);
                }
            }
            if (!propertyInfo.getter) {
                propertyInfo.getter = NSSelectorFromString(key);
            }
            if (!isReadOnly && !propertyInfo.setter) {
                propertyInfo.setter = NSSelectorFromString([NSString stringWithFormat:@"set%@%@:", [key substringToIndex:1].uppercaseString, [key substringFromIndex:1]]);
            }
            
            if (propertyEncode.length > 0) {//正常都应该满足
                char charForType = [propertyEncode characterAtIndex:0];//可以判断属性类型的字符
                if (charForType == '^') {
                    propertyInfo.isPointer = YES;
                    charForType = [propertyEncode characterAtIndex:1];
                }
                TBPropertyType type = [self p_TB_getPropertyTypeWithTypeKeyChar:charForType];
                propertyInfo.type = type;
                if (type == TBPropertyType_OCObject) {
                    if (propertyEncode.length > 3) {//当熟悉指定特定类型以后，最短的形式为T@"A"，至少有5个字符
                        NSString *typeClassName = [propertyEncode substringWithRange:NSMakeRange(2, [propertyEncode length]-3)];
                        Class typeClass = NSClassFromString(typeClassName);
                        if (typeClass) {
                            propertyInfo.aClass = typeClass;
                        }
                    }
                }
                propertyInfo.propertyTypeEncode = propertyEncode;
                [keyPairs setObject:propertyInfo forKey:key];
            }
        }
    }];
    return keyPairs;
}

+ (NSSet *)TB_allPropertyKeys {
    NSMutableSet *keys = [NSMutableSet set];
    [self p_TB_enumeratePropertiesUsingBlock:^(objc_property_t property, BOOL *stop) {
        NSString *key = @(property_getName(property));
        [keys addObject:key];
    }];
    
    return keys;
}

#pragma mark - private methods

/**
 *  根据熟悉类型的encode char判断熟悉的类型
 *  @return 属性的类型
 */
+ (TBPropertyType)p_TB_getPropertyTypeWithTypeKeyChar:(char)achar {
    NSString *charString = [NSString stringWithFormat:@"%c",achar];
    if ([TBNSObjectPropertyTypeListString rangeOfString:charString].location != NSNotFound) {
        return achar;
    }
    return TBPropertyType_Unknown;
}


/**
 *  类型遍历变量所需的迭代器
 *  一般情况下无需直接调用
 *
 *  @param block 每个迭代执行的操作
 */
+ (void)p_TB_enumeratePropertiesUsingBlock:(void (^)(objc_property_t property, BOOL *stop))block {
    Class cls = self;
    BOOL stop = NO;
    
    while (!stop && [cls isSubclassOfClass:[self class]]) {
        unsigned count = 0;
        objc_property_t *properties = class_copyPropertyList(cls, &count);
        
        cls = cls.superclass;
        if (properties == NULL) continue;
        for (unsigned i = 0; i < count; i++) {
            block(properties[i], &stop);
            if (stop) {
                break;
            }
        }
        free(properties);
    }
}

+ (instancetype)sharedInstance {
    NSAssert(NO, @"subclass not override this method，subclass : %@，file : %s, method : %@", NSStringFromClass([self class]), __FILE__, NSStringFromSelector(_cmd));
    return nil;
}

- (void)commonInit {
    NSAssert(NO, @"subclass not override this method，subclass : %@，file : %s, method : %@", NSStringFromClass([self class]), __FILE__, NSStringFromSelector(_cmd));
}

- (NSString *)keyValueString {
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *dictionary = [self jm_dictionaryRepresentation:NO];
    NSArray *array2 = dictionary.allKeys;
    for (int i = 0; i < array2.count; i++) {
        NSString *key = array2[i];
        NSString *value = dictionary[key];
        NSString *str = [NSString stringWithFormat:@"%@=%@", key, value];
        [array addObject:str];
    }
    return [array componentsJoinedByString:@","];
}

- (void)saveObjectWithKey:(NSString *)key {
    if (!self) {
        NSLog(@"储存失败，存储对象为空");
        return;
    }
    if ([self isKindOfClass:[NSString class]]) {
        if (((NSString *)self).length == 0) {
            NSLog(@"储存失败，字符串是空的");
            return;
        }
    }
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)loadObjectWithKey:(NSString *)key {
    if (key.length == 0) {
        return nil;
    }
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

- (NSString *)debugDescription {
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        NSString *name = @(property_getName(properties[i]));
        id value = [self valueForKey:name] ?: @"nil";
        [dictionary setObject:value forKey:name];
    }
    free(properties);
    if (dictionary.count == 0) {
        return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class], self, self];
    }
    return [NSString stringWithFormat:@"<%@: %p> -- %@",[self class], self, dictionary];;
}

@end
