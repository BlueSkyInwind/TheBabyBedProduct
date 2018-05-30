//
//  AppDelegate.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarViewController.h"

static NSString *appKey = @"c69b80f8c7c71bdee9413cbb";
static NSString *channel = @"App Store";
static BOOL isProduction = true;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic)BaseTabBarViewController * tabBar;
@property (nonatomic,strong)NSDictionary * notificationContentInfo;
@property (strong, nonatomic) UIButton  *playBtn;

@end

