//
//  TBAvoidCrash.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/7/15.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

//category
#import "NSObject+TBAvoidCrash.h"

#import "NSArray+TBAvoidCrash.h"
#import "NSMutableArray+TBAvoidCrash.h"

#import "NSDictionary+TBAvoidCrash.h"
#import "NSMutableDictionary+TBAvoidCrash.h"

#import "NSString+TBAvoidCrash.h"
#import "NSMutableString+TBAvoidCrash.h"

#import "NSAttributedString+TBAvoidCrash.h"
#import "NSMutableAttributedString+TBAvoidCrash.h"


/**
 *  if you want to get the reason that can cause crash, you can add observer notification in AppDelegate.
 *  for example: 
 *
 *  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealwithCrashMessage:) name:TBAvoidCrashNotification object:nil];
 *  
 *  ===========================================================================
 *  
 *  你如果想要得到导致崩溃的原因，你可以在AppDelegate中监听通知，代码如上。
 *  不管你在哪个线程导致的crash,监听通知的方法都会在主线程中
 *
 */
#define TBAvoidCrashNotification @"TBAvoidCrashNotification"



//user can ignore below define
#define TBAvoidCrashDefaultReturnNil  @"This framework default is to return nil to avoid crash."
#define TBAvoidCrashDefaultIgnore     @"This framework default is to ignore this operation to avoid crash."


#ifdef DEBUG

#define  TBAvoidCrashLog(...) NSLog(@"%@",[NSString stringWithFormat:__VA_ARGS__])

#else

#define TBAvoidCrashLog(...)
#endif


@interface TBAvoidCrash : NSObject


/**
 *  become effective . You can call becomeEffective method in AppDelegate didFinishLaunchingWithOptions
 *  
 *  开始生效.你可以在AppDelegate的didFinishLaunchingWithOptions方法中调用becomeEffective方法
 *
 *  这是全局生效，若你只需要部分生效，你可以单个进行处理，比如:
 *  [NSArray avoidCrashExchangeMethod];
 *  [NSMutableArray avoidCrashExchangeMethod];
 *  .................
 *  .................
 */
+ (void)becomeEffective;


//user can ignore below method <用户可以忽略以下方法>


+ (void)exchangeClassMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;

+ (void)exchangeInstanceMethod:(Class)anClass method1Sel:(SEL)method1Sel method2Sel:(SEL)method2Sel;

+ (void)noteErrorWithException:(NSException *)exception defaultToDo:(NSString *)defaultToDo;


@end
