//
//  NSArray+TBSorted.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSArray+TBSorted.h"
#import "NSString+TB.h"

@implementation NSArray (TB)

- (NSMutableArray *)replaceObjectFromStringTypeToNumberType {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < self.count; i++) {
        NSNumber *number = [[NSString stringWithFormat:@"%@", self[i]] replaceNumberFromStringTypeToNumberType];
        [array addObject:number];
    }
    return array;
}

+ (NSMutableArray *)arrayWithSet:(NSSet *)set {
    NSMutableArray *array = [NSMutableArray array];
    for (id obj in set) {
        [array addObject:obj];
    }
    return array;
}

@end

@implementation NSArray (TBSorted)

- (NSArray *)sortedOpposite {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    for (int i = 0; i < self.count; i++) {
        [array replaceObjectAtIndex:(self.count - 1 - i) withObject:self[i]];
    }
    return array;
}

NSInteger customSort(id obj1, id obj2, void *isAscending) {
    if ([obj1 integerValue] > [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedDescending;
    }
    if ([obj1 integerValue] < [obj2 integerValue]) {
        return (NSComparisonResult)NSOrderedAscending;
    }
    return (NSComparisonResult)NSOrderedAscending;
}

- (NSArray *)sortedByUsingComparator:(BOOL)isAscending {
    NSComparator comparator = ^(id obj1, id obj2) {
        if ([obj1 isKindOfClass:[NSNumber class]] || [obj2 isKindOfClass:[NSNumber class]]) {
            obj1 = [NSString stringWithFormat:@"%@", obj1];
            obj2 = [NSString stringWithFormat:@"%@", obj2];
        }
        if ([obj1 isKindOfClass:[NSString class]] && [obj2 isKindOfClass:[NSString class]]) {
            if ([obj1 integerValue] > [obj2 integerValue]) {
                if (isAscending) {
                    return (NSComparisonResult)NSOrderedDescending;
                }
                return (NSComparisonResult)NSOrderedAscending;
            }
            if ([obj1 integerValue] < [obj2 integerValue]) {
                if (isAscending) {
                    return (NSComparisonResult)NSOrderedAscending;
                }
                return (NSComparisonResult)NSOrderedDescending;
            }
        }
        return (NSComparisonResult)NSOrderedSame;
    };
    return [self sortedArrayUsingComparator:comparator];
}

- (NSArray *)sortedByUsingFunction {
    return [self sortedArrayUsingFunction:customSort context:nil];
}

- (NSArray *)sortedBySortDescriptorWithKey:(NSString *)key ascending:(BOOL)isAscending {
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:key ascending:isAscending];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
    [mutableArray sortUsingDescriptors:sortDescriptors];
    return mutableArray;
}

- (NSArray *)sortedByRandom {
    return [self sortedArrayUsingComparator:(NSComparator)^(id obj1, id obj2) {
        return (arc4random() % 3) - 1;
    }];
}

@end
