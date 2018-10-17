//
//  NSData+AES.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DES)

+ (NSString *)encryptUseDES:(NSString *)plainText key:(NSString *)key;// DES加密
+ (NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;// DES解密
+ (NSString *)parseByte2HexString:(Byte *)bytes;// 将二进制转换成16进制
+ (NSString *)parseByteArray2HexString:(Byte[])bytes;// 将二进制转换为16进制

@end

@interface NSData (AES)

- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
+ (NSString *)AES128Encrypt:(NSString *)plainText;
+ (NSString *)AES128Decrypt:(NSString *)encryptText;

@end
