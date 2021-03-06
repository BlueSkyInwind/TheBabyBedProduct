//
//  GlobalConfig.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#ifndef GlobalConfig_h
#define GlobalConfig_h

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"File_name:%s\nFuntion_Name:%s\nlines:%d \n" fmt), [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String] , __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif


//十六进制色值
#define kUIColorFromRGBA(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#define kUIColorFromRGB(rgbValue)  kUIColorFromRGBA(rgbValue,1.0)

// 设置三原色
#define rgb(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define rgbR(r) [UIColor colorWithRed:r/255.0f green:r/255.0f blue:r/255.0f alpha:1]

#define k_color_vcBg      rgb(247,249,251,1)
#define k_color_515151    rgb(51,51,51,1)
#define k_color_153153153 rgb(153,153,153,1)
#define K_color_line      rgb(229,229,229,1)
#define k_color_appOrange rgb(255,155,57,1)

#define _k_w           [UIScreen mainScreen].bounds.size.width
#define _k_h           [UIScreen mainScreen].bounds.size.height

//weak strong
#define BBWeakSelf(type)  __weak typeof(type) weak##type = type;
#define BBStrongSelf(type)  __strong typeof(type) type = weak##type;

#define BBGlobalUtility [GlobalUtility sharedUtility]

#define UI_IS_IPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define UI_IS_IPHONE5           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0)
#define UI_IS_IPHONE6P            (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0)
#define UI_IS_IPHONE6            (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
#define UI_IS_IPHONE4           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0)
#define UI_IS_IPHONEX           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 812.0)

#define NaviBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height

#define iOS7Later ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define iOS8Later ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define iOS9Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define iOS9_1Later ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)

#define Character_Number @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define NUM @"0123456789"

//主色调
#define UI_MAIN_COLOR [UIColor colorWithRed:255/255.0 green:236/255.0 blue:186/255.0 alpha:1]

UIKIT_EXTERN NSString * const Auth_Token;
UIKIT_EXTERN NSString * const kLoginFlag;

#pragma mark - 服务器地址，接口地址

UIKIT_EXTERN NSString * const _main_url;


//早教--工程师爸爸
UIKIT_EXTERN NSString *const KGCSDad_AppId;

UIKIT_EXTERN NSString *const KGCSDad_Secret;

UIKIT_EXTERN NSString *const hefengWeather_key;

UIKIT_EXTERN NSString *const BMK_SDK_key;

#pragma mrak --------远程推送报警提示--------
UIKIT_EXTERN NSString *const WARN_CRY; //哭闹告警
UIKIT_EXTERN NSString *const WARN_KICK; //踢被告警
UIKIT_EXTERN NSString *const WARN_TEMP; //室内温度告警
UIKIT_EXTERN NSString *const WARN_HUMIDITY;  //室内湿度告警
UIKIT_EXTERN NSString *const WARN_BABY_TEMP;  //宝贝体温告警
UIKIT_EXTERN NSString *const WARN_URINE;   //尿湿告警
UIKIT_EXTERN NSString *const WARN_DEVICE_NOTICE;   //设备上线通知



#endif /* GlobalConfig_h */
