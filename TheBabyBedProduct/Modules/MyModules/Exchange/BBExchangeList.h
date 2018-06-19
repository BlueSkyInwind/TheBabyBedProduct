//
//  BBExchangeList.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/18.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBExchangeList : NSObject
@property(nonatomic,assign) NSInteger use_score;
@property(nonatomic,assign) NSInteger cur_time;
@property(nonatomic,strong) NSNumber *opat;
@end


@interface BBExchangeListResult : NSObject
@property(nonatomic,assign) NSInteger code;
@property(nonatomic,strong) NSMutableArray *data;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,assign) NSInteger count;
@end

/*
{
    code = 0;
    data =     (
                {
                    "cur_time" = 2;
                    id = 4b4654addbc1456d9a56530c74adb0c4;
                    opat = 1527524052;
                    "use_score" = 2;
                    "user_id" = 49a1a9a681c94a47adbc5129c12851bc;
                },
                {
                    "cur_time" = 2;
                    id = 7df9d3d893194d9190a1423f18c9fba6;
                    opat = 1527694882;
                    "use_score" = 2;
                    "user_id" = 49a1a9a681c94a47adbc5129c12851bc;
                },
                {
                    "cur_time" = 22;
                    id = a4daa7faf94a46588432239952c7c522;
                    opat = 1529235593;
                    "use_score" = 22;
                    "user_id" = 49a1a9a681c94a47adbc5129c12851bc;
                }
                );
    msg = "请求成功";
}
*/
