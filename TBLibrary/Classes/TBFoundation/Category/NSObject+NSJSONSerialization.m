//
//  NSObject+NSJSONSerialization.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/8/23.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSObject+NSJSONSerialization.h"

@implementation NSString (NSJSONSerialization)

- (id)TB_JSONValue {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonObject) {
        NSLog(@"JSONValue error: %@", error);
        return nil;
    }
    return jsonObject;
}

@end


@implementation NSObject (NSJSONSerialization)

- (NSString *)TB_JSONRepresentation {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        NSLog(@"RTJSONRepresentation error: %@", error);
        return @"";
    }
    NSString* jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

@end
