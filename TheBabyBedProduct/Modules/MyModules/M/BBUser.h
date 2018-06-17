//
//  BBUser.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BBUserHelpers [BBUserHelper shareInstance]

@interface BBUser : NSObject<NSCoding>
/** 是否登录 my */
@property(nonatomic,assign) BOOL hasLogined;

/** 令牌 */
@property(nonatomic,copy) NSString *token;
/** 用户信息是否填写完整   false 不完整  true 完整 */
@property(nonatomic,assign) BOOL reg;

/** 用户名 */
@property(nonatomic,copy) NSString *username;
/** 宝宝昵称 */
@property(nonatomic,copy) NSString *nickName;
/** 当前用户是否有绑定婴儿床设备  false 没有绑定  true 已绑定 */
@property(nonatomic,assign) BOOL bind;
/** 头像url */
@property(nonatomic,copy) NSString *avatar;
/** 出生日期 如：1523856194*/
@property(nonatomic,copy) NSNumber *both;
/** 出生地 */
@property(nonatomic,copy) NSString *city;
/** 剩余可观看视频时间 */
@property(nonatomic,copy) NSString *curTime;
/** 性别 */
@property(nonatomic,assign) BBUserGenderType gender;
/** 是否绑定微信 */
@property(nonatomic,assign) BOOL bindWX;
/** 是否绑定微博 */
@property(nonatomic,assign) BOOL bindWB;
/** 是否绑定qq */
@property(nonatomic,assign) BOOL bindQQ;
/** 身份 */
@property(nonatomic,copy) NSString *identity;
/** 密码 */
@property(nonatomic,copy) NSString *password;
/** 绑定的设备id */
@property(nonatomic,copy) NSString *deviceId;
/** 总积分 */
@property(nonatomic,assign) NSUInteger totalScore;
/** 是否是管理员 */
@property(nonatomic,assign) BOOL manager;
/** 是否有观看视频权限 */
@property(nonatomic,assign) BOOL videoAuth;
/** 账号余额 */
@property(nonatomic,copy) NSNumber *price;


/*  2018-06-06
{
    code = 0;
    data =     {
        avatar = "/2018/05/31/3/3/1527696059093.jpg";
        bindQQ = 0;
        bindWB = 0;
        bindWX = 0;
        both = 1496592000;
        city = "辽宁大连金州";
        curTime = 95;
        deviceId = 1111;
        gender = 0;
        id = 49a1a9a681c94a47adbc5129c12851bc;
        identity = "爸爸";
        manager = 1;
        nickName = "槿知";
        price = "4.16";
        totalScore = 12;
        username = 13386050182;
        videoAuth = 1

    };
    msg = "请求成功";
}

*/

//辅助，帮助判断签到信息
/** 最新一次签到日期 */
@property(nonatomic,copy) NSString *latestSignInDate;
/** 最新一次首页弹出签到框的日期 */
@property(nonatomic,copy) NSString *latestHomePagePopSingInDate;
//总共签到天数
@property(nonatomic,assign) NSInteger totalSignInDays;


+(BBUser *)bb_getUser;
+(void)bb_saveUser:(BBUser *)user;

@end

@interface BBUser  (AllProperty)
/** 所有属性 */
@property(nonatomic,strong,readonly) NSArray *properties;
@end

@interface BBUser (Handler)
-(NSString *)bb_userGenderHandle;
+(BBUserGenderType)bb_genderTypeWithStr:(NSString *)genderStr;
@end


@interface BBUserHelper : NSObject
+(instancetype)shareInstance;
/** 是否登录 */
@property(nonatomic,assign,readonly) BOOL hasLogined;
@property(nonatomic,assign,readonly) BOOL hasWeiXinBinding;
@property(nonatomic,assign,readonly) BOOL hasWeiBoBinding;
@property(nonatomic,assign,readonly) BOOL hasQQBinding;
@property(nonatomic,copy,readonly) NSString *token;
@property(nonatomic,copy,readonly) NSString *password;
@property(nonatomic,copy,readonly) NSString *deviceId;
@property(nonatomic,copy,readonly) NSString *city;
@property(nonatomic,copy,readonly) NSString *curTime;
@property(nonatomic,copy,readonly) NSNumber *price;



/** 今日是否已经签到 */
@property(nonatomic,assign,readonly) BOOL hasTodaySignIn;
/** 今日首页是否已经弹出签到框 */
@property(nonatomic,assign,readonly) BOOL hasTodayHomePopSignIn;
/** 首页是否需要弹出签到框 */
@property(nonatomic,assign,readonly) BOOL isNeedPopSignIn;

/** 记录我的界面headerview的登录状态 */
@property(nonatomic,assign) BOOL myHeaderVHasLogined;


@end
