//
//  GlobalTool.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GlobalTools [GlobalTool share]

@interface GlobalTool : NSObject

+(GlobalTool *)share;

//系统版本号
+ (float)getIOSVersion;
//app版本号
+ (NSString *)getAppVersion;
//工程名字
+ (NSString *)getProjectName;
//设置沙盒
+ (void)saveUserDefaul:(NSString *)content Key:(NSString *)key;
+ (NSString *)getContentWithKey:(NSString *)key;
/**
 获取当前视图
 
 @return 返回结果
 */
-(UIViewController *)topViewController;
//判断手机号是否有效 【不准】
//+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 生成对应颜色的图片
 @param color 色值
 @return 图片
 */
-(UIImage *)imageWithColor:(UIColor *)color;


/**
 获取当前时间

 @return 当前时间  yyyy-MM-dd
 */
+ (NSString *)getNowTime;

//将时间转换为时间戳
+ (NSTimeInterval)timeToTimestamp:(NSString *)timeStr;
//时间戳转换为时间
+ (NSString *)timestampToTime:(NSTimeInterval)timestamp;
//时间戳转换为24H时间制
+ (NSString *)timestampTo24HTime:(NSTimeInterval)timestamp;
+ (void)openSystemSetting;
+(void)openSystemSetting:(NSString *)setUrl;
@end
