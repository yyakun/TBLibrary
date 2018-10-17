//
//  UIViewController+TB.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TB) <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

- (void)addButtonsTarget:(NSArray *)buttons;//  给一组按钮统一加点击触发方法
- (NSMutableArray<UIButton *> *)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;
- (void)openSystemCameraOrPhotos:(UIViewController *)currentViewController imagePickerObjectIdentifier:(NSString *)objectIdentifier;

@end
