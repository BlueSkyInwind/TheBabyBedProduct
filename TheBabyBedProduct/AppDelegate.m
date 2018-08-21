//
//  AppDelegate.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchConfiguration.h"

#import "JPUSHService.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import "NetWorkRequestManager.h"
#import "AppDelegate+BBConfigure.h"
#import "BaseNavigationViewController.h"

#import "BBLoginAndRegistViewController.h"


@interface AppDelegate ()<JPUSHRegisterDelegate,UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [application setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    
    
    if (BBUserHelpers.hasLogined) {
        self.tabBar = [[BaseTabBarViewController alloc]init];
        BaseNavigationViewController *baseNav = [[BaseNavigationViewController alloc]initWithRootViewController:self.tabBar];
        self.window.rootViewController = baseNav;
    }else{
        BBLoginAndRegistViewController *loginVC = [[BBLoginAndRegistViewController alloc]init];
        loginVC.isHiddenCloseBT = YES;
        BBWeakSelf(loginVC)
        loginVC.BBLoginOrRegistResultBlock = ^(BOOL isSuccess) {
            if (isSuccess) {
                BBStrongSelf(loginVC)
                [loginVC dismissViewControllerAnimated:YES completion:nil];
                self.tabBar = [[BaseTabBarViewController alloc]init];
                BaseNavigationViewController *baseNav = [[BaseNavigationViewController alloc]initWithRootViewController:self.tabBar];
                self.window.rootViewController = baseNav;
            }
        };
        BaseNavigationViewController *loginNav = [[BaseNavigationViewController alloc]initWithRootViewController:loginVC];
        self.window.rootViewController = loginNav;
    }
    [self.window makeKeyAndVisible];
    
    [[LaunchConfiguration shared] InitializeAppConfiguration];
    [self initJPush:launchOptions];
    
    [self bb_configureShareSDK];
    [self InitializeBMKSDK];
    [self bb_signInAction];
    [self bb_refreshToken];
    [self bb_getIdentities];

    return YES;
}


/**
 三方初始化
 */
-(void)tripartiteInitialize{
    dispatch_queue_t queue = dispatch_queue_create("trilateral_initialize", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        
    });
}

-(void)initJPush:(NSDictionary *)launchOptions{
    
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加 定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    [JPUSHService setupWithOption:launchOptions appKey:appKey
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:nil];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    //清除激光推送JPush服务器中存储的badge值
    [JPUSHService resetBadge];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark- JPUSHRegisterDelegate
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    
    [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeNone categories:nil];
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    DLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    _notificationContentInfo= userInfo;
    [self NotificationRemind:userInfo];
    // Required, iOS 7 Support
    if (application.applicationState == UIApplicationStateActive ){
        
    }else if(application.applicationState == UIApplicationStateBackground){
        
    }else if(application.applicationState == UIApplicationStateInactive){
        
    }
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    _notificationContentInfo = notification.request.content.userInfo;
    [self NotificationRemind:userInfo];
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    _notificationContentInfo = response.notification.request.content.userInfo;
    [self NotificationJump:_notificationContentInfo];
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:_notificationContentInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}
#endif
-(void)NotificationJump:(NSDictionary *)contentInfo{
 
    if ([contentInfo.allKeys containsObject:@"type"]) {
        
    }
    
    if ([contentInfo.allKeys containsObject:@"msg"]) {
        
    }
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)nowWindow {
    
    //    是非支持横竖屏
    if (_allowRotation){
        return UIInterfaceOrientationMaskLandscapeRight;
    } else{
        return UIInterfaceOrientationMaskPortrait;
    }
}


@end
