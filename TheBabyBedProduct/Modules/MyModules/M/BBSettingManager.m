//
//  BBSettingManager.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBSettingManager.h"
#import <objc/runtime.h>

@implementation BBSettingManager
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

+(BBSettingManager *)bb_getSettingManager
{
    return toGetManager();
}
+(void)bb_saveSettingManager:(BBSettingManager *)manager
{
    toSaveManager(manager);
}

static void toSaveManager(BBSettingManager *manager){
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:manager];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:k_bb_settingManager];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

static BBSettingManager * toGetManager(){
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:k_bb_settingManager];
    BBSettingManager *manager = (BBSettingManager *)[NSKeyedUnarchiver unarchiveObjectWithData:data];
    return manager;
}
@end
