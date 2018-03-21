//
//  NetWorkRequestManager.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "NetWorkRequestManager.h"

@implementation NetWorkRequestManager

+ (NetWorkRequestManager *)sharedNetWorkManager
{
    static NetWorkRequestManager *sharedNetWorkManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedNetWorkManagerInstance = [[self alloc] init];
    });
    return sharedNetWorkManagerInstance;
}

#pragma mark - 发起请求

- (void)PostWithURL:(NSString *)strURL isNeedNetStatus:(BOOL)isNeedNetStatus isNeedWait:(BOOL)isNeedWait parameters:(id)parameters finished:(SuccessFinishedBlock)finished failure:(FailureBlock)failure
{
    [self obtainDataWithUrl:strURL method:@"POST" parameters:parameters requestTime:30 isNeedNetStatus:isNeedNetStatus isNeedWait:isNeedWait uploadProgress:nil downloadProgress:nil finished:finished failure:failure];
}
- (void)GetWithURL:(NSString *)strURL isNeedNetStatus:(BOOL)isNeedNetStatus isNeedWait:(BOOL)isNeedWait parameters:(id)parameters finished:(SuccessFinishedBlock)finished failure:(FailureBlock)failure
{
    [self obtainDataWithUrl:strURL method:@"GET" parameters:parameters requestTime:30 isNeedNetStatus:isNeedNetStatus isNeedWait:isNeedWait uploadProgress:nil downloadProgress:nil finished:finished failure:failure];
}

-(void)obtainDataWithUrl:(NSString *)strURL
                  method:(NSString *)method
              parameters:(id)parameters
             requestTime:(NSTimeInterval)requestTime
         isNeedNetStatus:(BOOL)isNeedNetStatus
              isNeedWait:(BOOL)isNeedWait
          uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
        downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
                finished:(SuccessFinishedBlock)finished
                 failure:(FailureBlock)failure{
    
    // 网络判断
    if (![GlobalUtility sharedUtility].networkState && isNeedNetStatus) {
        [[MBPAlertView sharedMBPTextView] showTextOnly:[UIApplication sharedApplication].keyWindow message:@"请确认您的手机是否连接到网络!"];
        return;
    }
    
    //进度条
    if (isNeedWait) {
        [AFNetworkActivityIndicatorManager sharedManager].enabled = isNeedWait;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer = [AFJSONRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //请求头
    [self setHttpHeaderInfo:manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"application/x-www-form-urlencoded",@"application/json",@"charset=UTF-8",@"text/plain", nil];
    manager.requestSerializer.timeoutInterval = requestTime;
    
    DLog(@"-----requestParam-----%@",parameters);
    DLog(@"-----requestUrl-----%@",strURL);
    
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:strURL relativeToURL:nil] absoluteString] parameters:parameters error:&serializationError];
    
    NSURLSessionDataTask *dataTask =  [manager dataTaskWithRequest:request uploadProgress:uploadProgress downloadProgress:downloadProgress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (failure) {
                DLog(@"response error --- %@",error.description);
                [AFNetworkActivityIndicatorManager sharedManager].enabled = NO;
                failure(Enum_FAIL,error);
            }
        } else {
            if (finished) {
                NSDictionary * resultDic = [NSDictionary dictionary];
                if ([responseObject isKindOfClass:[NSData class]]) {
                    resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
                }else{
                    resultDic = [NSDictionary dictionaryWithDictionary:responseObject];
                    NSData *data = [NSJSONSerialization dataWithJSONObject:resultDic options:NSJSONWritingPrettyPrinted error:nil];
                    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                }
                DLog(@"response json --- %@",resultDic.description);
                [AFNetworkActivityIndicatorManager sharedManager].enabled = isNeedWait;
                finished(Enum_SUCCESS,responseObject);
            }
        }
    }];
    [dataTask resume];
}
/**
 添加请求头
 */
-(void)setHttpHeaderInfo:(AFHTTPSessionManager *)manager{
    
    if ([GlobalUtility sharedUtility].token != nil) {
        [manager.requestSerializer setValue:[GlobalUtility sharedUtility].token forHTTPHeaderField:@"x-auth-token"];
    }
}



@end
