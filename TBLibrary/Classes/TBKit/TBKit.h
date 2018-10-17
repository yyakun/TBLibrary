//
//  TBKit.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#ifndef TBKit_h
#define TBKit_h


#import <MBProgressHUD/MBProgressHUD.h>
#import "UIView+TBAutoLayout.h"
#import "UIView+TBFrame.h"
#import "NSObject+TBRuntime.h"
#import "UIView+TBConfig.h"
#import "UIColor+TBHex.h"
#import "UIView+TB.h"
#import "TBAlertTextView.h"
#import "TBSubView.h"
#import "TBBadgeButton.h"
#import "TBPasswordTextField.h"
#import "UIButton+TBImagePositionButton.h"
#import "TBCharts.h"
#import "TBTipView.h"
#import "TBPageControl.h"
#import "TBScrollViewHorizontalItem.h"
#import "TBSegmentBarViewController.h"
#import "TBSlideMenuViewController.h"
#import "TBStarRatingView.h"
#import "UIView+TBFileOwner.h"
#import "UIResponder+TB.h"
#import "UIView+MotionEffect.h"
#import "TBCreateViewKit.h"
#import "UIView+TBScratchableLatexView.h"
#import "UIView+TBVisualEffectView.h"
#import "UITextView+TB.h"
#import "NSAttributedString+TBText.h"
#import "NSObject+TBAlert.h"
#import "TBImagePageView.h"
#import "TBAttributedLabel.h"
#import "NSObject+MBProgressHUD.h"
#import "UIImage+TBResizeCreate.h"
#import "UIImage+TBRotate.h"
#import "UIImage+TBClipCorner.h"
#import "UIViewController+TB.h"
#import "UINavigationController+TB.h"
#import "NSObject+UIViewController.h"
#import "TBHorizontalPagingView.h"


#define UIColorClear [UIColor clearColor]// 透明色
#define UIColorWhite [UIColor whiteColor]

#define UIColorFromRGB(r, g, b)\
[UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]

#define UIColorFromRGBA(r, g, b, a)\
[UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]

#define UIColorFromHex(hex)\
[UIColor colorWithHex:(hex) alpha:1.0f]

#define UIColorFromRandom \
[UIColor randomColorWithAlpha:1.0f]

#define UIFont(size) [UIFont systemFontOfSize:size]
#define UIFont_B(size) [UIFont boldSystemFontOfSize:size]

#define WINDOW [[[UIApplication sharedApplication] delegate] window]


//  通过故事板找到视图控制器viewController，需要设置视图控制器的标识符
#define getViewControllerByStoryboard(storyboardName, viewControllerIdentifier)\
\
[[UIStoryboard storyboardWithName:storyboardName bundle:nil] instantiateViewControllerWithIdentifier:viewControllerIdentifier]


//  给一个视图添加手势，点按Tap（不需判断状态)、长按LongPress（需要判断状态Began）、（捏合Pinch、旋转Rotation、拖动Pan：需要判断状态Changed，ended）、屏幕边缘拖动手势ScreenEdgePan、轻扫Swipe（不需判断状态)
#define addViewGestureRecognizer(viewName, gestureRecognizerClass, gestureRecognizerName)\
\
gestureRecognizerClass *gestureRecognizerName = [[gestureRecognizerClass alloc] initWithTarget:self action:@selector(gestureRecognizer:)];\
[viewName addGestureRecognizer:gestureRecognizerName];\
viewName.userInteractionEnabled = YES;\
viewName.objectIdentifier = ([@#viewName hasPrefix:@"self."] ? [@#viewName substringFromIndex:5] : @#viewName);\
gestureRecognizerName.objectIdentifier = [NSString stringWithFormat:@"%@-%@", @#gestureRecognizerName, viewName.objectIdentifier];


//  通过对象的objectIdentifier找到对象视图view
#define getView(viewClassName, viewName, objectIdentifier, superview)\
\
viewClassName *viewName = (viewClassName *)[superview getSubviewByObjectIdentifier:objectIdentifier];


//  用来确定一个对象，返回一个BOOL值
#define confirmObject(object, objectIdentifierText)\
\
[object.objectIdentifier isEqualToString:objectIdentifierText]


//  初始化view
#define view_initWithFrame \
\
- (instancetype)initWithFrame:(CGRect)frame {\
    self = [super initWithFrame:frame];\
    if (self) {\
        [self setupUI];\
        [self setupLayout];\
    }\
    return self;\
}


//  初始化cell
#define cell_initWithStyle_WithReuseIdentifier \
\
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {\
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];\
    if (self) {\
        [self setupUI];\
        [self setupLayout];\
    }\
    return self;\
}


//  创建一个能被其它视图关联的视图，在UIView类（另外得创建一个同类名的xib文件的view）中实现该方法即代表：此视图可以被其它视图关联
#define createLinkView \
\
- (id)initWithCoder:(NSCoder *)aDecoder {\
    self = [super initWithCoder:aDecoder];\
    if (self) {\
        UIView *containerView = [[[UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil] instantiateWithOwner:self options:nil] lastObject];\
        [self addSubview:containerView];\
        containerView.frame = CGRectMake(0, 0, containerView.frame.size.width, containerView.frame.size.height);\
    }\
    return self;\
}


#endif /* TBKit_h */
