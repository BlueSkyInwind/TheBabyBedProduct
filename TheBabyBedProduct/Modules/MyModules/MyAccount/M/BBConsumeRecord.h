//
//  BBConsumeRecord.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/1.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BBPage;

@interface BBConsumeRecord : NSObject
@property(nonatomic,copy) NSString *rechargeMoney;
@property(nonatomic,assign) BBPayType rechargeType;
@property(nonatomic,assign) BBConsumeType consumptioType;
@end



@interface BBConsumeRecordListResult : NSObject
@property(nonatomic,assign) NSInteger code;
@property(nonatomic,assign) NSInteger count;
@property(nonatomic,strong) NSMutableArray *data;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,strong) BBPage *page;
@end


/*
 "data": [{
 "id": "string",
 "rechargeMoney": 0,// 充值价格
 "rechargeTime": 0, // 充值价格对应的时间
 “rechargeType”: 0,充值类型 0 支付宝 1 微信
 “consumptioType”:0消费类型  0 充值 1 花费
 “createTime”:0
 }],,


response json --- {
    code = 0;
    count = 19;
    data =     (
                {
                    consumptionType = 0;
                    id = b98f5926525b4159a67ef70274b04f8e;
                    rechargeMoney = "0.01";
                    rechargeTime = 5;
                    rechargeType = 0;
                }
                );
    msg = "请求成功";
    page =     {
        content =         (
                           );
        count = 19;
        first = 1;
        last = 0;
        number = 0;
        numberOfElements = 10;
        size = 10;
        totalElements = 19;
        totalPages = 2;
    };
}
 
 */
