//
//  UIDevice+GetDeviceMessages.h
//  JRTianTong
//
//  Created by ╰莪呮想好好宠Nǐつ on 2017/11/7.
//  Copyright © 2017年 JinRi . All rights reserved.
//
//更多，请参考：https://github.com/PengfeiWang666/iOS-getClientInfo

#import <UIKit/UIKit.h>

#define PPDevice_isiPhone5            [UIDevice pp_device_iphone5]
#define PPDevice_isiPhone6_6s_7_8     [UIDevice pp_device_iPhone6_6s_7_8]
#define PPDevice_isiPhone6p_6sp_7p_8p [UIDevice pp_device_iPhone6p_6sp_7p_8p]
#define PPDevice_isiPhoneX            [UIDevice pp_device_iphoneX]

#define PPDevice_statusBarHeight      [UIDevice pp_device_statusBarHeight]
#define PPDevice_navBarHeight         [UIDevice pp_device_navBarHeight]

#define PPDevice_iphoneXBottomHeight  34
#define PPDevice_tabbarHeight         49




@interface UIDevice (GetDeviceMessages)
/**
 获取手机ip地址
 */
+(NSString *)pp_device_ipAddress;
+(BOOL)pp_device_iphone5;
+(BOOL)pp_device_iPhone6_6s_7_8;
+(BOOL)pp_device_iPhone6p_6sp_7p_8p;
+(BOOL)pp_device_iphoneX;

+(CGFloat)pp_device_statusBarHeight;
+(CGFloat)pp_device_navBarHeight;
@end



