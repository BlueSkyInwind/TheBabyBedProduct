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
    [BBRequestTool PostWithURL:requestUrl isNeedNetStatus:NO isNeedWait:true parameters:param finished:successBlock failure:failureBlock];
}

static void postRequestGCSDad(NSString *url,id param,SuccessBlock successBlock,FailureBlock failureBlock){
    NSString *requestUrl = @"";
    if ([url containsString:K_Url_BBBaseGCSDad]) {
        requestUrl = url;
    }else{
        requestUrl = [NSString stringWithFormat:@"%@%@",K_Url_BBBaseGCSDad,url];
    }
    [BBRequestTool PostWithURL:requestUrl isNeedNetStatus:NO isNeedWait:true parameters:param finished:successBlock failure:failureBlock];
}

static void getRequest(NSString *url,id param,SuccessBlock successBlock,FailureBlock failureBlock){
    NSString *requestUrl = @"";
    if ([url containsString:K_Url_BBBase]) {
        requestUrl = url;
    }else{
        requestUrl = [NSString stringWithFormat:@"%@%@",K_Url_BBBase,url];
    }
    [BBRequestTool GetWithURL:requestUrl isNeedNetStatus:NO isNeedWait:true parameters:param finished:successBlock failure:failureBlock];
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
    if (loginType == BBLoginTypeDefault) {
        NSParameterAssert(phone.length > 0);
        NSParameterAssert(password.length > 0);
    }
    
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
    NSString *typeStr = @"";
    if (codeType == BBGetCodeTypeRegist) {
        typeStr = @"REGISTER";
    }else if (codeType == BBGetCodeTypeLogin){
        typeStr = @"LOGIN";
    }else if (codeType == BBGetCodeTypeForgetPassword){
        typeStr = @"FORGETPASSWORD";
    }else{
        typeStr = @"OTHER";
    }
    NSDictionary *param = @{@"phone":phone,@"type":typeStr};
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

/*
 获取消息列表的数据
 */
-(void)getMessageListWith:(int)page
             successBlock:(SuccessBlock)successBlock
             failureBlock:(FailureBlock)failureBlock{
    NSDictionary *param = @{
                            @"pageNo":@(page),
                            @"pageSize":@(10),
                            };
    getRequest(K_Url_MessageList, param, successBlock, failureBlock);
}

/**
 编辑消息列表
 editOrReaded 操作动作  0 删除消息 1 将消息标记为已读
 messageIds 多个id 用 逗号隔开
 */
-(void)editMessageListWith:(NSString *)editOrReaded
                            messageIds:(NSString *)messageIds
                    successBlock:(SuccessBlock)successBlock
                    failureBlock:(FailureBlock)failureBlock
{
    NSDictionary *param = @{
                            @"op":editOrReaded,
                            @"ids":messageIds
                            };
    postRequest(K_Url_MessageEidt, param, successBlock, failureBlock);
    ;
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
 修改密码 post
 @param currentP 最新的密码
 */
-(void)bb_requestModifyPasswordWhihCurrentP:(NSString *)currentP
                               successBlock:(SuccessBlock)successBlock
                               failureBlock:(FailureBlock)failureBlock
{
    NSDictionary *param = @{
                            
                            };
    postRequest(K_Url_ModifyPassword, param, successBlock, failureBlock);
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
                                 password:(NSString *)password
                               rePassword:(NSString *)rePassword
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
    if (password && password.length > 0) {
        [param setValue:password forKey:@"password"];
    }
    if (rePassword && rePassword.length > 0) {
        [param setValue:rePassword forKey:@"repassword"];
    }
    
    postRequest(K_Url_EditUserInfo, param, successBlock, failureBlock);
}
/**
 获取用户设备信息 get
 */
-(void)bb_requestGetDeviceInfoWithSuccessBlock:(SuccessBlock)successBlock
                                  failureBlock:(FailureBlock)failureBlock
{
    getRequest(K_Url_DeviceInfo, nil, successBlock, failureBlock);
}

/**
 帮助list get
 */
-(void)bb_requestGetHelpListWithSuccessBlock:(SuccessBlock)successBlock
                                failureBlock:(FailureBlock)failureBlock
{
     getRequest(K_Url_HelpList, nil, successBlock, failureBlock);
}

/**
 签到 post
 */
-(void)bb_requestSignInWithSuccessBlock:(SuccessBlock)successBlock
                           failureBlock:(FailureBlock)failureBlock
{
    postRequest(K_Url_SignIn, nil, successBlock, failureBlock);
}
/**
 今日是否已签到
 */
-(void)bb_requestTodayHasSignInWithSuccessBlock:(SuccessBlock)successBlock
                                   failureBlock:(FailureBlock)failureBlock
{
    postRequest(K_Url_TodayHasSignIn, nil, successBlock, failureBlock);
}
/**
 签到列表 post
 */
-(void)bb_requestSignInListWithSuccessBlock:(SuccessBlock)successBlock
                               failureBlock:(FailureBlock)failureBlock
{
    postRequest(K_Url_SignInList, nil, successBlock, failureBlock);
}

/**
 积分兑换 post
 */
-(void)bb_requestExchangeWithSuccessBlock:(SuccessBlock)successBlock
                             failureBlock:(FailureBlock)failureBlock
{
    postRequest(K_Url_Exchange, nil, successBlock, failureBlock);
}
/*
 预选值列表
 */
-(void)bb_requestMoneyListWithSuccessBlock:(SuccessBlock)successBlock
                              failureBlock:(FailureBlock)failureBlock
{
    getRequest(K_Url_MoneyList, nil, successBlock, failureBlock);
}
/*
 消费记录列表
 */
-(void)bb_requestCurListWithPageNo:(NSInteger)pageNo
                          pageSize:(NSInteger)pageSize
                      SuccessBlock:(SuccessBlock)successBlock
                      failureBlock:(FailureBlock)failureBlock;
{
    NSString *url = [NSString stringWithFormat:@"%@?pageNo=%ld&pageSize=%ld",K_Url_CurList,(long)pageNo,(long)pageSize];
    getRequest(url, nil, successBlock, failureBlock);
}
/*
 已绑定用户列表
 */
-(void)bb_requestBindListWithPageNo:(NSInteger)pageNo
                           pageSize:(NSInteger)pageSize
                       SuccessBlock:(SuccessBlock)successBlock
                       failureBlock:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@?pageNo=%ld&pageSize=%ld",K_Url_BindList,(long)pageNo,(long)pageSize];
    getRequest(url, nil, successBlock, failureBlock);
}
/*
 申请记录列表
 applyType  // -1 所有的申请记录  0 视频的申请记录 1 绑定的申请记录
 */
-(void)bb_requestApplyListWithApplyType:(BBApplyType)applyType
                                 pageNo:(NSInteger)pageNo
                               pageSize:(NSInteger)pageSize
                           SuccessBlock:(SuccessBlock)successBlock
                           failureBlock:(FailureBlock)failureBlock
{
    NSString *url = [NSString stringWithFormat:@"%@?pageNo=%ld&pageSize=%ld&applyType=%ld",K_Url_ApplyList,(long)pageNo,(long)pageSize,(long)applyType];
    getRequest(url, nil, successBlock, failureBlock);
}

/*
 改变申请状态
 */
-(void)bb_requestChangeStatusWithFamilyMemberId:(NSString *)familyMemberId
                                         status:(BBApplyStatus)status
                                   successBlock:(SuccessBlock)successBlock
                                   failureBlock:(FailureBlock)failureBlock
{
    if (![familyMemberId bb_isSafe]) {
        return;
    }
    NSString *url = [K_Url_ChangeStatus stringByAppendingFormat:@"%@",familyMemberId];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@(status) forKey:@"applyStatus"];
    postRequest(url, param, successBlock, failureBlock);
}
/*
 分享赚积分
 */
-(void)bb_requestShareWithSuccessBlock:(SuccessBlock)successBlock
                          failureBlock:(FailureBlock)failureBlock
{
    postRequest(K_Url_ShareVideo, nil, successBlock, failureBlock);
}
/**
 早教列表
 */
-(void)bb_requestEarlyEdutionListWithSuccessBlock:(SuccessBlock)successBlock
                                     failureBlock:(FailureBlock)failureBlock
{
    NSString *timestampStr = [NSDate bb_strFromTimestamp];
    NSString *nonceStr = [NSString pp_randomStr];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSMutableString *signatureStr = [[NSMutableString alloc]initWithString:KGCSDad_AppId];
    [signatureStr appendString:KGCSDad_Secret];
    [signatureStr appendString:[NSString stringWithFormat:@"%@",timestampStr]];
    NSString *signatureString = [NSString pp_sha1:signatureStr];
    [param setValue:signatureString forKey:@"signature"];
    [param setValue:KGCSDad_AppId forKey:@"app_id"];
    [param setValue:[UIDevice pp_UUID] forKey:@"device_id"];
    [param setValue:nonceStr forKey:@"nonce"];
    [param setValue:timestampStr forKey:@"timestamp"];
    [param setValue:@"1" forKey:@"chapter"];
    [param setValue:@"1" forKey:@"verbose"];
    postRequestGCSDad(K_Url_MusicList, param, successBlock, failureBlock);
    
}
/**
 早教列表（二级分类）
 */
-(void)bb_requestEarlyEdutionSubListWithCategoryIds:(NSArray *)categoryIds
                                       SuccessBlock:(SuccessBlock)successBlock
                                       failureBlock:(FailureBlock)failureBlock
{
    NSString *timestampStr = [NSDate bb_strFromTimestamp];
    NSString *nonceStr = [NSString pp_randomStr];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSMutableString *signatureStr = [[NSMutableString alloc]initWithString:KGCSDad_AppId];
    [signatureStr appendString:KGCSDad_Secret];
    [signatureStr appendString:[NSString stringWithFormat:@"%@",timestampStr]];
    NSString *signatureString = [NSString pp_sha1:signatureStr];
    [param setValue:signatureString forKey:@"signature"];
    [param setValue:KGCSDad_AppId forKey:@"app_id"];
    [param setValue:[UIDevice pp_UUID] forKey:@"device_id"];
    [param setValue:nonceStr forKey:@"nonce"];
    [param setValue:timestampStr forKey:@"timestamp"];
    [param setValue:@"1" forKey:@"chapter"];
    [param setValue:@"1" forKey:@"verbose"];
//    [param setValue:@"3" forKey:@"offset"];
    NSMutableString *str = [[NSMutableString alloc]initWithString:@"["];
    for (int i = 0; i < categoryIds.count-1; i++) {
        [str appendFormat:@"%@,",categoryIds[i]];
    }
    [str appendFormat:@"%@]",[categoryIds lastObject]];
    [param setValue:str forKey:@"cat_ids"];
    postRequestGCSDad(K_Url_MusicList, param, successBlock, failureBlock);
}

/**
 子类下对应的music列表
 */
-(void)bb_requestEarlyEdutionSubListListWithCategoryId:(NSString *)categoryId
                                          successBlock:(SuccessBlock)successBlock
                                          failureBlock:(FailureBlock)failureBlock
{
    [self bb_requestEarlyEdutionSubListWithCategoryIds:@[categoryId] SuccessBlock:successBlock failureBlock:failureBlock];
}
/**
 早教热门推荐
 */
-(void)bb_requestEarlyEdutionHotRecommendWithSuccessBlock:(SuccessBlock)successBlock
                                             failureBlock:(FailureBlock)failureBlock
{
    NSString *timestampStr = [NSDate bb_strFromTimestamp];
    NSString *nonceStr = [NSString pp_randomStr];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSMutableString *signatureStr = [[NSMutableString alloc]initWithString:KGCSDad_AppId];
    [signatureStr appendString:KGCSDad_Secret];
    [signatureStr appendString:[NSString stringWithFormat:@"%@",timestampStr]];
    NSString *signatureString = [NSString pp_sha1:signatureStr];
    [param setValue:signatureString forKey:@"signature"];
    [param setValue:KGCSDad_AppId forKey:@"app_id"];
    [param setValue:[UIDevice pp_UUID] forKey:@"device_id"];
    [param setValue:nonceStr forKey:@"nonce"];
    [param setValue:timestampStr forKey:@"timestamp"];
    [param setValue:@"hot" forKey:@"listtype"];
    [param setValue:@"1" forKey:@"chapter"];
    [param setValue:@"1" forKey:@"verbose"];
    postRequestGCSDad(K_Url_MusicList, param, successBlock, failureBlock);
}

-(void)bb_requestRefreshTokenWithSuccessBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock
{
    NSString *timestampStr = [NSDate bb_strFromTimestamp];
    NSString *nonceStr = [NSString pp_randomStr];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSMutableString *signatureStr = [[NSMutableString alloc]initWithString:KGCSDad_AppId];
    [signatureStr appendString:KGCSDad_Secret];
    [signatureStr appendString:[NSString stringWithFormat:@"%@",timestampStr]];
    NSString *signatureString = [NSString pp_sha1:signatureStr];
    [param setValue:signatureString forKey:@"signature"];
    [param setValue:KGCSDad_AppId forKey:@"app_id"];
    [param setValue:[UIDevice pp_UUID] forKey:@"device_id"];
    [param setValue:nonceStr forKey:@"nonce"];
    [param setValue:timestampStr forKey:@"timestamp"];
    postRequestGCSDad(K_Url_Refresh_Token, param, successBlock, failureBlock);
}


/**
 阈值设定
 @param deviceType 设备类型  0 室内外温度传感器数据
 1  声音传感器数据（哭闹）
 2 体温传感器 （额头传感器，腋下传感器）
 3 湿度传感器（有没有尿湿）
 4 踢被传感器数据
 @param minValue 最小值
 @param maxValue 最大值
 @param deviceId 设备id
 */
-(void)SetThresholdValueDeviceType:(NSString *)deviceType minValue:(NSString *)minValue maxValue:(NSString *)maxValue deviceId:(NSString *)deviceId successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    
    deviceId = deviceId == nil ? @"":deviceId;
    
    NSDictionary *param = @{
                            @"deviceType":deviceType,
                            @"minVal":minValue,
                            @"maxVal":maxValue,
                            @"deviceId":deviceId
                            };
    postRequest(K_Url_SetThreshold, param, successBlock, failureBlock);
    
}
/*  获取阈值  */
-(void)GetThresholdValueDeviceType:(NSString *)deviceType deviceId:(NSString *)deviceId successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    
    NSDictionary *param = @{
                            @"deviceType":deviceType,
                            @"deviceId":deviceId
                            };
    getRequest(K_Url_GetThreshold, param, successBlock, failureBlock);
    
}

/*  获取曲线数据  */
-(void)GetStatisticsDataDeviceType:(NSString *)deviceType deviceId:(NSString *)deviceId successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",K_Url_GetSensorData,deviceId];
    
    NSDictionary * param = @{
                            @"deviceType":deviceType,
                            };
    getRequest(urlStr, param, successBlock, failureBlock);

}
/*  绑定设备  */
-(void)applyBindDeviceId:(NSString *)deviceId successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    
    NSString * urlStr = [NSString stringWithFormat:@"%@%@",K_Url_bindDevice,deviceId];
    
    getRequest(urlStr, nil, successBlock, failureBlock);
    
}


@end
