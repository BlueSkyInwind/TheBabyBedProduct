//
//  AppDelegate+BBConfigure.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/6.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "AppDelegate+BBConfigure.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"

#import "BBUserDevice.h"

#import "GVUserDefaults+Properties.h"
#import "BBHasTodaySignInResultModel.h"

@implementation AppDelegate (BBConfigure)

-(void)bb_configureShareSDK
{
    /**初始化ShareSDK应用
     
     @param activePlatforms
     
     使用的分享平台集合
     
     @param importHandler (onImport)
     
     导入回调处理，当某个平台的功能需要依赖原平台提供的SDK支持时，需要在此方法中对原平台SDK进行导入操作
     
     @param configurationHandler (onConfiguration)
     
     配置回调处理，在此方法中根据设置的platformType来填充应用配置信息
     
     */
    
    [ShareSDK registerActivePlatforms:@[
                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat),
                                        @(SSDKPlatformTypeQQ)
                                        ]
                             onImport:^(SSDKPlatformType platformType){
                                 switch (platformType){
                                     case SSDKPlatformTypeWechat:
                                         [ShareSDKConnector connectWeChat:[WXApi class]];
                                         break;
                                     case SSDKPlatformTypeQQ:
                                         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                                         break;
                                     case SSDKPlatformTypeSinaWeibo:
                                         [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                                         break;
                                     default:
                                         break;
                                 }
                             }
                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo){
                          
                          switch (platformType){
                              case SSDKPlatformTypeSinaWeibo:
                                  //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                                  [appInfo SSDKSetupSinaWeiboByAppKey:@"1260154196"
                                                            appSecret:@"6ef734b4da22229c17b94e7a47437cc5"
                                                          redirectUri:@"http://www.sharesdk.cn"
                                                             authType:SSDKAuthTypeBoth];
                                  break;
                              case SSDKPlatformTypeWechat:  //ok
                                  [appInfo SSDKSetupWeChatByAppId:@"wx87d018aa1f2346d4"
                                                        appSecret:@"43149eff51a71b423bb5a5229d04fc4f"];
                                  break;
                              case SSDKPlatformTypeQQ:
                                  [appInfo SSDKSetupQQByAppId:@"101479666"
                                                       appKey:@"fa7500acb21363c3e685a081b4306fc2"
                                                     authType:SSDKAuthTypeBoth];
                                  break;
                              default:
                                  break;
                          }
                      }];
}
-(void)bb_signInAction
{
    if (!BBUserHelpers.hasLogined) {
        return;
    }
    
    [BBRequestTool bb_requestTodayHasSignInWithSuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"今日是否已签到  %@",object);
        BBHasTodaySignInResultModel *resultM = [BBHasTodaySignInResultModel mj_objectWithKeyValues:object];
        if (resultM.code == 0) {
            BBHasTodaySignIn *hasTodaySignIn = resultM.data;
            BBUser *user = [BBUser bb_getUser];
            if (hasTodaySignIn.continuity == 1) {
                //如果根据continuity是无法对比今天是否已经签到的
                user.latestSignInDate = [NSDate bb_todayStr];
            }else{
                user.latestSignInDate = @"";
            }
            user.totalSignInDays = hasTodaySignIn.days;
            [BBUser bb_saveUser:user];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"今日是否已签到 error %@",object);
    }];
    
}


-(void)bb_refreshToken
{
    [BBRequestTool bb_requestRefreshTokenWithSuccessBlock:^(EnumServerStatus status, id object) {
        NSDictionary *result = (NSDictionary *)object;
        NSDictionary *dataDict = [result objectForKey:@"data"];
        NSString *token = [dataDict objectForKey: @"device_token"];
        [GVUserDefaults standardUserDefaults].deviceToken = token;
    } failureBlock:^(EnumServerStatus status, id object) {
        
    }];
}
-(void)test
{
#warning todo pp605
//    [BBRequestTool bb_requestShareWithSuccessBlock:^(EnumServerStatus status, id object) {
//        NSLog(@"share success %@",object);
//    } failureBlock:^(EnumServerStatus status, id object) {
//        NSLog(@"share error %@",object);
//    }];
    
//    [BBRequestTool bb_requestGetHelpListWithSuccessBlock:^(EnumServerStatus status, id object) {
//        NSLog(@"HelpList success %@",object);
//    } failureBlock:^(EnumServerStatus status, id object) {
//        NSLog(@"HelpList error %@",object);
//    }];
    
//    [BBRequestTool bb_requestMoneyListWithSuccessBlock:^(EnumServerStatus status, id object) {
//        NSLog(@"MoneyList success %@",object);
//    } failureBlock:^(EnumServerStatus status, id object) {
//        NSLog(@"MoneyList error %@",object);
//    }];
}

-(void)NotificationRemind:(NSDictionary *)contentInfo{
    
    NSString * msg;
    if ([contentInfo.allKeys containsObject:@"msg"]) {
        msg = contentInfo[@"msg"];
    }
    if ([contentInfo.allKeys containsObject:@"type"]) {
        NSString * type = contentInfo[@"type"];
        if ([type isEqualToString:WARN_CRY]) {
            
        }
        if ([type isEqualToString:WARN_KICK]) {
            
        }
        if ([type isEqualToString:WARN_TEMP]) {
            
        }
        if ([type isEqualToString:WARN_HUMIDITY]) {
            
        }
        if ([type isEqualToString:WARN_BABY_TEMP]) {
            
        }
        if ([type isEqualToString:WARN_URINE]) {
            
        }
        if ([type isEqualToString:WARN_DEVICE_NOTICE]) {
            //收到设备上线通知，开启udp服务
            [[BBUdpSocketManager shareInstance] createAsyncUdpSocket];
        }
    }    
}



@end
