//
//  NetWorkRequestManager+BBRequest.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/6.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "NetWorkRequestManager.h"

typedef NS_ENUM(NSInteger,BBGetCodeType) {
    BBGetCodeTypeOther  = -1,             //位置短信
    BBGetCodeTypeRegist = 1,              //注册短信
    BBGetCodeTypeLogin,                   //登录
    BBGetCodeTypeForgetPassword           //忘记密码
};

@interface NetWorkRequestManager (BBRequest)

/**
 登录 post ok
 
 @param phone 手机号
 @param password 密码
 @param loginType 登录类型 （参考BBLoginType）
 @param uid 微博授权登录的时候必传
 @param openid 微信和qq 登录的时候必填
 */
-(void)bb_requestLoginWithPhone:(NSString *)phone
                       password:(NSString *)password
                      loginType:(BBLoginType)loginType
                            uid:(NSString *)uid
                         openid:(NSString *)openid
                   successBlock:(SuccessBlock)successBlock
                   failureBlock:(FailureBlock)failureBlock;


/**
 意见反馈 post ok

 @param content 提交的内容
 */
-(void)bb_requestSubmitSuggestionWithContent:(NSString *)content
                                successBlock:(SuccessBlock)successBlock
                                failureBlock:(FailureBlock)failureBlock;

/**
 获取验证码 post

 @param phone 手机号
 @param codeType 登录or注册or忘记密码等才获取验证码
 */
-(void)bb_requestGetCodeWithPhone:(NSString *)phone
                         codeType:(BBGetCodeType)codeType
                     successBlock:(SuccessBlock)successBlock
                     failureBlock:(FailureBlock)failureBlock;

/**
 注册 post
 */
-(void)bb_requestRegistWithPhone:(NSString *)phone
                            code:(NSString *)code
                        password:(NSString *)password
                    successBlock:(SuccessBlock)successBlock
                    failureBlock:(FailureBlock)failureBlock;
/*
 获取消息列表的数据
 */
-(void)getMessageListWith:(int)page
             successBlock:(SuccessBlock)successBlock
             failureBlock:(FailureBlock)failureBlock;
/**
 编辑消息列表
 */
-(void)editMessageListWith:(NSString *)editOrReaded
                messageIds:(NSString *)messageIds
              successBlock:(SuccessBlock)successBlock
              failureBlock:(FailureBlock)failureBlock;

/**
 忘记密码 post
 */
-(void)bb_requestForgetPasswordWithPhone:(NSString *)phone
                                    code:(NSString *)code
                                password:(NSString *)password
                            successBlock:(SuccessBlock)successBlock
                            failureBlock:(FailureBlock)failureBlock;

/**
 修改密码 post
 @param currentP 最新的密码
 */
-(void)bb_requestModifyPasswordWhihCurrentP:(NSString *)currentP
                               successBlock:(SuccessBlock)successBlock
                               failureBlock:(FailureBlock)failureBlock;

/**
 获取用户信息 get
 */
-(void)bb_requestGetUserInfoWithSuccessBlock:(SuccessBlock)successBlock
                                failureBlock:(FailureBlock)failureBlock;

/**
 获取身份 get
 */
-(void)bb_requestGetIdentitiesWithSuccessBlock:(SuccessBlock)successBlock
                                  failureBlock:(FailureBlock)failureBlock;

/**
 上传用户图像 post
 */
-(void)bb_requestUploadImageWithImage:(UIImage *)img
                         successBlock:(SuccessBlock)successBlock
                         failureBlock:(FailureBlock)failureBlock;

/**
 编辑资料
 @param avatarId 用户头像资料
 */
-(void)bb_requestEditUserInfoWithAvatarId:(NSString *)avatarId
                                 babyName:(NSString *)babyName
                                   gender:(NSString *)gender
                                     city:(NSString *)city
                                 birthday:(NSString *)birthday
                                 identity:(NSString *)identity
                                 password:(NSString *)password
                               rePassword:(NSString *)rePassword
                             successBlock:(SuccessBlock)successBlock
                             failureBlock:(FailureBlock)failureBlock;

/**
 获取用户设备信息 get
 */
-(void)bb_requestGetDeviceInfoWithSuccessBlock:(SuccessBlock)successBlock
                                  failureBlock:(FailureBlock)failureBlock;

/**
 帮助list get
 */
-(void)bb_requestGetHelpListWithPageNo:(NSInteger)pageNo
                              pageSize:(NSInteger)pageSize
                          successBlock:(SuccessBlock)successBlock
                          failureBlock:(FailureBlock)failureBlock;

/**
 签到 post
 */
-(void)bb_requestSignInWithSuccessBlock:(SuccessBlock)successBlock
                           failureBlock:(FailureBlock)failureBlock;

/**
 今日是否已签到
 */
-(void)bb_requestTodayHasSignInWithSuccessBlock:(SuccessBlock)successBlock
                                   failureBlock:(FailureBlock)failureBlock;

/**
 签到列表 post
 */
-(void)bb_requestSignInListWithSuccessBlock:(SuccessBlock)successBlock
                               failureBlock:(FailureBlock)failureBlock;

/**
 积分兑换 post
 */
-(void)bb_requestExchangeWithSuccessBlock:(SuccessBlock)successBlock
                             failureBlock:(FailureBlock)failureBlock;

/**
 积分兑换记录 post
 */
-(void)bb_requestExchangeListWithPageNo:(NSInteger)pageNo
                           successBlock:(SuccessBlock)successBlock
                           failureBlock:(FailureBlock)failureBlock;

/*
 预选值列表
 */
-(void)bb_requestMoneyListWithSuccessBlock:(SuccessBlock)successBlock
                              failureBlock:(FailureBlock)failureBlock;

/*
 消费记录列表
 */
-(void)bb_requestCurListWithPageNo:(NSInteger)pageNo
                          pageSize:(NSInteger)pageSize
                      SuccessBlock:(SuccessBlock)successBlock
                      failureBlock:(FailureBlock)failureBlock;

/*
 已绑定用户列表
 */
-(void)bb_requestBindListWithPageNo:(NSInteger)pageNo
                           pageSize:(NSInteger)pageSize
                       SuccessBlock:(SuccessBlock)successBlock
                       failureBlock:(FailureBlock)failureBlock;

/*
 申请记录列表
 */
-(void)bb_requestApplyListWithApplyType:(BBApplyType)applyType
                                 pageNo:(NSInteger)pageNo
                               pageSize:(NSInteger)pageSize
                           SuccessBlock:(SuccessBlock)successBlock
                           failureBlock:(FailureBlock)failureBlock;
/*
 改变申请状态
 */
-(void)bb_requestChangeStatusWithFamilyMemberId:(NSString *)familyMemberId
                                         status:(BBApplyStatus)status
                                   successBlock:(SuccessBlock)successBlock
                                   failureBlock:(FailureBlock)failureBlock;

/*
 分享赚积分
 */
-(void)bb_requestShareWithSuccessBlock:(SuccessBlock)successBlock
                          failureBlock:(FailureBlock)failureBlock;


/**
 早教列表(一级分类)
 */
-(void)bb_requestEarlyEdutionListWithSuccessBlock:(SuccessBlock)successBlock
                                     failureBlock:(FailureBlock)failureBlock;
/**
 早教列表（二级分类）
 */
-(void)bb_requestEarlyEdutionSubListWithCategoryIds:(NSArray *)categoryIds
                                       SuccessBlock:(SuccessBlock)successBlock
                                       failureBlock:(FailureBlock)failureBlock;
/**
 音乐搜索
 */
-(void)bb_requestEarlyEdutionQueryWithKeyWord:(NSString *)keyWord
                                 successBlock:(SuccessBlock)successBlock
                                 failureBlock:(FailureBlock)failureBlock;

/**
 子类下对应的music列表
 */
-(void)bb_requestEarlyEdutionSubListListWithCategoryId:(NSString *)categoryId
                                          successBlock:(SuccessBlock)successBlock
                                          failureBlock:(FailureBlock)failureBlock;

/**
 早教热门推荐
 */
-(void)bb_requestEarlyEdutionHotRecommendWithSuccessBlock:(SuccessBlock)successBlock
                                             failureBlock:(FailureBlock)failureBlock;

/**
 刷新token
 */
-(void)bb_requestRefreshTokenWithSuccessBlock:(SuccessBlock)successBlock
                                 failureBlock:(FailureBlock)failureBlock;

/**
 获取邀请码
 */
-(void)bb_requestGenInCodeWithSuccessBlock:(SuccessBlock)successBlock
                              failureBlock:(FailureBlock)failureBlock;


/**
 预值设定
 @param deviceType 设备类型  0 室内外温度传感器数据
 1  声音传感器数据（哭闹）
 2 体温传感器 （额头传感器，腋下传感器）
 3 湿度传感器（有没有尿湿）
 4 踢被传感器数据
 @param minValue 最小值
 @param maxValue 最大值
 @param deviceId 设备id
 */
-(void)SetThresholdValueDeviceType:(NSString *)deviceType minValue:(NSString *)minValue maxValue:(NSString *)maxValue deviceId:(NSString *)deviceId img:(NSArray *)imgIDs successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

/*  获取预值  */
-(void)GetThresholdValueDeviceType:(NSString *)deviceType deviceId:(NSString *)deviceId successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
/*  获取曲线数据  */
-(void)GetStatisticsDataDeviceType:(NSString *)deviceType deviceId:(NSString *)deviceId successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
/*  绑定设备  */
-(void)applyBindDeviceId:(NSString *)deviceId successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
/*  获取天气信息(拼音) */
-(void)applyCityWeatherInfo:(NSString *)cityEn successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;
/*  获取天气信息（经纬） */
-(void)applyCityWeatherInfo:(NSString *)lan lon:(NSString *)lon successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

@end
