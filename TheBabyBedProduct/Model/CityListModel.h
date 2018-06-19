//
//  CityListModel.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/6/19.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol CityListModel <NSObject>

@end

@protocol AreaListModel <NSObject>

@end

@interface ProvinceListModel : JSONModel

/* <#Description#>*/
@property(nonatomic,strong)NSString<Optional> * code;
@property(nonatomic,strong)NSString<Optional> * name;
@property(nonatomic,strong)NSString<Optional> * en;
@property(nonatomic,strong)NSArray<CityListModel,Optional> * citylist;

@end

@interface CityListModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * code;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * en;
@property(nonatomic,strong)NSArray<AreaListModel,Optional> * arealist;

@end

@interface AreaListModel : JSONModel

@property(nonatomic,strong)NSString<Optional> * code;
@property(nonatomic,strong)NSString<Optional> * name;
@property(nonatomic,strong)NSString<Optional> * en;

@end


