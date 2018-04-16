//
//  BaseResultModel.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BaseResultModel.h"

@implementation BaseResultModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}

@end

//------- login start ----
@implementation BBLoginResultModel

@end
//------- login end ----


@implementation BaseDictResultModel
@end


@implementation BBUserDeviceResultModel
@end
