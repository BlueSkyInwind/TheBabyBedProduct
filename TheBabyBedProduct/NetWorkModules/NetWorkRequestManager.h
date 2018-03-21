//
//  NetWorkRequestManager.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>
//连接状态
typedef enum {
    ///返回数据正确
    Enum_SUCCESS = 0,
    ///返回数据出错
    Enum_FAIL = 1,
    ///连接不上服务器
    Enum_NOTCONNECTED = 2,
    ///超时连接
    Enum_CONNECTEDTIMEOUT = 3
    
} EnumServerStatus;

typedef void (^SuccessFinishedBlock)(EnumServerStatus status, id object);
typedef void (^FailureBlock)(EnumServerStatus status, id object);

@interface NetWorkRequestManager : NSObject

+ (NetWorkRequestManager *)sharedNetWorkManager;
- (void)PostWithURL:(NSString *)strURL isNeedNetStatus:(BOOL)isNeedNetStatus isNeedWait:(BOOL)isNeedWait parameters:(id)parameters finished:(SuccessFinishedBlock)finished failure:(FailureBlock)failure;
- (void)GetWithURL:(NSString *)strURL isNeedNetStatus:(BOOL)isNeedNetStatus isNeedWait:(BOOL)isNeedWait parameters:(id)parameters finished:(SuccessFinishedBlock)finished failure:(FailureBlock)failure;


@end
