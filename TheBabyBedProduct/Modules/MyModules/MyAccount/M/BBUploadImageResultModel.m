//
//  BBUploadImageResultModel.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/10.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBUploadImageResultModel.h"

@implementation BBUploadImageResultData
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"imgId" : @"id"
             };
}
@end

@implementation BBUploadImageResultModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"data":@"BBUploadImageResultData"
             };
}
@end



