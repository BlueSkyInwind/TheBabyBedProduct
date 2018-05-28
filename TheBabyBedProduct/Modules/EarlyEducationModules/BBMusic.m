//
//  BBMusic.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/5/11.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMusic.h"

@implementation BBMusic
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"musicID":@"id"
             };
}
@end

@implementation BBMusicAudioinfos
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"contents":@"BBMusic"
             };
}
@end

@implementation BBMusicResult

@end

