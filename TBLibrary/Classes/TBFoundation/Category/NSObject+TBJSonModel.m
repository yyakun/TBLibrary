//
//  NSObject+TBJSonModel.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSObject+TBJSonModel.h"
#import "NSObject+TB.h"

@implementation NSObject (TBJSonModel)

#pragma mark - toDictObject methods
- (id)jm_dictionaryRepresentation:(BOOL)containsReadOnly {
    if ([[self class] isSubclassOfClass:[NSNumber class]] || [[self class] isSubclassOfClass:[NSString class]] || [[self class] isSubclassOfClass:[NSDictionary class]]) {
        return self;
    }
    if ([[self class] isSubclassOfClass:[NSArray class]]) {
        NSMutableArray *returnArray = [NSMutableArray array];
        NSArray *array = (NSArray *)self;
        for (id arrayObject in array) {
            [returnArray addObject:[arrayObject jm_dictionaryRepresentation:containsReadOnly]];
        }
        return returnArray;
    }
    
    NSMutableDictionary *returnDict = [NSMutableDictionary dictionary];
    NSDictionary *propertyInfos = [[self class] TB_propertyInfosContainsReadOnly:containsReadOnly];
    for (NSString *key in [propertyInfos allKeys]) {
        TBPropertyInfo *info = propertyInfos[key];
        id value = [self valueForKey:key];
        if (info.class) {
            value = [value jm_dictionaryRepresentation:containsReadOnly];
        }
        [self jm_setObject:value forKey:key toDict:returnDict];
    }
    return [returnDict copy];
}

- (void)jm_setObject:(id)anObject forKey:(NSString *)aKey toDict:(NSMutableDictionary *)dict {
    if (!anObject) {
        anObject = @"nil";
    }
    [dict setObject:anObject forKey:aKey];
}

#pragma mark - toOCObject methods
- (void)jm_refreshPorpertyValueWithData:(id)data {
    [self jm_refreshPorpertyValueWithData:data withDiscrepantKeyPairs:nil];
}

- (void)jm_refreshPorpertyValueWithData:(id)data useDiscrepantKeyPairs:(BOOL)useDiscrepantKeyPairs {
    NSDictionary *discrepantDictionary = nil;
    if (useDiscrepantKeyPairs && [self respondsToSelector:@selector(discrepantKeyPairs)]) {
        discrepantDictionary = [self performSelector:@selector(discrepantKeyPairs)];
    }
    [self jm_refreshPorpertyValueWithData:data withDiscrepantKeyPairs:discrepantDictionary];
}

- (void)jm_refreshPorpertyValueWithData:(id)data withDiscrepantKeyPairs:(NSDictionary *)discrepantKeyPairs {
    if (discrepantKeyPairs) {
        NSMutableArray *outerKeys = [NSMutableArray array];
        NSArray *innerKeys = [discrepantKeyPairs allKeys];
        [innerKeys enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [outerKeys addObject:discrepantKeyPairs[obj]];
        }];
        [self jm_refreshPorpertyValueWithData:data discrepantInnerKeys:innerKeys discrepantOuterKeys:outerKeys];
        return;
    }
    [self jm_refreshPorpertyValueWithData:data discrepantInnerKeys:nil discrepantOuterKeys:nil];
}

- (void)jm_refreshPorpertyValueWithData:(id)data discrepantInnerKeys:(NSArray *)innerKeys discrepantOuterKeys:(NSArray *)outerKeys {
    if (innerKeys.count != outerKeys.count) {
        NSLog(@"property array discrepant for inner and outer has not the same amount:%@  %@", innerKeys, outerKeys);
        return;
    }
    
    NSDictionary *writableInnerPropertyInfos = [[self class] TB_propertyInfosContainsReadOnly:NO];
    NSDictionary *readableOuterPropertyInfos = [[data class] TB_propertyInfosContainsReadOnly:YES];
    
    BOOL isDictionary = [data isKindOfClass:[NSDictionary class]];
    
    for (NSString *propertyName in writableInnerPropertyInfos) {
        NSUInteger index = [innerKeys indexOfObject:propertyName];
        NSString *outerPropertyName = propertyName;
        
        if(NSNotFound != index && outerKeys.count) {
            outerPropertyName = outerKeys[index];
        }
        
        TBPropertyInfo *innerInfo = writableInnerPropertyInfos[propertyName];
        TBPropertyInfo *outerInfo = readableOuterPropertyInfos[outerPropertyName];
        
        if (!isDictionary && (!innerInfo || !outerInfo)) {
            continue;
        }
        
        id value = [data valueForKey:outerPropertyName];
        switch (innerInfo.type) {
            case TBPropertyType_Int64:
            case TBPropertyType_UInt64:
            {
                long long longToSet = 0ll;
                SEL setterSEL = innerInfo.setter;
                IMP imp = [self methodForSelector: setterSEL];
                if ([value isKindOfClass:[NSNumber class]]) {
                    [(NSValue *)value getValue:&longToSet];
                    ((void (*)(id, SEL, long long))imp)(self, setterSEL, longToSet);
                }
            }
                break;
            case TBPropertyType_Sel:
            {
                SEL getterSEL = outerInfo.getter;
                IMP getterIMP = [self methodForSelector: getterSEL];
                id value = [NSValue valueWithPointer:((SEL (*)(id, SEL))getterIMP)(data, getterSEL)];
                SEL selToSet;
                SEL setterSEL = innerInfo.setter;
                IMP imp = [self methodForSelector: setterSEL];
                [(NSValue *)value getValue:&selToSet];
                ((void (*)(id, SEL, SEL))imp)(self, setterSEL, selToSet);
            }
                break;
            default:{
                if ([value isKindOfClass:[NSNull class]]) {
                    continue;
                }
                NSError *error;
                if (value && [self validateValue:&value forKey:propertyName error:&error]) {
                    [self setValue:value forKey:propertyName];
                }
            }
                break;
        }
    }
}

+ (NSArray *)loadArrayPropertyWithDataSource:(NSArray *)arrayData requireModel:(NSString *)modelClass {
    if (![arrayData isKindOfClass:[NSArray class]]) {
        NSLog(@"load array property error, data is not array: %@", arrayData);
        return nil;
    }
    Class aClass = NSClassFromString(modelClass);
    if (!aClass) {
        NSLog(@"load array property error, model Class not exists: %@", modelClass);
        return nil;
    }
    
    NSMutableArray *objects = [NSMutableArray array];
    for (id element in arrayData) {
        if([element isKindOfClass:NSClassFromString(modelClass)]) {
            [objects addObject:element];
        } else {
            id model = [[NSClassFromString(modelClass) alloc] init];
            [model jm_refreshPorpertyValueWithData:element useDiscrepantKeyPairs:YES];
            [objects addObject:model];
        }
    }
    return objects;
}

+ (NSArray *)loadArrayPropertyWithDataSource:(NSArray *)arrayData requireModel:(NSString *)modelClass discrepantKeys:(NSDictionary *)discrepantKeys {
    if (![arrayData isKindOfClass:[NSArray class]]) {
        NSLog(@"load array property error, data is not array: %@", arrayData);
        return nil;
    }
    Class aClass = NSClassFromString(modelClass);
    if (!aClass) {
        NSLog(@"load array property error, model Class not exists: %@", modelClass);
        return nil;
    }
    
    NSMutableArray *objects = [NSMutableArray array];
    for (id element in arrayData) {
        if([element isKindOfClass:NSClassFromString(modelClass)]) {
            [objects addObject:element];
        } else {
            id model = [[NSClassFromString(modelClass) alloc] init];
            [model jm_refreshPorpertyValueWithData:element withDiscrepantKeyPairs:discrepantKeys];
            [objects addObject:model];
        }
    }
    
    return objects;
}

@end
