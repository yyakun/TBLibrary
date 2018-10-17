//
//  TBKeychain.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBKeychain.h"
NSString * const TBKeyChainGroup = @"com.evergrande.*";

@interface TBKeychain ()

@property (nonatomic, copy) NSString *service;
@property (nonatomic, copy) NSString *group;

@end

@implementation TBKeychain

+ (NSString *)bundleSeedID
{
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)(kSecClassGenericPassword), kSecClass,
                           @"bundleSeedID", kSecAttrAccount,
                           @"", kSecAttrService,
                           (id)kCFBooleanTrue, kSecReturnAttributes,
                           nil];
    CFDictionaryRef result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status == errSecItemNotFound) {
        status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    }
    if (status != errSecSuccess) {
        return @"";
    }
    NSString *accessGroup = [(__bridge NSDictionary *)result objectForKey:(__bridge id)(kSecAttrAccessGroup)];
    NSArray *components = [accessGroup componentsSeparatedByString:@"."];
    NSString *bundleSeedID = [[components objectEnumerator] nextObject];
    CFRelease(result);
    return bundleSeedID;
}

- (id)initWithService:(NSString *)service withGroup:(NSString *)group
{
    self = [super init];
    if (self)
    {
        _service = [NSString stringWithString:service];
        if (group) {
            group = [NSString stringWithFormat:@"%@.%@", [[self class] bundleSeedID], group];
            _group = [NSString stringWithString:group];
        }
    }
    
    return  self;
}

- (NSMutableDictionary *)prepareDict:(NSString *)key
{
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:(__bridge id)kSecClassGenericPassword forKey:(__bridge id)kSecClass];
    [dict setObject:key forKey:(__bridge id)kSecAttrGeneric];
    [dict setObject:key forKey:(__bridge id)kSecAttrAccount];
    [dict setObject:(__bridge id)kSecAttrAccessibleAfterFirstUnlock forKey:(__bridge id)kSecAttrAccessible];
    [dict setObject:(__bridge id)kSecAttrAccessibleAlwaysThisDeviceOnly forKey:(__bridge id)kSecAttrAccessible];
    
    [dict setObject:self.service forKey:(__bridge id)kSecAttrService];
    //This is for sharing data across apps
    
    //  打开注释就会出错！！！！
    //    if (self.group) {
    //        [dict setObject:self.group forKey:(__bridge id)kSecAttrAccessGroup];
    //    }
    return  dict;
}

- (BOOL)saveDataWithKey:(NSString *)key data:(NSData *)data
{
    NSMutableDictionary *dict = [self prepareDict:key];
    
    [dict setObject:data forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)dict, NULL);
    if (status != errSecSuccess) {
        NSString *msg = [NSString stringWithFormat:@"Unable add item with key =%@ error:%d", key, (int)status];
        NSLog(@"%@", msg);
    }
    return (status == errSecSuccess);
}

- (NSData *)loadDataWithKey:(NSString *)key
{
    NSMutableDictionary *dict = [self prepareDict:key];
    
    [dict setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    [dict setObject:(id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    CFDataRef keyData = NULL;
    
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)dict,(CFTypeRef *)&keyData);
    
    if (status != errSecSuccess) {
        NSString *msg = [NSString stringWithFormat:@"Unable to fetch item for key %@ with error:%d",key,(int)status];
        NSLog(@"%@", msg);
        return nil;
    }
    return (__bridge NSData *)keyData;
}

- (BOOL)updateDataWithKey:(NSString *)key data:(NSData *)data
{
    NSMutableDictionary *dictKey = [self prepareDict:key];
    
    NSMutableDictionary * dictUpdate = [[NSMutableDictionary alloc] init];
    [dictUpdate setObject:data forKey:(__bridge id)kSecValueData];
    
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)dictKey, (__bridge CFDictionaryRef)dictUpdate);
    if (status != errSecSuccess) {
        NSString *msg = [NSString stringWithFormat:@"Unable add update with key =%@ error:%d",key,(int)status];
        NSLog(@"%@", msg);
    }
    return (status == errSecSuccess);
}

- (BOOL)removeDataWithKey:(NSString *)key
{
    NSMutableDictionary *dict = [self prepareDict:key];
    
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)dict);
    if (status != errSecSuccess) {
        NSString *msg = [NSString stringWithFormat:@"Unable to remove item for key %@ with error:%d", key, (int)status];
        NSLog(@"%@", msg);
    }
    return (status == errSecSuccess);
}

@end
