//
//  BBRechargeMoney.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/13.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBRechargeMoney : NSObject
@property(nonatomic,assign) NSInteger configId;
@property(nonatomic,strong) NSNumber *rechargeMoney;
@property(nonatomic,assign) NSInteger rechargeTime;
@end


@interface BBRechargeMoneyListResult : NSObject
@property(nonatomic,assign) NSInteger code;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,strong) NSMutableArray *data;
@end

/*
{
    code = 0;
    data =     (
                {
                    id = 1;
                    rechargeMoney = 1;
                    rechargeTime = 1;
                },
                {
                    id = 2;
                    rechargeMoney = 2;
                    rechargeTime = 2;
                },
                {
                    id = 3;
                    rechargeMoney = "0.1";
                    rechargeTime = 4;
                },
                {
                    id = 4;
                    rechargeMoney = "0.01";
                    rechargeTime = 5;
                }
                );
    msg = "请求成功";
}
 */
