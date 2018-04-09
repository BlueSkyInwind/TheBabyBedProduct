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
/** 是否登录 */
@property(nonatomic,assign) BOOL hasLogined;

/** 令牌 */
@property(nonatomic,copy) NSString *token;
/** 用户信息是否填写完整   false 不完整  true 完整 */
@property(nonatomic,assign) BOOL reg;
/** 用户名 */
@property(nonatomic,copy) NSString *username;
/** 当前用户是否有绑定婴儿床设备  false 没有绑定  true 已绑定 */
@property(nonatomic,assign) BOOL bind;

/** 头像url */
@property(nonatomic,copy) NSString *avatar;
/** 出生日期 如：2018-01-30T08:33:31.173Z*/
@property(nonatomic,copy) NSString *both;
/** 出生地 */
@property(nonatomic,copy) NSString *city;
/**  剩余可观看视频时间 */
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

+(BBUser *)bb_getUser;
+(void)bb_saveUser:(BBUser *)user;

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

/** 记录我的界面headerview的登录状态 */
@property(nonatomic,assign) BOOL myHeaderVHasLogined;
@end
