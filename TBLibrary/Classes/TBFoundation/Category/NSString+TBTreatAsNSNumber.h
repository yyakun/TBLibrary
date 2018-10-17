//
//  NSString+TBTreatAsNSNumber.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  对NSString调用isEqualToNumber:时，防止crash
 *  预防措施，防止后台传递类型错误
 */
@interface NSString (TBTreatAsNSNumber)

@end
