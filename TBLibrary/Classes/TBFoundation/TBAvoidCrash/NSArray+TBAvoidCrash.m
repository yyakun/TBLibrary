//
//  NSArray+TBAvoidCrash.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/7/15.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSArray+TBAvoidCrash.h"

#import "TBAvoidCrash.h"

@implementation NSArray (TBAvoidCrash)


+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //=================
        //   class method
        //=================
        
        //instance array method exchange
        [TBAvoidCrash exchangeClassMethod:[self class] method1Sel:@selector(arrayWithObjects:count:) method2Sel:@selector(TBAvoidCrashArrayWithObjects:count:)];
        
        
        
        //====================
        //   instance method
        //====================
        
        Class __NSArray = NSClassFromString(@"NSArray");
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        Class __NSArray0 = NSClassFromString(@"__NSArray0");
        
        
        //objectsAtIndexes:
        [TBAvoidCrash exchangeInstanceMethod:__NSArray method1Sel:@selector(objectsAtIndexes:) method2Sel:@selector(avoidCrashObjectsAtIndexes:)];
        
        
        //objectAtIndex:
        
        [TBAvoidCrash exchangeInstanceMethod:__NSArrayI method1Sel:@selector(objectAtIndex:) method2Sel:@selector(__NSArrayITBAvoidCrashObjectAtIndex:)];
        
        [TBAvoidCrash exchangeInstanceMethod:__NSSingleObjectArrayI method1Sel:@selector(objectAtIndex:) method2Sel:@selector(__NSSingleObjectArrayITBAvoidCrashObjectAtIndex:)];
        
        [TBAvoidCrash exchangeInstanceMethod:__NSArray0 method1Sel:@selector(objectAtIndex:) method2Sel:@selector(__NSArray0TBAvoidCrashObjectAtIndex:)];
        
        
        //getObjects:range:
        [TBAvoidCrash exchangeInstanceMethod:__NSArray method1Sel:@selector(getObjects:range:) method2Sel:@selector(NSArrayTBAvoidCrashGetObjects:range:)];
        
        [TBAvoidCrash exchangeInstanceMethod:__NSSingleObjectArrayI method1Sel:@selector(getObjects:range:) method2Sel:@selector(__NSSingleObjectArrayITBAvoidCrashGetObjects:range:)];
        
        [TBAvoidCrash exchangeInstanceMethod:__NSArrayI method1Sel:@selector(getObjects:range:) method2Sel:@selector(__NSArrayITBAvoidCrashGetObjects:range:)];
    });
    
    
}


//=================================================================
//                        instance array
//=================================================================
#pragma mark - instance array


+ (instancetype)TBAvoidCrashArrayWithObjects:(const id __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self TBAvoidCrashArrayWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = @"This framework default is to remove nil object and instance a array.";
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        
        //以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self TBAvoidCrashArrayWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
}



//=================================================================
//                     objectAtIndexedSubscript:
//=================================================================
#pragma mark - objectAtIndexedSubscript:
- (id)avoidCrashObjectAtIndexedSubscript:(NSUInteger)idx {
    id object = nil;
    
    @try {
        object = [self avoidCrashObjectAtIndexedSubscript:idx];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = TBAvoidCrashDefaultReturnNil;
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }

}


//=================================================================
//                       objectsAtIndexes:
//=================================================================
#pragma mark - objectsAtIndexes:

- (NSArray *)avoidCrashObjectsAtIndexes:(NSIndexSet *)indexes {
    
    NSArray *returnArray = nil;
    @try {
        returnArray = [self avoidCrashObjectsAtIndexes:indexes];
    } @catch (NSException *exception) {
        NSString *defaultToDo = TBAvoidCrashDefaultReturnNil;
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        return returnArray;
    }
}


//=================================================================
//                         objectAtIndex:
//=================================================================
#pragma mark - objectAtIndex:

//__NSArrayI  objectAtIndex:
- (id)__NSArrayITBAvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self __NSArrayITBAvoidCrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = TBAvoidCrashDefaultReturnNil;
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}



//__NSSingleObjectArrayI objectAtIndex:
- (id)__NSSingleObjectArrayITBAvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self __NSSingleObjectArrayITBAvoidCrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = TBAvoidCrashDefaultReturnNil;
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}

//__NSArray0 objectAtIndex:
- (id)__NSArray0TBAvoidCrashObjectAtIndex:(NSUInteger)index {
    id object = nil;
    
    @try {
        object = [self __NSArray0TBAvoidCrashObjectAtIndex:index];
    }
    @catch (NSException *exception) {
        NSString *defaultToDo = TBAvoidCrashDefaultReturnNil;
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
    }
    @finally {
        return object;
    }
}


//=================================================================
//                           getObjects:range:
//=================================================================
#pragma mark - getObjects:range:

//NSArray getObjects:range:
- (void)NSArrayTBAvoidCrashGetObjects:(__unsafe_unretained id *)objects range:(NSRange)range {
    
    @try {
        [self NSArrayTBAvoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {
        
        NSString *defaultToDo = TBAvoidCrashDefaultIgnore;
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        
    }
}


//__NSSingleObjectArrayI  getObjects:range:
- (void)__NSSingleObjectArrayITBAvoidCrashGetObjects:(__unsafe_unretained id *)objects range:(NSRange)range {
    
    @try {
        [self __NSSingleObjectArrayITBAvoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {
        
        NSString *defaultToDo = TBAvoidCrashDefaultIgnore;
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        
    }
}


//__NSArrayI  getObjects:range:
- (void)__NSArrayITBAvoidCrashGetObjects:(__unsafe_unretained id *)objects range:(NSRange)range {
    
    @try {
        [self __NSArrayITBAvoidCrashGetObjects:objects range:range];
    } @catch (NSException *exception) {
        
        NSString *defaultToDo = TBAvoidCrashDefaultIgnore;
        [TBAvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        
    } @finally {
        
    }
}




@end
