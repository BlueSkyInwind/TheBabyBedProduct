//
//  GlobalTool.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "GlobalTool.h"

@implementation GlobalTool

static GlobalTool * shareTool = nil;
+(GlobalTool *)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareTool = [[GlobalTool alloc]init];
    });
    return shareTool;
}

+ (float)getIOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
+ (NSString *)getAppVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;
}
+ (NSString *)getProjectName{
    
    NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];
    return executableFile;
}

//设置沙盒
+ (void)saveUserDefaul:(NSString *)content Key:(NSString *)key;
{
    [[NSUserDefaults standardUserDefaults] setObject:content forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getContentWithKey:(NSString *)key;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}


/**
 获取当前视图
 
 @return 返回结果
 */
-(UIViewController *)topViewController{
    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController * navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self topViewController:presentedViewController];
}
//判断手机号是否有效
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,147,183
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181
     */
    NSString * MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|7[0-9]|8[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，183
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[156])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else {
        return NO;
    }
}

/**
 生成对应颜色的图片

 @param color 色值
 @return 图片
 */
-(UIImage *)imageWithColor:(UIColor *)color {
    
    CGRect rect = CGRectMake(0.0, 0.0, 1.0, 1.0);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef  context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage * image =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSString *)getNowTime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

//将时间转换为时间戳
+ (NSTimeInterval)timeToTimestamp:(NSString *)timeStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [formatter dateFromString:timeStr];
    NSTimeInterval timesp = [date timeIntervalSince1970];
    formatter = nil;
    return timesp;
}
//时间戳转换为时间
+ (NSString *)timestampToTime:(NSTimeInterval)timestamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = nil;
    date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *timeStr = [formatter stringFromDate:date];
    formatter = nil;
    return timeStr;
}


@end
