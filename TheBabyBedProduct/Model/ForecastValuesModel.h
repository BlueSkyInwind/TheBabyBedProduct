//
//  ForecastValuesModel.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/6/19.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BaseResultModel.h"
@class  ForecastValuesInfo;
@protocol ForecastValuesInfo <NSObject>

@end

@interface ForecastValuesModel : BaseResultModel
@property (nonatomic, strong) ForecastValuesInfo<Optional> *data;
@end

@interface ForecastValuesInfo: JSONModel

@property (nonatomic, strong)NSString<Optional> * deviceType;
@property (nonatomic, strong)NSString<Optional> * _id;
@property (nonatomic, strong)NSString<Optional> * maxVal;
@property (nonatomic, strong)NSString<Optional> * minVal;
@property (nonatomic, strong)NSString<Optional> * gz_niao;
@property (nonatomic, strong)NSString<Optional> * qw_niao;
@property (nonatomic, strong)NSString<Optional> * zdd_niao;
@property (nonatomic, strong)NSString<Optional> * zd_niao;

@end
