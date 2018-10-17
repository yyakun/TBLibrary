//
//  NSString+TBEncryption.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  一些字符串加密解密算法相关的方法
 */
@interface NSString (TBEncryption)

- (NSString *)md5;
- (NSString *)sha1;
- (NSString *)sha256;

@end
