//
//  NSObject+TB.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

typedef NS_ENUM(NSInteger, TBPropertyType) {
    TBPropertyType_Unknown     = 0,
    TBPropertyType_Int8        = 'c',//!< A char
    TBPropertyType_Int16       = 's',//!< A short
    TBPropertyType_Int32       = 'i',//!< An int
    TBPropertyType_Long        = 'l',//!< A long
    TBPropertyType_Int64       = 'q',//!< A long long
    TBPropertyType_UInt8       = 'C',//!< An unsigned char
    TBPropertyType_UInt16      = 'S',//!< An unsigned short
    TBPropertyType_UInt32      = 'I',//!< An unsigned int
    TBPropertyType_ULoing      = 'L',//!< An unsigned long
    TBPropertyType_UInt64      = 'Q',//!< An unsigned long long
    TBPropertyType_Float       = 'f',//!< A float
    TBPropertyType_Double      = 'd',//!< A double
    TBPropertyType_BOOL        = 'B',//!< A C++ bool or a C99 _Bool
    TBPropertyType_Void        = 'v',//!< A void
    TBPropertyType_CString     = '*',//!< A character string (char *)
    TBPropertyType_OCObject    = '@',//!< An object (whether statically typed or typed id)
    TBPropertyType_OCClass     = '#',//!< A class object (Class)
    TBPropertyType_Sel         = ':',//!< A method selector (SEL)
    TBPropertyType_CArray      = '[',//!< An array
    TBPropertyType_CStructure  = '{',//!< A structure
    TBPropertyType_CUnion      = '(',//!< A union
    TBPropertyType_BitField    = 'b',//!< A bit field of num bits, OC的property貌似不直接支持
};

/**
 *  方便实现method swizzle的内联函数
 *  可在类的category中的load函数内直接调用
 *
 *  @param aClass           需要进行替换方法的类
 *  @param originalSelector 需要进行替换的原方法选择器
 *  @param swizzledSelector 新的方法的选择器,新的方法名通常是在原方法名前面加categoryName_
 *  @param isInstanceMethod 需要替换的方法是否是实例方法，YES表示是实例方法，NO表示是类方法
 */
NS_INLINE void TB_methodSwizzle(Class aClass, SEL originalSelector, SEL swizzledSelector, BOOL isInstanceMethod) {
    Method (*class_getMethod)(Class, SEL) = &class_getInstanceMethod;
    if (!isInstanceMethod) {
        class_getMethod = &class_getClassMethod;
        aClass = object_getClass(aClass);
    }
    Method originalMethod = class_getMethod(aClass, originalSelector);
    Method swizzledMethod = class_getMethod(aClass, swizzledSelector);
    if (class_addMethod(aClass, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(aClass, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@interface TBPropertyInfo : NSObject
@property (nonatomic, assign) TBPropertyType type;//!<属性类型
@property (nonatomic, assign) BOOL isPointer;//!<是否是指针，id不算
@property (nonatomic, assign) Class aClass;//!<如果是OC对象，获取其类型
@property (nonatomic, copy) NSString *propertyTypeEncode;//!< 属性类型encode值
@property (nonatomic, assign) SEL getter;
@property (nonatomic, assign) SEL setter;
@property (nonatomic, copy) NSString *propertyName; //NS_DEPRECATED_IOS(__IPHONE_2_0, __IPHONE_2_0);//!<属性名称
@end

@interface NSObject (TB)

/**
 *  返回所有满足条件的属性集合
 *
 *  @param containsReadOnly 是否包含只读属性
 *
 *  @return 所有满足条件的属性集合
 */
+ (NSMutableDictionary *)TB_propertyInfosContainsReadOnly:(BOOL)containsReadOnly;

/**
 *  返回所有的属性集合
 *
 *  @return 所有的属性集合
 */
+ (NSSet *)TB_allPropertyKeys;

/**
 *  创建单例对象
 *
 *  @return 返回一个类的单例对象
 */
+ (instancetype)sharedInstance;
- (void)commonInit;

- (NSString *)keyValueString;
- (void)saveObjectWithKey:(NSString *)key;
- (id)loadObjectWithKey:(NSString *)key;

@end
