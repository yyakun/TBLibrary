//
//  TBDatabase.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBDatabase.h"
#import <FMDB/FMDB.h>
#import "TBBaseDatabaseTable.h"
#import "TBFileAssistant.h"
#import "NSString+TB.h"
#import "NSObject+TB.h"
#import "NSObject+TBJSonModel.h"

#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }

FMDatabase *__db;

@implementation TBDatabase

#pragma mark - FMDB Execute
+ (BOOL)initDatabaseWithTableFileName:(NSString *)tableFileName SQLString:(NSString *)SQLString {
    [TBFileAssistant copyBundlePathFileWithAbsolutePath:tableFileName toSystemDirectoryType:TBFileSystemPathDocument];
    __db = [FMDatabase databaseWithPath:[TBFileAssistant absolutePathWithUserPath:tableFileName systemDirectoryType:TBFileSystemPathDocument]];
    return [TBDatabase updateDataWithSQLString:SQLString];
}

+ (BOOL)createTableWithTableFileName:(NSString *)tableFileName SQLString:(NSString *)SQLString {
    if ([__db open] && [__db tableExists:tableFileName]) {
        NSLog(@"table is already exist");
        return NO;
    } else {
        if ([self initDatabaseWithTableFileName:tableFileName SQLString:SQLString]) {
            NSLog(@"create table success");
            return YES;
        } else {
            NSLog(@"fail to create table");
            return NO;
        }
    }
}

+ (BOOL)dropTableWithTableName:(NSString *)tableName {
    return [self updateDataWithSQLString:TBDropTableSQLString(tableName)];
}

+ (FMResultSet *)queryDataWithSQLString:(NSString *)SQLString {
    FMDBQuickCheck([__db open])
    FMResultSet *rs = [__db executeQuery:SQLString];
    FMDBQuickCheck(![__db hadError]);
    FMDBQuickCheck(rs);
    return rs;
}

+ (BOOL)updateDataWithSQLString:(NSString *)SQLString {
    FMDBQuickCheck([__db open])
    BOOL success = [__db executeUpdate:SQLString];
    FMDBQuickCheck(![__db hadError]);
    [__db close];
    return success;
}

+ (BOOL)alterTableWithSQLString:(NSString *)SQLString {
    return [self updateDataWithSQLString:SQLString];
}

+ (NSInteger)queryCountWithSQLString:(NSString *)SQLString {
    FMResultSet *rs = [self queryDataWithSQLString:SQLString];
    [rs next];
    NSInteger count = 0;
    NSString *string = [SQLString deleteBlankString];
    if ([string containsString:@"selectcount("]) {
        count = [rs intForColumnIndex:0];
    } else {
        count = [rs columnCount];
    }
    [__db close];
    return count;
}

+ (NSInteger)selectNumberWithSQLString:(NSString *)SQLString {
    FMResultSet *rs = [self queryDataWithSQLString:SQLString];
    [rs next];
    NSString *string = [SQLString deleteBlankString];// 删除字符串里的空格字符
    NSRange range1 = [string rangeOfString:@"where"];
    NSRange range2 = [string rangeOfString:@"=(select"];
    NSString *columnName = [string substringWithRange:NSMakeRange(range1.location + range1.length, range2.location - range1.location - range1.length)];
    NSInteger number = [rs intForColumn:columnName];
    [__db close];
    return number;
}

+ (NSString *)queryColumnNameWithTableName:(NSString *)tableName index:(int)index {
    FMResultSet *rs = [self queryDataWithSQLString:TBQueryAllDataSQLString(tableName)];
    [rs next];
    NSString *columnName = [rs columnNameForIndex:index];
    [__db close];
    return columnName;
}

+ (NSMutableArray *)selectDataWithSQLString:(NSString *)SQLString {
    FMResultSet *rs = [self queryDataWithSQLString:SQLString];
    NSMutableArray *array = [NSMutableArray array];
    while ([rs next]) {
        [array addObject:[rs resultDictionary]];
    }
    [__db close];
    return array;
}

#pragma mark - Get Count
+ (NSInteger)queryAllCountWithTableName:(NSString *)tableName {
    return [self queryCountWithSQLString:TBQueryAllDataCountSQLString(tableName)];
}

+ (NSInteger)queryCountWithTableName:(NSString *)tableName condition:(NSString *)condition {
    return [self queryCountWithSQLString:TBQueryDataCountSQLString(tableName, condition)];
}

+ (NSInteger)queryColumnCountWithTableName:(NSString *)tableName {
    return [self queryCountWithSQLString:TBQueryAllDataSQLString(tableName)];
}

+ (NSInteger)queryMaxNumberWithTableName:(NSString *)tableName columnName:(NSString *)columnName {
    return [self selectNumberWithSQLString:TBQueryMaxNumberSQLString(tableName, columnName)];
}

+ (NSInteger)queryMinNumberWithTableName:(NSString *)tableName columnName:(NSString *)columnName {
    return [self selectNumberWithSQLString:TBQueryMinNumberSQLString(tableName, columnName)];
}

#pragma mark - Get Data
+ (NSMutableArray *)allDataWithTableName:(NSString *)tableName {
    return [self selectDataWithSQLString:TBQueryAllDataSQLString(tableName)];
}

+ (NSMutableArray *)selectDataWithTableName:(NSString *)tableName condition:(NSString *)condition {
    return [self selectDataWithSQLString:TBQueryDataByUsingWhereKeywordSQLString(tableName, condition)];
}

#pragma mark - Insert & Update & Delete Data
+ (BOOL)insertOneDataWithTableName:(NSString *)tableName object:(TBBaseDatabaseTable *)object {
    return [self insertOneDataWithTableName:tableName object:object propertyNameArray:@[]];
}

+ (BOOL)insertOneDataWithTableName:(NSString *)tableName object:(TBBaseDatabaseTable *)object propertyNameArray:(NSArray *)propertyNameArray {
    NSDictionary *dictionary = [object jm_dictionaryRepresentation:NO];
    NSMutableDictionary *mutableDictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    [mutableDictionary setObject:@(object.primaryKey_id) forKey:@"primaryKey_id"];
    NSMutableArray *keyArray = [NSMutableArray arrayWithArray:mutableDictionary.allKeys];
    [keyArray removeObjectsInArray:propertyNameArray];
    NSMutableArray *valueArray = [NSMutableArray array];
    NSMutableString *valueString = [NSMutableString string];
    for (NSString *key in keyArray) {
        NSString *value = mutableDictionary[key];
        [valueArray addObject:value];
        [valueString appendFormat:@"%@,", value];
    }
    if ([valueString containsString:@"nil"]) {
        [valueString deleteCharactersInRange:[valueString rangeOfString:@"nil,"]];
    }
    [valueString deleteCharactersInRange:NSMakeRange(valueString.length - 1, 1)];
    NSString *keyString = [keyArray componentsJoinedByString:@","];
    FMDBQuickCheck([__db open])
    BOOL success = [__db executeUpdate:TBInsertDataSQLString(tableName, keyString, valueString)];
    FMDBQuickCheck(![__db hadError]);
    [__db close];
    return success;
}

+ (BOOL)insertPartOfDataWithTableName:(NSString *)tableName tableFileName:(NSString *)tableFileName objects:(NSArray *)objects {
    FMDatabaseQueue *databaseQueue = [FMDatabaseQueue databaseQueueWithPath:[TBFileAssistant absolutePathWithUserPath:tableFileName systemDirectoryType:TBFileSystemPathDocument]];
    [databaseQueue inDatabase:^(FMDatabase *db) {
        for (TBBaseDatabaseTable *obj in objects) {
            [self insertOneDataWithTableName:tableName object:obj];
        }
    }];
    return YES;
}

+ (BOOL)updatePartOfDataWithTableName:(NSString *)tableName tableFileName:(NSString *)tableFileName objects:(NSArray *)objects columnName:(NSString *)columnName primaryKey_id:(long long)primaryKey_id {
    FMDBQuickCheck([__db open])
    FMDatabaseQueue *databaseQueue = [FMDatabaseQueue databaseQueueWithPath:[TBFileAssistant absolutePathWithUserPath:tableFileName systemDirectoryType:TBFileSystemPathDocument]];
    __block BOOL success = NO;
    [databaseQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        int i = 0;
        while (i < objects.count) {
            success = [db executeUpdate:TBUpdateDataSQLString(tableName, [objects[i] keyValueString], TBQueryOneDataString(columnName, primaryKey_id + i))];
            if (!success) {
                *rollback = YES;
            }
            i++;
        }
    }];
    FMDBQuickCheck(![__db hadError]);
    [__db close];
    return success;
}

+ (BOOL)updateOneDataWithTableName:(NSString *)tableName object:(NSObject *)object condition:(NSString *)condition {
    return [self updateDataWithSQLString:TBUpdateDataSQLString(tableName, [object keyValueString], condition)];
}

+ (BOOL)deleteAllDataWithTableName:(NSString *)tableName {
    return [self updateDataWithSQLString:TBDeleteAllDataSQLString(tableName)];
}

+ (BOOL)deleteDataWithTableName:(NSString *)tableName condition:(NSString *)condition {
    return [self updateDataWithSQLString:TBDeleteDataSQLString(tableName, condition)];
}

@end
