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
        [aCoder encodeObject:[self valueForKeyPath: name] forKey: name];
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
        [self setValue:[aDecoder decodeObjectForKey:name] forKey:name];
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
    return [BBUser bb_getUser].hasLogined;
}
-(BOOL)hasQQBinding
{
    return [BBUser bb_getUser].hasQQBinding;
}
-(BOOL)isHasWeiXinBinding
{
    return [BBUser bb_getUser].hasWeiXinBinding;
}
-(BOOL)hasWeiBoBinding
{
    return [BBUser bb_getUser].hasWeiBoBinding;
}
-(NSString *)token
{
    return [BBUser bb_getUser].token;
}
@end
