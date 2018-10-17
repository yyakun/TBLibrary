//
//  TBPasswordTextField.m
//  DeliveryLift
//
//  Created by 杨亚坤 on 2017/6/20.
//  Copyright © 2017年 TongBen Industry. All rights reserved.
//

#import "TBPasswordTextField.h"

@implementation TBPasswordTextField

- (void)deleteBackward {
    [super deleteBackward];
    if ([self.passwordTextFieldDelegate respondsToSelector:@selector(passwordTextFieldDeleteBackward:)]) {
        [self.passwordTextFieldDelegate passwordTextFieldDeleteBackward:self];
    }
}

@end
