//
//  BBUserDevice.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/15.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BBUserDeviceHelpers [BBUserDeviceHelper shareInstance]

/**
 我的设备信息模型
 */
@interface BBUserDevice : NSObject<NSCoding>
/** 设备号 */
@property(nonatomic,copy) NSString *deviceId;
/** 设备状态 */
@property(nonatomic,copy) NSString *deviceStatus;
/** 硬件版本 */
@property(nonatomic,copy) NSString *deviceVersion;
/** 设备型号 */
@property(nonatomic,copy) NSString *deviceType;
/** 绑定温度传感器 */
@property(nonatomic,copy) NSString *bindWD;
/** 绑定体温传感器 */
@property(nonatomic,copy) NSString *bindTW;
/** 绑定踢被传感器 */
@property(nonatomic,copy) NSString *bindTB;
/** 设备名称 */
@property(nonatomic,copy) NSString *deviceName;

+(BBUserDevice *)bb_getUserDevice;
+(void)bb_saveUserDevice:(BBUserDevice *)device;

@end



@interface BBUserDeviceHelper : NSObject
+(instancetype)shareInstance;
@property(nonatomic,assign,readonly) BOOL hasBindWD;
@property(nonatomic,assign,readonly) BOOL hasBindTW;
@property(nonatomic,assign,readonly) BOOL hasBindTB;
@property(nonatomic,copy,readonly) NSString *deviceId;
@property(nonatomic,copy,readonly) NSString *deviceStatus;
@property(nonatomic,copy,readonly) NSString *deviceVersion;
@property(nonatomic,copy,readonly) NSString *deviceType;
/** 当日是否已经签到 */
@property(nonatomic,assign,readonly) BOOL hasSignIn;
@end



