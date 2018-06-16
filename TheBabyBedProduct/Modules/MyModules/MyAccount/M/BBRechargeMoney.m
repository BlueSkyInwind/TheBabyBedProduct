//
//  BBRechargeMoney.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/13.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBRechargeMoney.h"

@implementation BBRechargeMoney
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"configId":@"id"
             };
}
@end


@implementation BBRechargeMoneyListResult
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"data":@"BBRechargeMoney"
             };
}
@end
