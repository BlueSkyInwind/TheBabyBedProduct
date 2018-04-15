//
//  BBUserDevice.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/15.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBUserDevice.h"
#import <objc/runtime.h>

@implementation BBUserDevice

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    //归档
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        const char * propertyName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        if ([self valueForKeyPath: name]) {
            [aCoder encodeObject:[self valueForKeyPath: name] forKey: name];
        }
    }
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    // 解档
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        const char * propertyName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        if ([aDecoder decodeObjectForKey:name]) {
            [self setValue:[aDecoder decodeObjectForKey:name] forKey:name];
        }
        
    }
    return self;
}

+(BBUserDevice *)bb_getUserDevice
{
    return toGetUserDevice();
}
+(void)bb_saveUserDevice:(BBUserDevice *)device
{
    toSaveUserDevice(device);
}

static void toSaveUserDevice(BBUserDevice *userDevice){
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userDevice];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:k_bb_saveUserDeviceMessage];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

static BBUserDevice * toGetUserDevice(){
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:k_bb_saveUserDeviceMessage];
    BBUserDevice *userDevice = (BBUserDevice *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return userDevice;
}
@end


@implementation BBUserDeviceHelper
+(instancetype)shareInstance
{
    static BBUserDeviceHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[BBUserDeviceHelper alloc]init];
    });
    return helper;
}
-(NSString *)deviceId
{
    return _aUserDevice().deviceId;
}
-(NSString *)deviceType
{
    return _aUserDevice().deviceType;
}
-(NSString *)deviceStatus
{
    return _aUserDevice().deviceStatus;
}
-(NSString *)deviceVersion
{
    return _aUserDevice().deviceVersion;
}
-(BOOL)hasBindWD
{
    return _aUserDevice().bindWD.length > 0;
}
-(BOOL)hasBindTW
{
    return _aUserDevice().bindTW.length > 0;
}
-(BOOL)hasBindTB
{
    return _aUserDevice().bindTB.length > 0;
}
static inline BBUserDevice *_aUserDevice(){
    return [BBUserDevice bb_getUserDevice];
}

@end



