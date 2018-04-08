//
//  BaseResultModel.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BBUser;

@interface BaseResultModel : JSONModel

@property (nonatomic, strong)NSString<Optional> *msg;
//@property (nonatomic, strong)NSString<Optional> * code;
//@property (nonatomic, strong)id<Optional> data;
@property(nonatomic,assign) int code;

@end

//------- login start ----
@interface BBLoginResultModel : BaseResultModel
@property(nonatomic,strong) BBUser *data;
@end

//------- login end ----

@interface BaseDictResultModel : BaseResultModel
@property(nonatomic,strong) NSDictionary *data;
@end
