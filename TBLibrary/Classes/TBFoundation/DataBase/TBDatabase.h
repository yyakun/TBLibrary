//
//  TBDatabase.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FMResultSet;
@class TBBaseDatabaseTable;

#define TBCreateTableSQLString(tableName, setColumnNameString)\
[NSString stringWithFormat:@"create table if not exists %@ (%@)", tableName, setColumnNameString]

#define TBDropTableSQLString(tableName)\
[NSString stringWithFormat:@"drop table %@", tableName]

#define TBQueryAllDataCountSQLString(tableName)\
[NSString stringWithFormat:@"select count(*) from %@", tableName]

#define TBQueryDataCountSQLString(tableName, condition)\
[NSString stringWithFormat:@"select count(*) from %@ where %@", tableName, condition]

#define TBQueryAllDataSQLString(tableName)\
[NSString stringWithFormat:@"select * from %@", tableName]

#define TBQueryDataByUsingWhereKeywordSQLString(tableName, condition)\
[NSString stringWithFormat:@"select * from %@ where %@", tableName, condition]

#define TBQueryDataByUsingLimitKeywordSQLString(tableName, condition)\
[NSString stringWithFormat:@"select * from %@ limit %@", tableName, condition]

#define TBQueryMaxNumberSQLString(tableName, columnName)\
[NSString stringWithFormat:@"select * from %@ where %@ = (select max(%@) from %@)", tableName, columnName, columnName, tableName]

#define TBQueryMinNumberSQLString(tableName, columnName)\
[NSString stringWithFormat:@"select * from %@ where %@ = (select min(%@) from %@)", tableName, columnName, columnName, tableName]

#define TBAlterTableSQLString(tableName, setColumnNameString)\
[NSString stringWithFormat:@"alter table %@ add %@", tableName, setColumnNameString]

#define TBOrderDataSQLString(tableName, orderString)\
[NSString stringWithFormat:@"select * from %@ order by %@", tableName, orderString]// ASC顺序、DESC倒序

#define TBDeleteAllDataSQLString(tableName)\
[NSString stringWithFormat:@"delete from %@", tableName]

#define TBDeleteDataSQLString(tableName, condition)\
[NSString stringWithFormat:@"delete from %@ where %@", tableName, condition]

#define TBInsertDataSQLString(tableName, keyString, valueString)\
[NSString stringWithFormat:@"insert into %@ (%@) values (%@)", tableName, keyString, valueString]

#define TBUpdateDataSQLString(tableName, keyValueString, condition)\
[NSString stringWithFormat:@"update %@ set %@ where %@", tableName, keyValueString, condition]

#define TBQueryOneDataString(columnName, primaryKey_id)\
[NSString stringWithFormat:@"%@ == %lld", columnName, primaryKey_id]

#define TBQueryDataString(columnName, start_id, end_id)\
[NSString stringWithFormat:@"%@ >= %lld and %@ <= %lld", columnName, start_id, columnName, end_id]

#define TBQueryDataByUsingLikeKeywordString(columnName, string)\
[NSString stringWithFormat:@"%@ like %@", columnName, string]// % 通配多个字符；_ 通配一个字符

@interface TBDatabase : NSObject

+ (BOOL)initDatabaseWithTableFileName:(NSString *)tableFileName SQLString:(NSString *)SQLString;
+ (BOOL)createTableWithTableFileName:(NSString *)tableFileName SQLString:(NSString *)SQLString;
+ (BOOL)dropTableWithTableName:(NSString *)tableName;

+ (FMResultSet *)queryDataWithSQLString:(NSString *)SQLString;
+ (BOOL)updateDataWithSQLString:(NSString *)SQLString;
+ (NSInteger)queryCountWithSQLString:(NSString *)SQLString;
+ (NSInteger)selectNumberWithSQLString:(NSString *)SQLString;
+ (NSMutableArray *)selectDataWithSQLString:(NSString *)SQLString;

+ (NSInteger)queryAllCountWithTableName:(NSString *)tableName;
+ (NSInteger)queryCountWithTableName:(NSString *)tableName condition:(NSString *)condition;
+ (NSInteger)queryColumnCountWithTableName:(NSString *)tableName;
+ (NSInteger)queryMaxNumberWithTableName:(NSString *)tableName columnName:(NSString *)columnName;
+ (NSInteger)queryMinNumberWithTableName:(NSString *)tableName columnName:(NSString *)columnName;

+ (NSString *)queryColumnNameWithTableName:(NSString *)tableName index:(int)index;

+ (NSMutableArray *)allDataWithTableName:(NSString *)tableName;
+ (NSMutableArray *)selectDataWithTableName:(NSString *)tableName condition:(NSString *)condition;

+ (BOOL)insertOneDataWithTableName:(NSString *)tableName object:(TBBaseDatabaseTable *)object;
+ (BOOL)insertOneDataWithTableName:(NSString *)tableName object:(TBBaseDatabaseTable *)object propertyNameArray:(NSArray *)propertyNameArray;
+ (BOOL)insertPartOfDataWithTableName:(NSString *)tableName tableFileName:(NSString *)tableFileName objects:(NSArray *)objects;

+ (BOOL)updatePartOfDataWithTableName:(NSString *)tableName tableFileName:(NSString *)tableFileName objects:(NSArray *)objects columnName:(NSString *)columnName primaryKey_id:(long long)primaryKey_id;
+ (BOOL)updateOneDataWithTableName:(NSString *)tableName object:(NSObject *)object condition:(NSString *)condition;

+ (BOOL)deleteAllDataWithTableName:(NSString *)tableName;
+ (BOOL)deleteDataWithTableName:(NSString *)tableName condition:(NSString *)condition;

@end
