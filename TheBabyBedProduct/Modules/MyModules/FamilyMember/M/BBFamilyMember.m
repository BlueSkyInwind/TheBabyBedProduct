//
//  BBFamilyMember.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/2.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBFamilyMember.h"

@implementation BBFamilyMember
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"memberID":@"id"
             };
}
@end

@implementation BBFamilyMemberListResult
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"data":@"BBFamilyMember"
             };
}
@end
