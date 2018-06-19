//
//  ForecastValuesModel.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/6/19.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ForecastValuesModel.h"

@implementation ForecastValuesModel

@end

@implementation ForecastValuesInfo
+(JSONKeyMapper *)keyMapper{
    return [[JSONKeyMapper alloc]initWithModelToJSONDictionary:@{@"_id":@"id"}];
}
@end
