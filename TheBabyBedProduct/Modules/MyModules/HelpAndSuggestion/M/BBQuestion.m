//
//  BBQuestion.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/7/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBQuestion.h"

@implementation BBQuestion
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"questionId":@"id"
             };
}
@end


@implementation BBQuestionListRequestResult
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"data":@"BBQuestion"
             };
}
@end
