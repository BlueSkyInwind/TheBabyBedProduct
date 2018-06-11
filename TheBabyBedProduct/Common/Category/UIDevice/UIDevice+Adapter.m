//
//  UIDevice+Adapter.m
//  JRTianTong
//
//  Created by ╰莪呮想好好宠Nǐつ on 2017/12/8.
//  Copyright © 2017年 JinRi . All rights reserved.
//

#import "UIDevice+Adapter.h"

@implementation UIDevice (Adapter)
+(CGFloat)pp_device_sizeWidth:(CGFloat)width
{
    return _k_w*width/375;
}
+(CGFloat)pp_device_sizeHeight:(CGFloat)height
{
    //iPhone X实际上是高度增加了的iPhone 6/6s/7/8
#warning 此处UI图以iPhone 6/6s/7/8为准的
    return PPDevice_isiPhoneX ? height:(_k_h*height/667);
}

@end

@implementation UIDevice (iPhoneX)
+(CGFloat)pp_device_bottomVYWithRealBottomH:(CGFloat)realBottomH
{
    if (PPDevice_isiPhoneX) {
        realBottomH += PPDevice_iphoneXBottomHeight;
    }
    return _k_h - realBottomH;
}
+(CGFloat)pp_device_bottomVHWithRealBottomH:(CGFloat)realBottomH
{
    if (PPDevice_isiPhoneX) {
        realBottomH += PPDevice_iphoneXBottomHeight;
    }
    return realBottomH;
}
+(CGFloat)pp_device_realTabbarHeight
{
    if (PPDevice_isiPhoneX) {
        return PPDevice_tabbarHeight+PPDevice_iphoneXBottomHeight;
    }
    return PPDevice_tabbarHeight;
}
@end
