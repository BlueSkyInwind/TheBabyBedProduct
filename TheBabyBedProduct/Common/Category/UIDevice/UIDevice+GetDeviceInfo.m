//
//  UIDevice+GetDeviceInfo.m
//  PPCategoryExample
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/5/10.
//  Copyright © 2018年 PPAbner. All rights reserved.
//

#import "UIDevice+GetDeviceInfo.h"

@implementation UIDevice (GetDeviceInfo)
+(NSString *)pp_UUID{
    return PPDevice().identifierForVendor.UUIDString;
}


static inline UIDevice *PPDevice(){
    return [UIDevice currentDevice];
};
@end
