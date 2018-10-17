//
//  TBKeychain.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>
FOUNDATION_EXTERN NSString * const TBKeyChainGroup;

@interface TBKeychain : NSObject

+ (NSString *)bundleSeedID;

- (id)initWithService:(NSString *)service withGroup:(NSString *)group;
- (BOOL)saveDataWithKey:(NSString *)key data:(NSData *)data;
- (NSData *)loadDataWithKey:(NSString *)key;
- (BOOL)updateDataWithKey:(NSString *)key data:(NSData *)data;
- (BOOL)removeDataWithKey:(NSString *)key;

@end
