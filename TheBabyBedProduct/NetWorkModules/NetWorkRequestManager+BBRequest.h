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
@end
