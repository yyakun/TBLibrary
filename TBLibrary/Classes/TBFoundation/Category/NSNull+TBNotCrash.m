//
//  NSNull+TBNotCrash.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSNull+TBNotCrash.h"

@implementation NSNull (TBNotCrash)

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([self respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:self];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:aSelector];
    if(sig == nil) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^@cq"];
    }
    return sig;
}

@end
