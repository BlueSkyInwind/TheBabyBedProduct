//
//  BBExchange.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 任务奖励-->积分兑换
 */
@interface BBExchange : NSObject
/** 当前兑换分钟数 */
@property(nonatomic,assign) NSInteger curTime;
/** 目前总分钟数 */
@property(nonatomic,assign) NSInteger total_curTime;
@end


@interface BBExchangeResult : NSObject
@property(nonatomic,assign) NSInteger code;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,strong) BBExchange *data;
@end

/*
 
积分兑换 success {
    code = 0;
    data =     {
        curTime = 2;
        "total_curTime" = 121;
    };
    msg = "请求成功";
}
 
 */
