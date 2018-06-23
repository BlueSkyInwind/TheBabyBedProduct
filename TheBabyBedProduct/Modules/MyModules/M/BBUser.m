//
//  BBUser.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBUser.h"
#import <objc/runtime.h>

@implementation BBUser

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    //归档
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        const char * propertyName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        if ([self valueForKeyPath: name] && ![name isEqualToString:@"properties"]) {
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
        if ([aDecoder decodeObjectForKey:name] && ![name isEqualToString:@"properties"]) {
            [self setValue:[aDecoder decodeObjectForKey:name] forKey:name];
        }
        
    }
    return self;
}

+(BBUser *)bb_getUser
{
    return toGetUser();
}
+(void)bb_saveUser:(BBUser *)user
{
    toSaveUser(user);
}

static void toSaveUser(BBUser *user){
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:k_bb_saveUserMessage];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

static BBUser * toGetUser(){
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:k_bb_saveUserMessage];
    BBUser *user = (BBUser *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return user;
}
@end

@implementation BBUser (AllProperty)
-(NSArray *)properties
{
    NSMutableArray *properties = [NSMutableArray array];
    unsigned int propertyCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
    for (int i = 0; i < propertyCount; i ++) {
        objc_property_t property = propertys[i];
        const char * propertyName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:propertyName];
        [properties addObject:name];
    }
    return properties;
}
@end


@implementation BBUser (Handler)
-(NSString *)bb_userGenderHandle
{
    if (self.gender == BBUserGenderTypeMan) {
        return @"男";
    }else if (self.gender == BBUserGenderTypeWoman){
        return @"女";
    }else if (self.gender == BBUserGenderTypeSecrect){
        return @"保密";
    }else{
        return @"未知";
    }
}
+(BBUserGenderType)bb_genderTypeWithStr:(NSString *)genderStr
{
    if ([genderStr isEqualToString:@"男"]) {
        return BBUserGenderTypeMan;
    }else if ([genderStr isEqualToString:@"女"]){
        return BBUserGenderTypeWoman;
    }else if ([genderStr isEqualToString:@"保密"]){
        return BBUserGenderTypeSecrect;
    }else{
        return BBUserGenderTypeUnknow;
    }
}
@end


@implementation BBUserHelper
+(instancetype)shareInstance
{
    static BBUserHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[BBUserHelper alloc]init];
    });
    return helper;
}
-(BOOL)hasLogined
{
    return _aUser().hasLogined;
}
-(BOOL)hasQQBinding
{
    return _aUser().bindQQ;
}
-(BOOL)isHasWeiXinBinding
{
    return _aUser().bindWX;
}
-(BOOL)hasWeiBoBinding
{
    return _aUser().bindWB;
}
-(NSString *)token
{
    return _aUser().token;
}
-(NSString *)deviceId
{
    return _aUser().deviceId;
}
-(NSString *)password
{
    return _aUser().password;
}
-(NSString *)city
{
    return _aUser().city;
}
-(NSString *)curTime
{
    return _aUser().curTime;
}
-(NSNumber *)price
{
    return _aUser().price;
}
-(BOOL)hasTodaySignIn
{
    if ([_aUser().latestSignInDate isEqualToString:[NSDate bb_todayStr]]) {
        return YES;
    }
    return NO;
}
-(BOOL)hasTodayHomePopSignIn
{
    if ([_aUser().latestHomePagePopSingInDate isEqualToString:[NSDate bb_todayStr]]) {
        return YES;
    }
    return NO;
}
-(BOOL)isNeedPopSignIn
{
    if (!BBUserHelpers.hasLogined) {
        return NO;
    }
    //如果今日已经签到了，肯定不用弹出了
    if (BBUserHelpers.hasTodaySignIn) {
        return NO;
    }else{
        //我弹出了签到，但用户没有签到
        if (BBUserHelpers.hasTodayHomePopSignIn) {
            return NO;
        }
        return YES;
    }
}
static inline BBUser *_aUser(){
    return [BBUser bb_getUser];
}

@end
