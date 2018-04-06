//
//  NetWorkRequestManager+BBRequest.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/6.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "NetWorkRequestManager.h"

@interface NetWorkRequestManager (BBRequest)

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
                   failureBlock:(FailureBlock)failureBlock;
@end
