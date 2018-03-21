//
//  GlobalTool.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

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
//判断手机号是否有效
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
@end
