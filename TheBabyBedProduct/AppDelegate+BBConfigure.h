//
//  AppDelegate+BBConfigure.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/6.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (BBConfigure)
-(void)bb_configureShareSDK;
-(void)bb_signInAction;
-(void)bb_refreshToken;
-(void)test;


/**
 获取用户可用身份数组，并保存在本地，每次进入都重新获取，然后与本地的对比，然后更新到最新
 */
-(void)bb_getIdentities;

/**
 收到通知处理

 @param contentInfo 信息
 */
-(void)NotificationRemind:(NSDictionary *)contentInfo;

@end
