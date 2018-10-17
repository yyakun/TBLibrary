//
//  NSDictionary+TB.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSDictionary+TB.h"

@implementation NSDictionary (TB)

- (NSDictionary *)dictionaryFromDropKeyArray:(NSArray *)dropKeyArray {
    NSMutableArray *keyArray = [NSMutableArray arrayWithArray:self.allKeys];
    [keyArray removeObjectsInArray:dropKeyArray];
    NSMutableDictionary *keyValueDictionary = [NSMutableDictionary dictionary];
    for (NSString *key in keyArray) {
        NSString *value = self[key];
        [keyValueDictionary setObject:value forKey:key];
    }
    return keyValueDictionary;
}

@end
