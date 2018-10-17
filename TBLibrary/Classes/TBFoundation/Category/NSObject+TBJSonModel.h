//
//  NSObject+TBJSonModel.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TBJSonModelProtocol <NSObject>

/**
 *  在需要被转成的对象内部实现该方法
 *  - (void)jm_refreshPorpertyValueWithData:(id)data useDiscrepantKeyPairs:(BOOL)useDiscrepantKeyPairs;
 *  方法会自动调用[self discrepantKeyPairs];
 *  discrepantKeyPairs返回的字典的keys会作为innerKeys，values会作为outerKeys
 *
 *  @return discrepantKeyPairs字典
 */
- (NSDictionary *)discrepantKeyPairs;

@end

@interface NSObject (TBJSonModel)

/**
 *  用字典来描述这个类，字典中包含类中的所有属性，以 属性名:属性值 为一个单位。
 *
 *  @return 代表这个类属性属性值键值对的字典。
 */
- (id)jm_dictionaryRepresentation:(BOOL)containsReadOnly;

/**
 *  对象转数据模型类
 *
 *  @param data 需要转换的数据,NSDictionary 或者 其他的model类型
 */
- (void)jm_refreshPorpertyValueWithData:(id)data;

/**
 *  对象转数据模型类
 *
 *  @param data                     需要转换的数据,NSDictionary 或者 其他的model类型
 *  @param useDiscrepantKeyPairs    是否使用模型类中默认的转换差异键值对
 */
- (void)jm_refreshPorpertyValueWithData:(id)data useDiscrepantKeyPairs:(BOOL)useDiscrepantKeyPairs;

/**
 *  对象转数据模型类
 *
 *  @param data                 需要转换的数据,NSDictionary 或者 其他的model类型
 *  @param discrepantKeyPairs   模型类转换差异键值对
 */
- (void)jm_refreshPorpertyValueWithData:(id)data withDiscrepantKeyPairs:(NSDictionary *)discrepantKeyPairs;


/**
 *  对象转数据模型类
 *
 *  @param data      需要转换的数据,NSDictionary 或者 其他的model类型
 *  @param innerKeys 模型类转换差异键值对，内部值
 *  @param outerKeys 模型类转换差异键值对，外部值
 */
- (void)jm_refreshPorpertyValueWithData:(id)data discrepantInnerKeys:(NSArray *)innerKeys discrepantOuterKeys:(NSArray *)outerKeys;

/**
 *  将数组转换成数组对象
 *  默认使用模型类中默认的转换差异键值对
 *
 *  @param arrayData  需要转换的数组对象
 *  @param modelClass 需要将数组中的数据转换成什么类型
 *
 *  @return 转换后的数组对象
 */
+ (NSArray *)loadArrayPropertyWithDataSource:(NSArray *)arrayData requireModel:(NSString *)modelClass;

/**
 *  将数组转换成数组对象
 *  默认使用模型类中默认的转换差异键值对
 *
 *  @param arrayData        需要转换的数组对象
 *  @param modelClass       需要将数组中的数据转换成什么类型
 *  @param discrepantKeys   模型类转换差异键值对
 *
 *  @return 转换后的数组对象
 */
+ (NSArray *)loadArrayPropertyWithDataSource:(NSArray *)arrayData requireModel:(NSString *)modelClass discrepantKeys:(NSDictionary *)discrepantKeys;

@end
