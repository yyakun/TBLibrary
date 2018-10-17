//
//  TBUDIDGenerator.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBUDIDGenerator.h"
#import <UIKit/UIKit.h>
#import "TBKeychain.h"
#import "NSString+TB.h"

static NSString *serviceName = @"com.Ev1rGrandeGroups";
static NSString *udidName = @"Ev1rGrandeGroupsUDID";
static NSString *pasteboardType = @"Ev1rGrandeGroupsContent";

@interface TBUDIDGenerator ()

@property (nonatomic, strong) TBKeychain *myKeyChain;
@property (nonatomic, copy) NSString *udid;
@property (nonatomic, copy) NSString *appBundleName;

@end

@implementation TBUDIDGenerator

+ (instancetype)sharedInstance {
    static TBUDIDGenerator *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[TBUDIDGenerator alloc] initUseInner];
    });
    return singleton;
}

- (instancetype)init {
    NSAssert(NO, @"\nfile: %s  line: %d  function: %s  content: 换别的初始化方法吧", [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  __LINE__, __FUNCTION__);
    return nil;
}

- (instancetype)initUseInner {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)saveUDID:(NSString *)udid {
    BOOL saveOk = NO;
    NSData *udidData = [self.myKeyChain loadDataWithKey:udidName];
    if (udidData == nil) {
        saveOk = [self.myKeyChain saveDataWithKey:udidName data:[udid stringToData]];
    }else{
        saveOk = [self.myKeyChain updateDataWithKey:udidName data:[udid stringToData]];
    }
    if (!saveOk) {
        [self createPasteBoradValue:udid forIdentifier:udidName];
    }
}

- (NSString *)udid {
    if (!_udid) {
        _udid = [[self getUDID] copy];
    }
    return _udid;
}

#pragma mark - privite method

- (NSString *)appBundleName {
    if (!_appBundleName) {
        NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
        NSArray *components = [identifier componentsSeparatedByString:@"."];
        //  具体由bundleIdentifier的结构来取值，如：可能要更改数字3为2
        if (components.count > 2) {
            _appBundleName = [components objectAtIndex:2];
        } else {
            _appBundleName = @"";
        }
    }
    return _appBundleName;
}

- (TBKeychain *)myKeyChain {
    if (!_myKeyChain) {
        _myKeyChain = [[TBKeychain alloc] initWithService:serviceName withGroup:TBKeyChainGroup];
    }
    return _myKeyChain;
}

- (NSString *)createUDID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    NSString *udid = (__bridge NSString *)string;
    udid = [udid stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(uuid);
    CFRelease(string);
    return udid;
}

- (NSString *)getUDID {
    NSData *udidData = [self.myKeyChain loadDataWithKey:udidName];
    NSString *udid = nil;
    if (!udidData) {
        udid = [self createUDID];
        [self saveUDID:udid];
    } else {
        NSString *temp = [[NSString alloc] initWithData:udidData encoding:NSUTF8StringEncoding];
        udid = [NSString stringWithFormat:@"%@", temp];
    }
    if (udid.length == 0) {
        udid = [self readPasteBoradforIdentifier:udidName];
    }
    return udid;
}

- (void)createPasteBoradValue:(NSString *)value forIdentifier:(NSString *)identifier {
    UIPasteboard *pb = [UIPasteboard pasteboardWithName:serviceName create:YES];
    NSDictionary *dict = [NSDictionary dictionaryWithObject:value forKey:identifier];
    NSData *dictData = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [pb setData:dictData forPasteboardType:pasteboardType];
}

- (NSString *)readPasteBoradforIdentifier:(NSString *)identifier {
    UIPasteboard *pb = [UIPasteboard pasteboardWithName:serviceName create:YES];
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:[pb dataForPasteboardType:pasteboardType]];
    return [dict objectForKey:identifier];
}

@end
