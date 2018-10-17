//
//  NSObject+TBRuntime.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "NSObject+TBRuntime.h"
#import <objc/runtime.h>

@implementation NSObject (TBRuntime)

static char userInfoKey;
static char objectIdentifierKey;

- (void)setUserInfo:(id)userInfo {
    objc_setAssociatedObject(self, &userInfoKey, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)userInfo {
    return objc_getAssociatedObject(self, &userInfoKey);
}

- (void)setObjectIdentifier:(NSString *)objectIdentifier {
    objc_setAssociatedObject(self, &objectIdentifierKey, objectIdentifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)objectIdentifier {
    return objc_getAssociatedObject(self, &objectIdentifierKey);
}

@end
