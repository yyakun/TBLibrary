//
//  UIViewController+TB.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "UIViewController+TB.h"
#import "UINavigationController+TB.h"
#import "TBKit.h"

@implementation UIViewController (TB)

- (void)addButtonsTarget:(NSArray *)buttons {
    for (UIButton *button in buttons) {
        if (![[button class] isSubclassOfClass:[UIButton class]]) {
            NSAssert(NO, @"array contain object (>>>: %@) might be not a button", button);
        }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [button addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic pop
    }
}

#pragma mark - 导航栏添加文字按钮
- (NSMutableArray<UIButton *> *)addNavigationItemWithTitles:(NSArray *)titles isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags {
    NSMutableArray * items = [[NSMutableArray alloc] init];
    
    //  调整按钮位置
    //    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    //将宽度设为负值
    //    spaceItem.width= -5;
    //    [items addObject:spaceItem];
    
    NSMutableArray * buttonArray = [NSMutableArray array];
    NSInteger i = 0;
    for (NSString *title in titles) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 30, 30);
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = [tags[i++] integerValue];
        [button sizeToFit];
        //  设置偏移
        if (isLeft) {
            [button setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        }else{
            [button setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        }
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:button];
        [items addObject:item];
        [buttonArray addObject:button];
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
    return buttonArray;
}

- (void)openSystemCameraOrPhotos:(UIViewController *)currentViewController imagePickerObjectIdentifier:(NSString *)objectIdentifier {
    __weak typeof(self) weakself = self;
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"上传头像" message:@"可以拍照或从相册中选择" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *openCamera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 检测用户手机是否能打开相机功能
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            // 如果选择拍照上传图片那么就打开系统相机
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            
            // 设置代理
            imagePicker.delegate = currentViewController;
            
            // 是否可编辑
            imagePicker.allowsEditing = YES;
            
            // 设置标识符
            imagePicker.objectIdentifier = objectIdentifier;
            
            // 设置图片选择器对象的类型
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            
            [weakself presentViewController:imagePicker animated:YES completion:nil];
            
        } else {
            [weakself showText:@"摄像头不可用"];
        }
    }];
    UIAlertAction *selectImage = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        // 创建图片选择器
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
        // 设置代理
        imagePicker.delegate = currentViewController;
        
        // 是否允许编辑
        imagePicker.allowsEditing = YES;
        
        // 设置标识符
        imagePicker.objectIdentifier = objectIdentifier;
        
        // 如果选择相册图片那么就打开系统相册
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        [weakself presentViewController:imagePicker animated:YES completion:nil];
    }];
    UIAlertAction *cancelAlert = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:openCamera];
    [alertController addAction:selectImage];
    [alertController addAction:cancelAlert];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
