//
//  TBFoundation.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#ifndef TBFoundation_h
#define TBFoundation_h


#import <GTMBase64/GTMBase64.h>
#import <FMDB/FMDB.h>
#import "NSObject+TB.h"
#import "NSDate+TB.h"
#import "NSString+TB.h"
#import "TBFileAssistant.h"
#import "NSObject+TBJSonModel.h"
#import "TBAppInfo.h"
#import "TBDeviceInfo.h"
#import "TBKeychain.h"
#import "TBUDIDGenerator.h"
#import "NSString+TBValidateCheck.h"
#import "TBModelPropertyMacro.h"
#import "TBPhoneCallHelper.h"
#import "TBUrlSchemesResolver.h"
#import "NSArray+TBSorted.h"
#import "NSObject+NSJSONSerialization.h"
#import "TBBase64.h"
#import "NSData+AES.h"
#import "NSString+TBEncryption.h"
#import "TBDatabase.h"
#import "TBBaseDatabaseTable.h"
#import "TBTool.h"
#import "TBNewEditionTestManager.h"
#import "NSString+TBDecimalNumber.h"
#import "NSURL+TB.h"
#import "NSDictionary+TB.h"
#import "TBAvoidCrash.h"
#import "NSNull+TBNotCrash.h"
#import "NSNumber+TBTreatAsNSString.h"
#import "NSString+TBTreatAsNSNumber.h"


//  打印日志
#ifdef DEBUG
    #define NSLog(format, ...) fprintf(stderr, "\nfile: %s  line: %d  function: %s  content: %s\n", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __func__, [[NSString stringWithFormat:format, ##__VA_ARGS__] UTF8String]);
#else
    #define NSLog(format, ...) {}
#endif

//  版本比较
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//  创建 __weak类型的对象
#define createWeak(o) __weak typeof(o) weak##o = o;
#define createStrong(o) __strong typeof(o) weak##o = o;

#define ISSTRING(_ref) [NSString stringWithFormat:@"%@", _ref]
#define ISEMPTYSTRING(_ref) ((ISSTRING(_ref)).length == 0 || [ISSTRING(_ref) isEqualToString:@"(null)"] || [ISSTRING(_ref) isEqualToString:@"nil"])

//  NSUserDefaults 实例化
#define USER_DEFAULTS [NSUserDefaults standardUserDefaults]

//  由角度获取弧度，由弧度获取角度
#define degreesToRadian(d) ((d) * M_PI / 180.0)
#define radianToDegrees(r) ((r) * 180.0 / M_PI)

//  创建GCD，其中参数是 无参无返回值类型的block，需要手动敲入 ^{} 在此代码块内写内容。
#define GCD_GLOBAL(b) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), b);
#define GCD_MAIN(b) dispatch_async(dispatch_get_main_queue(), b);



//  单例化一个类，给NSObject类添加一个类别方法： + (instancetype)sharedInstance，使用时子类必须覆盖该方法。在类中使用一行代码  createSingleton(className)即可创建单例，同时必须调用 - (void)commonInit方法
#define createSingleton(className)\
\
+ (instancetype)sharedInstance {\
    static className *singleton = nil;\
    static dispatch_once_t onceToken;\
        dispatch_once(&onceToken, ^{\
        singleton = [[className alloc] initUseInner];\
    });\
    return singleton;\
}\
\
- (instancetype)init {\
    NSAssert(NO, @"换别的初始化方法吧，file : %s, method : %@", __FILE__, NSStringFromSelector(_cmd));\
    return nil;\
}\
\
- (instancetype)initUseInner {\
    self = [super init];\
    if (self) {\
        [self commonInit];\
    }\
    return self;\
}


#endif /* TBFoundation_h */
