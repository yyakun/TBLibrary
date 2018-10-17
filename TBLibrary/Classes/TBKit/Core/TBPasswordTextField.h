//
//  TBPasswordTextField.h
//  DeliveryLift
//
//  Created by 杨亚坤 on 2017/6/20.
//  Copyright © 2017年 TongBen Industry. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TBPasswordTextField;

@protocol TBPasswordTextFieldDelegate <NSObject>

- (void)passwordTextFieldDeleteBackward:(TBPasswordTextField *)textField;

@end

@interface TBPasswordTextField : UITextField

@property (nonatomic, assign) id <TBPasswordTextFieldDelegate> passwordTextFieldDelegate;

@end
