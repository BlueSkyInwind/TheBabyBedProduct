//
//  NetWorkRequestManager+BBRequest.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/6.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "NetWorkRequestManager+BBRequest.h"

@implementation NetWorkRequestManager (BBRequest)
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
    
    NSString *url = [NSString stringWithFormat:@"%@%@",K_Url_BBBase,K_Url_Login];
    
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
    
    [BBRequestTool PostWithURL:url isNeedNetStatus:NO isNeedWait:NO parameters:param finished:successBlock failure:failureBlock];
}
/**
 意见反馈 get
 
 @param content 提交的内容
 */
-(void)bb_requestSubmitSuggestionWithContent:(NSString *)content
                                successBlock:(SuccessBlock)successBlock
                                failureBlock:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@",K_Url_BBBase,K_Url_Suggestion];
    [BBRequestTool PostWithURL:url isNeedNetStatus:NO isNeedWait:NO parameters:@{@"content":content} finished:successBlock failure:failureBlock];
}
@end
