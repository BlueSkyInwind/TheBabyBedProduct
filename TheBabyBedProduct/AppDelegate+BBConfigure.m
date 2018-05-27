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
                                        //                                        @(SSDKPlatformTypeSinaWeibo),
                                        @(SSDKPlatformTypeWechat)
                                        //                                        @(SSDKPlatformTypeQQ)
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
                                  [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                                            appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                                          redirectUri:@"http://www.sharesdk.cn"
                                                             authType:SSDKAuthTypeBoth];
                                  break;
                              case SSDKPlatformTypeWechat:  //ok
                                  [appInfo SSDKSetupWeChatByAppId:@"wx87d018aa1f2346d4"
                                                        appSecret:@"43149eff51a71b423bb5a5229d04fc4f"];
                                  break;
                              case SSDKPlatformTypeQQ:
                                  [appInfo SSDKSetupQQByAppId:@"100371282"
                                                       appKey:@"aed9b0303e3ed1e27bae87c33761161d"
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
    [BBRequestTool bb_requestSignInWithSuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"签到成功 %@",object);
        NSDictionary *result = (NSDictionary *)object;
        if ([result.allKeys containsObject:@"msg"]) {
            NSString *msg = [result objectForKey:@"msg"];
            if ([msg containsString:@"已签到"]) {
                BBUser *user = [BBUser bb_getUser];
                user.latestSignInDate = [NSDate bb_todayStr];
                [BBUser bb_saveUser:user];
            }
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"签到shibai  %@",object);
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
@end
