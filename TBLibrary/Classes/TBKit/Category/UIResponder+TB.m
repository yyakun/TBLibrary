//
//  UIResponder+TB.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "UIResponder+TB.h"
#import "NSObject+TBRuntime.h"

@implementation UIResponder (TB)

- (void)setupUI {
    NSLog(@"setupUI method(:>>> %@) might be override", [self class]);
}

- (void)setupLayout {
    NSLog(@"setupLayout method(:>>> %@) might be override", [self class]);
}

- (void)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    NSLog(@"view(viewName : %@) did add gestureRecognizer(class : %@), please override", gestureRecognizer.view.objectIdentifier, NSStringFromClass([gestureRecognizer class]));
}

- (void)clicked:(UIResponder *)sender {
    NSLog(@"sender(sender: %@) is clicked, please override", sender.objectIdentifier);
}

- (void)addViewsTapGestureRecognizer:(NSArray *)views {
    for (UIView *view in views) {
        if (![[view class] isSubclassOfClass:[UIView class]]) {
            NSAssert(NO, @"array contain object (>>>: %@) might be not a view", view.objectIdentifier);
        }
        NSString *viewObjectIdentifier = view.objectIdentifier;
        
        UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizer:)];
        [view addGestureRecognizer:gestureRecognizer];
        view.userInteractionEnabled = YES;
        view.objectIdentifier = ([viewObjectIdentifier hasPrefix:@"self."] ? [viewObjectIdentifier substringFromIndex:5] : viewObjectIdentifier);
        gestureRecognizer.objectIdentifier = [NSString stringWithFormat:@"%@%@", gestureRecognizer, view.objectIdentifier];
    }
}

@end
