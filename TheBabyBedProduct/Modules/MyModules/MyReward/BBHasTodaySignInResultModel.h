//
//  BBHasTodaySignInResultModel.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/5/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BaseResultModel.h"

@interface BBHasTodaySignIn : NSObject
/** 当前是否签到 0 未签到 1 已签到 */
@property(nonatomic,assign) NSInteger continuity;
/** 连续签到的天数 */
@property(nonatomic,assign) NSInteger days;
@end

@interface BBHasTodaySignInResultModel : BaseResultModel
@property(nonatomic,strong) BBHasTodaySignIn *data;
@end


/*
 
 
response json --- {
    code = 0;
    data =     {
        continuity = 1;
        days = 1;
    };
    msg = "请求成功";
}

*/
