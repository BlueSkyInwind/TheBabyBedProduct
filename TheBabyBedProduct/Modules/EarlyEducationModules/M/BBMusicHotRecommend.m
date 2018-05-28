//
//  BBMusicHotRecommend.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/5/14.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMusicHotRecommend.h"

@implementation BBMusicHotRecommend
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"hotRecommendID":@"id"
             };
}
@end

@implementation BBMusicHotRecommendAudioinfos
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"contents":@"BBMusic"
             };
}
@end

@implementation BBMusicHotRecommendResult

@end
