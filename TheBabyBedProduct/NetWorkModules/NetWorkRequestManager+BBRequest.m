//
//  NetWorkRequestManager+BBRequest.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/6.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "NetWorkRequestManager+BBRequest.h"

@implementation NetWorkRequestManager (BBRequest)

static void postRequest(NSString *url,id param,SuccessBlock successBlock,FailureBlock failureBlock){
    NSString *requestUrl = @"";
    if ([url containsString:K_Url_BBBase]) {
        requestUrl = url;
    }else{
        requestUrl = [NSString stringWithFormat:@"%@%@",K_Url_BBBase,url];
    }
    [BBRequestTool PostWithURL:requestUrl isNeedNetStatus:NO isNeedWait:NO parameters:param finished:successBlock failure:failureBlock];
}

/**
 登录
 
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
                   failureBlock:(FailureBlock)failureBlock
{
    NSParameterAssert(phone.length > 0);
    NSParameterAssert(password.length > 0);
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:phone forKey:@"phone"];
    [param setValue:password forKey:@"password"];
    [param setValue:[NSString stringWithFormat:@"%ld",(long)loginType] forKey:@"type"];
    
    if (uid && uid.length > 0) {
        [param setValue:uid forKey:@"uid"];
    }
    if (openid && openid.length > 0) {
        [param setValue:openid forKey:@"openid"];
    }
    
    postRequest(K_Url_Login, param, successBlock, failureBlock);
}
/**
 意见反馈 get
 
 @param content 提交的内容
 */
-(void)bb_requestSubmitSuggestionWithContent:(NSString *)content
                                successBlock:(SuccessBlock)successBlock
                                failureBlock:(FailureBlock)failureBlock
{
    postRequest(K_Url_Suggestion, @{@"content":content}, successBlock, failureBlock);
}
/**
 获取验证码 post
 
 @param phone 手机号
 @param codeType 登录or注册or忘记密码等才获取验证码
 */
-(void)bb_requestGetCodeWithPhone:(NSString *)phone
                         codeType:(BBGetCodeType)codeType
                     successBlock:(SuccessBlock)successBlock
                     failureBlock:(FailureBlock)failureBlock
{
    NSDictionary *param = @{@"phone":phone,@"type":[NSNumber numberWithInteger:codeType]};
    postRequest(K_Url_GetCode, param, successBlock, failureBlock);
}

/**
 注册 post
 */
-(void)bb_requestRegistWithPhone:(NSString *)phone
                            code:(NSString *)code
                        password:(NSString *)password
                    successBlock:(SuccessBlock)successBlock
                    failureBlock:(FailureBlock)failureBlock
{
    NSDictionary *param = @{
                            @"phone":phone,
                            @"code":code,
                            @"password":password
                            };
    postRequest(K_Url_Regist, param, successBlock, failureBlock);
    ;
}

@end
