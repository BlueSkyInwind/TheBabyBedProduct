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
}

/**
 忘记密码 post
 */
-(void)bb_requestForgetPasswordWithPhone:(NSString *)phone
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
    postRequest(K_Url_ForgetPassword, param, successBlock, failureBlock);
}

/**
 获取用户信息 get
 */
-(void)bb_requestGetUserInfoWithSuccessBlock:(SuccessBlock)successBlock
                                failureBlock:(FailureBlock)failureBlock
{
    [[NetWorkRequestManager sharedNetWorkManager]GetWithURL:[K_Url_BBBase stringByAppendingString:K_Url_GetUserInfo] isNeedNetStatus:NO isNeedWait:NO parameters:nil finished:successBlock failure:failureBlock];
}
/**
 上传用户图像 post
 */
-(void)bb_requestUploadImageWithImage:(UIImage *)img
                         successBlock:(SuccessBlock)successBlock
                         failureBlock:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@%@",K_Url_BBBase,K_Url_UploadImage];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager POST:url parameters:@{@"type":@"USER"} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imgData = UIImageJPEGRepresentation(img, 0.3);
        [formData appendPartWithFileData:imgData name:@"file" fileName:@"file.jpg" mimeType:@"image/jpg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        successBlock(Enum_SUCCESS,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(Enum_FAIL,error);
    }];

}
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
                             successBlock:(SuccessBlock)successBlock
                             failureBlock:(FailureBlock)failureBlock
{
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (avatarId && avatarId.length > 0) {
        [param setValue:avatarId forKey:@"avatar"];
    }
    if (babyName && babyName.length > 0) {
        [param setValue:babyName forKey:@"babyName"];
    }
    if (gender && gender.length > 0) {
        [param setValue:gender forKey:@"gender"];
    }
    if (city && city.length > 0) {
        [param setValue:city forKey:@"city"];
    }
    if (birthday && birthday.length > 0) {
        [param setValue:birthday forKey:@"bothDate"];
    }
    if (identity && identity.length > 0) {
        [param setValue:identity forKey:@"identity"];
    }
    
    postRequest(K_Url_EditUserInfo, param, successBlock, failureBlock);
}
@end
