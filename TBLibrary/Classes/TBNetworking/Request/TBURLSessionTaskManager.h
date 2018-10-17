//
//  TBURLSessionTaskManager.h
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TBURLResponse;

typedef void(^TBRequestComplete)(TBURLResponse *response, NSError *error);

/**
 *  管理所有用户请求
 *  请求的统一出口
 */
@interface TBURLSessionTaskManager : NSObject

+ (instancetype)sharedInstance;

/**
 *  发送一条数据请求
 *
 *  @param request  请求所需的URL Request
 *  @param userInfo 请求中所涵盖的用户信息，调用成功之后会返回
 *  @param complete 请求调用成功以后的回调
 *
 *  @return 发送的请求的任务id
 */
- (NSUInteger)requestWithURLRequest:(NSURLRequest *)request userInfo:(NSDictionary *)userInfo complete:(TBRequestComplete)complete;

/**
 *  取消某个请求
 *
 *  @param taskIdentifier 需要取消的请求的task id
 */
- (void)cancelRequestWithTaskIdentifier:(NSNumber *)taskIdentifier;

@end
