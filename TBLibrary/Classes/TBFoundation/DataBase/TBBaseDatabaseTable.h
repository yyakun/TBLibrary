//
//  TBBaseDatabaseTable.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TBQueryTableOneDataString(primaryKey_id)\
TBQueryOneDataString(@"primaryKey_id", primaryKey_id)

#define TBQueryTableDataString(start_id, end_id)\
TBQueryDataString(@"primaryKey_id", start_id, end_id)

@interface TBBaseDatabaseTable : NSObject

@property (nonatomic, assign) long long primaryKey_id;

+ (NSString *)tableName;
+ (NSString *)tableFileName;
+ (NSString *)createTableSQLString;

+ (BOOL)createTable;
+ (BOOL)dropTable;

+ (long long)allDataCount;
+ (long long)partOfDataCountWithCondition:(NSString *)condition;
+ (long long)partOfDataCountWithStart_id:(long long)start_id end_id:(long long)end_id;

+ (long long)queryMaxDataWithColumnName:(NSString *)columnName;
+ (long long)queryMinDataWithColumnName:(NSString *)columnName;

+ (NSMutableArray *)allData;
+ (NSMutableArray *)partOfDataWithCondition:(NSString *)condition;
+ (NSMutableArray *)oneDataWithPrimaryKey_id:(long long)primaryKey_id;
+ (NSMutableArray *)partOfDataWithStart_id:(long long)start_id end_id:(long long)end_id;

+ (BOOL)insertOneDataWithObject:(TBBaseDatabaseTable *)object;
+ (BOOL)insertOneDataWithObject:(TBBaseDatabaseTable *)object primaryKey_id:(long long)primaryKey_id;
+ (BOOL)insertOneDataWithObject:(TBBaseDatabaseTable *)object propertyNameArray:(NSArray *)propertyNameArray;
+ (BOOL)insertPartOfDataWithObjects:(NSArray *)objects;

+ (BOOL)updateOneDataWithObject:(TBBaseDatabaseTable *)object condition:(NSString *)condition;
+ (BOOL)updateOneDataWithObject:(TBBaseDatabaseTable *)object primaryKey_id:(long long)primaryKey_id;
+ (BOOL)updatePartOfDataWithObjects:(NSArray *)objects start_id:(long long)start_id;

+ (BOOL)deleteAllData;
+ (BOOL)deletePartOfDataWithCondition:(NSString *)condition;
+ (BOOL)deleteOneDataWithPrimaryKey_id:(long long)primaryKey_id;
+ (BOOL)deletePartOfDataWithStart_id:(long long)start_id end_id:(long long)end_id;

+ (NSString *)queryColumnNameWithIndex:(int)index;
+ (BOOL)alterTableWithSetColumnNameString:(NSString *)setColumnNameString;
+ (NSMutableArray *)orderTableWithColumnName:(NSString *)columnName ascending:(BOOL)isAscending;

@end
