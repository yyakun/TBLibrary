//
//  NSString+TBValidateCheck.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TBValidateCheck)

/**
 *  判断正则表达式是否能和字符串匹配
 *
 *  @param regex 需要进行匹配的正则表达式
 *
 *  @return 是否匹配
 */
- (BOOL)VC_isValidateRegex:(NSString *)regex;

/**
 *  手机号是否合法，严格验证
 *
 *  @return 如果手机号合法，返回YES，否则返回NO
 */
- (BOOL)VC_isValidateMobileNumber;


/**
 *  手机号是否合法，不严格验证，1打头11位
 *
 *  @return 如果手机号合法，返回YES，否则返回NO
 */
- (BOOL)VC_isValidateMobileNumberRelaxed;

/**
 *  邮箱是否合法
 *
 *  @return 如果邮箱合法，返回YES，否则返回NO
 */
- (BOOL)VC_isValidateEmail;

/**
 *  身份证号码是否合法
 *
 *  @return 如果身份证号码合法，返回YES，否则返回NO
 */
- (BOOL)VC_isValidateIdentityCardNumber;

/**
 *  判断是否都为数字
 *
 *  @return 如果都为数字，返回YES，否则返回NO
 */
- (BOOL)VC_isAllNumber;

// 验证m-n位的数字
- (BOOL)VC_isAllNumberBetween:(NSInteger)startNumber number:(NSInteger)endNumber;

// 固定个数的数字
- (BOOL)VC_isFixedLengthAllNumber:(NSInteger)count;

// 只包含数字和字母的6-20位密码
- (BOOL)VC_isValidatePasswordBetween:(NSInteger)startNumber number:(NSInteger)endNumber;

// 只包含数字、字母和中文的 m 到 n 位字符
- (BOOL)VC_isValidateString:(NSInteger)startNumber number:(NSInteger)endNumber;

/**
 *
 *  判断身份证是否正确
 *
 *  @param value 身份证号
 *
 *  @return YES or NO
 */
+ (BOOL)judgeIdcardLegal:(NSString *)value;

@end
