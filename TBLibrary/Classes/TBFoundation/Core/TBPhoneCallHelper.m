//
//  TBPhoneCallHelper.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBPhoneCallHelper.h"
#import <UIKit/UIKit.h>
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>

NSInteger const TBPHONECALLFAILEDTIME = -100;

@interface TBPhoneCallHelper () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) TBPhoneCallOverBlock completion;
@property (nonatomic, strong) CTCallCenter *callCenter;
@property (nonatomic) BOOL countPhoneTime;
@property (nonatomic) CFAbsoluteTime becomeActiveTime;;
@property (nonatomic) CFAbsoluteTime startTime;

@end

@implementation TBPhoneCallHelper

+ (instancetype)sharedInstance {
    static TBPhoneCallHelper *sharePhoneCallHelper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharePhoneCallHelper = [[self alloc] initUseInner];
    });
    return sharePhoneCallHelper;
}

- (instancetype)initUseInner {
    if (self = [super init]) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        
        _callCenter = [[CTCallCenter alloc] init];
        __weak typeof(self) weakself = self;
        _callCenter.callEventHandler = ^(CTCall* call) {
            if ([call.callState isEqualToString:CTCallStateDisconnected]) {
                NSInteger time = TBPHONECALLFAILEDTIME;
                if (weakself.countPhoneTime) {
                    time = (NSInteger)(CFAbsoluteTimeGetCurrent() - weakself.startTime);
                }
                weakself.countPhoneTime = NO;
                dispatch_async(dispatch_get_main_queue() , ^{
                    weakself.completion(ceil(time));
                });
            } else if ([call.callState isEqualToString:CTCallStateConnected]) {
                weakself.startTime = CFAbsoluteTimeGetCurrent();
                weakself.countPhoneTime = YES;
            } else if ([call.callState isEqualToString:CTCallStateDialing]) {
                weakself.countPhoneTime = NO;
            } else {
                NSLog(@"Nothing is done");
            }
        };
    }
    return self;
}

- (instancetype)init {
    NSAssert(NO, @"换条路吧，别用这个了");
    return nil;
}

- (BOOL)supportPhoneFunction {
    UIDevice *device = [UIDevice currentDevice];
    if ([@"iPhone" isEqualToString : device.model]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)call:(NSString *)phoneNumber completion:(TBPhoneCallOverBlock)completion {
    self.completion = completion;
    _countPhoneTime = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]]]];
}

@end
