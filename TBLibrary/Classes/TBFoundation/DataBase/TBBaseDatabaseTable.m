//
//  TBBaseDatabaseTable.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBBaseDatabaseTable.h"
#import <objc/runtime.h>
#import "TBDatabase.h"
#import "NSArray+TBSorted.h"

@implementation TBBaseDatabaseTable

#pragma mark - About Table
+ (NSString *)tableName {
    return NSStringFromClass([self class]);
}

+ (NSString *)tableFileName {
    return [NSString stringWithFormat:@"%@.sqlite", [self tableName]];
}

+ (NSString *)createTableSQLString {
    NSAssert(NO, @"\nfile: %s  line: %d  function: %s  content: 必须在子类中重写此方法", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  __LINE__, __FUNCTION__);
    return nil;
}

#pragma mark - Create & Drop & Alter Table
+ (BOOL)createTable {
    return [TBDatabase createTableWithTableFileName:[self tableFileName] SQLString:TBCreateTableSQLString([self tableName], [self createTableSQLString])];
}

+ (BOOL)dropTable {
    return [TBDatabase dropTableWithTableName:[self tableName]];
}

#pragma mark - Get Count
+ (long long)allDataCount {
    return [TBDatabase queryAllCountWithTableName:[self tableName]];
}

+ (long long)partOfDataCountWithCondition:(NSString *)condition {
    return [TBDatabase queryCountWithTableName:[self tableName] condition:condition];
}

+ (long long)partOfDataCountWithStart_id:(long long)start_id end_id:(long long)end_id {
    return [self partOfDataCountWithCondition:TBQueryTableDataString(start_id, end_id)];
}

+ (long long)queryMaxDataWithColumnName:(NSString *)columnName {
    return [TBDatabase queryMaxNumberWithTableName:[self tableName] columnName:columnName];
}

+ (long long)queryMinDataWithColumnName:(NSString *)columnName {
    return [TBDatabase queryMinNumberWithTableName:[self tableName] columnName:columnName];
}

+ (NSString *)queryColumnNameWithIndex:(int)index {
    return [TBDatabase queryColumnNameWithTableName:[self tableName] index:index];
}

+ (BOOL)alterTableWithSetColumnNameString:(NSString *)setColumnNameString {
    return [TBDatabase updateDataWithSQLString:TBAlterTableSQLString([self tableName], setColumnNameString)];
}

+ (NSMutableArray *)orderTableWithColumnName:(NSString *)columnName ascending:(BOOL)isAscending {
    NSString *order = nil;
    if (isAscending) {
        order = @"ASC";
    } else {
        order = @"DESC";
    }
    NSString *orderString = [NSString stringWithFormat:@"%@ %@", columnName, order];
    return [TBDatabase selectDataWithSQLString:TBOrderDataSQLString([self tableName], orderString)];
}

#pragma mark - Get Data
+ (NSMutableArray *)allData {
    NSArray *array = [[[self class] new] changeArrayStructure:[TBDatabase allDataWithTableName:[self tableName]]];
    NSMutableArray *array2 = [NSMutableArray array];
    for (NSArray *arr in array) {
        [array2 addObject:[arr sortedOpposite]];
    }
    return array2;
}

+ (NSMutableArray *)partOfDataWithCondition:(NSString *)condition {
    return [TBDatabase selectDataWithTableName:[self tableName] condition:condition];
}

+ (NSMutableArray *)oneDataWithPrimaryKey_id:(long long)primaryKey_id {
    return [[[self class] new] changeArrayStructure:[self partOfDataWithCondition:TBQueryTableOneDataString(primaryKey_id)]];
}

+ (NSMutableArray *)partOfDataWithStart_id:(long long)start_id end_id:(long long)end_id {
    return [[[self class] new] changeArrayStructure:[self partOfDataWithCondition:TBQueryDataString(@"primaryKey_id", start_id, end_id)]];
}

#pragma mark - Insert Data
+ (BOOL)insertOneDataWithObject:(TBBaseDatabaseTable *)object {
    return [TBDatabase insertOneDataWithTableName:[self tableName] object:object];
}

+ (BOOL)insertOneDataWithObject:(TBBaseDatabaseTable *)object propertyNameArray:(NSArray *)propertyNameArray {
    return [TBDatabase insertOneDataWithTableName:[self tableName] object:object propertyNameArray:propertyNameArray];
}

+ (BOOL)insertOneDataWithObject:(TBBaseDatabaseTable *)object primaryKey_id:(long long)primaryKey_id {
    object.primaryKey_id = primaryKey_id;
    return [self insertOneDataWithObject:object];
}

+ (BOOL)insertPartOfDataWithObjects:(NSArray *)objects {
    return [TBDatabase insertPartOfDataWithTableName:[self tableName] tableFileName:[self tableFileName] objects:objects];
}

#pragma mark - Update Data
+ (BOOL)updateOneDataWithObject:(TBBaseDatabaseTable *)object condition:(NSString *)condition {
    return [TBDatabase updateOneDataWithTableName:[self tableName] object:object condition:condition];
}

+ (BOOL)updateOneDataWithObject:(TBBaseDatabaseTable *)object primaryKey_id:(long long)primaryKey_id {
    return [self updateOneDataWithObject:object condition:TBQueryTableOneDataString(primaryKey_id)];
}

+ (BOOL)updatePartOfDataWithObjects:(NSArray *)objects start_id:(long long)start_id {
    return [TBDatabase updatePartOfDataWithTableName:[self tableName] tableFileName:[self tableFileName] objects:objects columnName:@"primaryKey_id" primaryKey_id:start_id];
}

#pragma mark - Delete Data
+ (BOOL)deleteAllData {
    return [TBDatabase deleteAllDataWithTableName:[self tableName]];
}

+ (BOOL)deletePartOfDataWithCondition:(NSString *)condition {
    return [TBDatabase deleteDataWithTableName:[self tableName] condition:condition];
}

+ (BOOL)deleteOneDataWithPrimaryKey_id:(long long)primaryKey_id {
    return [self deletePartOfDataWithCondition:TBQueryTableOneDataString(primaryKey_id)];
}

+ (BOOL)deletePartOfDataWithStart_id:(long long)start_id end_id:(long long)end_id {
    return [self deletePartOfDataWithCondition:TBQueryTableDataString(start_id, end_id)];
}

#pragma mark - Private Method
- (NSMutableArray *)changeArrayStructure:(NSMutableArray *)array {
    NSMutableArray *propertyArray = [NSMutableArray arrayWithObjects:@"primaryKey_id", nil];
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (int k = 0; k < outCount; k++) {
        NSString *propertyName = [NSString stringWithCString:property_getName(properties[k]) encoding:NSUTF8StringEncoding];
        [propertyArray addObject:propertyName];
    }
    NSMutableArray *array2 = [NSMutableArray array];
    for (int i = 0; i < propertyArray.count; i++) {
        NSMutableArray *arr = [NSMutableArray array];
        [array2 addObject:arr];
    }
    for (int j = 0; j < array.count; j++) {
        for (int k = 0; k < propertyArray.count; k++) {
            NSString *columnName = propertyArray[k];
            [array2[k] addObject:array[j][columnName]];
        }
    }
    return array2;
}

@end
