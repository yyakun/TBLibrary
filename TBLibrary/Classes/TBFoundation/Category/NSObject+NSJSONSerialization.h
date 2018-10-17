//
//  NSObject+NSJSONSerialization.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/8/23.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSJSONSerialization)
- (id)TB_JSONValue;
@end

@interface NSObject (NSJSONSerialization)
- (NSString *)TB_JSONRepresentation;
@end
