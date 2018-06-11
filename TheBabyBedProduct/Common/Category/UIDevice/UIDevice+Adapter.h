//
//  UIDevice+Adapter.h
//  JRTianTong
//
//  Created by ╰莪呮想好好宠Nǐつ on 2017/12/8.
//  Copyright © 2017年 JinRi . All rights reserved.
//

#import <UIKit/UIKit.h>

#define PPWidth(w)                    [UIDevice pp_device_sizeWidth:w]
#define PPHeight(h)                   [UIDevice pp_device_sizeHeight:h]

#define PPDevice_realBottomVY(realH)  [UIDevice pp_device_bottomVYWithRealBottomH:realH]
#define PPDevice_realBottomVH(realH)  [UIDevice pp_device_bottomVHWithRealBottomH:realH]
#define PPDevice_realTabbarHeight     [UIDevice pp_device_realTabbarHeight]

@interface UIDevice (Adapter)
//屏幕等比例缩放适配（注意iPhone X）
+(CGFloat)pp_device_sizeWidth:(CGFloat)width;
+(CGFloat)pp_device_sizeHeight:(CGFloat)height;
@end


@interface UIDevice (iPhoneX)
/**
 计算VC底部view的Y值（iPhone X底部多34不能用于响应事件，需注意）
 @param realBottomH 底部view的真实高度
 */
+(CGFloat)pp_device_bottomVYWithRealBottomH:(CGFloat)realBottomH;
/**
 计算VC底部view的H值（iPhone X底部多34不能用于响应事件，需注意）
 @param realBottomH 底部view的真实高度
 */
+(CGFloat)pp_device_bottomVHWithRealBottomH:(CGFloat)realBottomH;
/** 获取tabbar高 */
+(CGFloat)pp_device_realTabbarHeight;
@end
