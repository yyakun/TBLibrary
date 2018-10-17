//
//  NSString+TB.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (TB)

- (NSString *)dataToString;

@end

@interface NSString (TB)

- (BOOL)isBlankString;// 判断字符串是否都是由空格字符组成
- (NSString *)deleteBlankString;// 删除空格字符
- (BOOL)containsChineseString;// 判断字符串中是否含有中文字符
- (NSData *)stringToData;
- (NSArray *)getFirstForString:(NSString *)string withSplitString:(NSString *)splitString;
- (NSString *)substringWithLeftString:(NSString *)leftString rightString:(NSString *)rightString;
- (NSMutableAttributedString *)stringToMutableAttributedStringWithString:(NSString *)string;//  形如：@"2,4,5,6"的字符串
- (BOOL)isDecimalDigitCharacterSet;
- (NSNumber *)replaceNumberFromStringTypeToNumberType;
+ (NSString *)getBankName:(NSString *)cardId;// 根据银行卡号判断银行名称

@end
