//
//  LaunchConfiguration.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "LaunchConfiguration.h"

@implementation LaunchConfiguration

+ (LaunchConfiguration *)shared
{
    static dispatch_once_t predicate;
    static LaunchConfiguration * _launchConfiguration = nil;
    
    dispatch_once(&predicate, ^{
        _launchConfiguration = [[LaunchConfiguration alloc] init];
    });
    return _launchConfiguration;
    
}

-(void)InitializeAppConfiguration{
    
    //键盘配置
    [[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarByPosition];
    [[IQKeyboardManager sharedManager]setShouldResignOnTouchOutside:true];
    [IQKeyboardManager sharedManager].shouldToolbarUsesTextFieldTintColor = true;
    [BaseCentralManager shareInstance];
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                DLog(@"未知网络 || 没有网络(断网)");
                [GlobalUtility sharedUtility].networkState = NO;
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                DLog(@"手机自带网络 || WIFI");
               [GlobalUtility sharedUtility].networkState = YES;
                break;
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];
    
}


+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
    });
}



@end
