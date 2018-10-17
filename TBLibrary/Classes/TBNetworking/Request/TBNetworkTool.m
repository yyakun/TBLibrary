//
//  TBNetworkTool.m
//  TBLibrary
//
//  Created by 杨亚坤 on 2017/3/13.
//  Copyright © 2017年 yyk. All rights reserved.
//

#import "TBNetworkTool.h"
#import <AFNetworking/AFNetworking.h>

@implementation TBNetworkTool

+ (void)uploadImageWithURLString:(NSString *)urlString parameters:(NSDictionary *)dict images:(NSArray *)images names:(NSArray *)names completion:(void(^)(id responseObject))block {
    if (images.count != names.count) {
        NSLog(@"请求参数有误！");
        return;
    }
    AFHTTPSessionManager *manger =[AFHTTPSessionManager manager];
    manger.requestSerializer.timeoutInterval = 20;
    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    [manger POST:urlString parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i = 0; i < images.count; i++) {
            NSData *imageData = UIImageJPEGRepresentation(images[i], 0.5);
            NSDateFormatter *form = [[NSDateFormatter alloc]init];
            [form setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [form stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@-%d.jpg", dateString, i];
            [formData appendPartWithFileData:imageData name:names[i] fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"---上传进度--- %@",uploadProgress);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"```上传成功``` %@",responseObject);
        block ? block(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"xxx上传失败xxx %@", error);
        
    }];
}

+ (void)webServiceRequestWithURLString:(NSString *)urlString soapString:(NSString *)soapString separatedString:(NSString *)separatedString httpHeaderField:(NSDictionary *)httpHeaderField completion:(void(^)(NSString *responseString))block {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    // 设置请求超时时间
    manager.requestSerializer.timeoutInterval = 20.f;
    // 返回NSData
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    // 设置请求头
    [httpHeaderField enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSNumber class]]) {
            [manager.requestSerializer setValue:[obj stringValue] forHTTPHeaderField:key];
        } else {
            [manager.requestSerializer setValue:obj forHTTPHeaderField:key];
        }
    }];
    [manager.requestSerializer setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[soapString length]] forHTTPHeaderField:@"Content-Length"];
    
    // 设置HTTPBody
    [manager.requestSerializer setQueryStringSerializationWithBlock:^NSString * _Nonnull(NSURLRequest * _Nonnull request, id  _Nonnull parameters, NSError * _Nullable __autoreleasing * _Nullable error) {
        return soapString;
    }];
    
    [manager POST:urlString parameters:soapString progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 把返回的二进制数据转为字符串
        NSString *result = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"WebServiceRequest Result : %@", result);
        
        NSMutableString *oppositeString = [[NSMutableString alloc] initWithString:separatedString];
        [oppositeString insertString:@"/" atIndex:1];
        NSString *string = [[result componentsSeparatedByString:separatedString] lastObject];
        NSString *responseString = [[string componentsSeparatedByString:oppositeString] firstObject];
        
        !block ?: block(responseString);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

@end
