//
//  TBServiceBaseManager.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBServiceProtocol.h"

@interface TBServiceBaseManager : NSObject

@property(nonatomic, assign) id<TBServiceProtocol> serviceConfig;

- (NSString *)apiDomain;
- (NSString *)apiWebDomain;
- (NSString *)apiServiceName;
- (NSString *)publicKey;
- (NSString *)privateKey;

@end
