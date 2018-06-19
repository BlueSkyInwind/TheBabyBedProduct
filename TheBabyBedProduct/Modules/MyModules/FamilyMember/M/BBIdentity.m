//
//  BBIdentity.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/16.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBIdentity.h"

@implementation BBIdentity
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"identityId":@"id",
             @"identityName":@"name"
             };
}
@end


@implementation BBIdentityListResult
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"data":@"BBIdentity"
             };
}
@end
