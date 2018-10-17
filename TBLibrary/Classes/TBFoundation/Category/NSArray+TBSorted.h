//
//  NSArray+TBSorted.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (TB)

- (NSMutableArray *)replaceObjectFromStringTypeToNumberType;
+ (NSMutableArray *)arrayWithSet:(NSSet *)set;

@end

@interface NSArray (TBSorted)

- (NSArray *)sortedOpposite;//  元素顺序颠倒，@[@(1),@(2),@(3),@(4)]变为@[@(4),@(3),@(2),@(1)]
- (NSArray *)sortedByUsingComparator:(BOOL)isAscending;//  数组排序，比较对象的integer属性
- (NSArray *)sortedByUsingFunction;//  同上

/**
 *  数组排序，数组里的元素是一个个有自己属性的对象
 *
 *  @param key       这个属性是数组中对象的属性，也可以是对象的keyPath
 *  @param isAscending 什序还是降序排列，YES为什序，NO为降序
 *
 *  @return 返回排过序的数组
 */
- (NSArray *)sortedBySortDescriptorWithKey:(NSString *)key ascending:(BOOL)isAscending;
- (NSArray *)sortedByRandom;//  随机排序，打乱数组中的顺序

@end
