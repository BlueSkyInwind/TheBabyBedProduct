//
//  BBLoginAndRegistViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBLoginAndRegistViewController.h"
#import "BBLoginRegistHeaderView.h"
#import "BBLoginView.h"
#import "BBRegistView.h"
#import "BBForgetPasswordViewController.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import "BaseResultModel.h"
#import "JKCountDownButton.h"
#import "BBEditInformationViewController.h"

@interface BBLoginAndRegistViewController ()
{
    BOOL _currentIsLogin;
    BOOL _isAgreeRegistProtocol;
}
@property(nonatomic,strong) BBLoginRegistHeaderView *headerV;
@property(nonatomic,strong) BBLoginView *loginV;
@property(nonatomic,strong) BBRegistView *registV;
@end

@implementation BBLoginAndRegistViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
//-(void)loadView
//{
//    UIScrollView *scrollV = [UIScrollView new];
//    self.view = scrollV;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _currentIsLogin = YES;
    _isAgreeRegistProtocol = YES; //默认同意协议
    [self creatUI];
}
-(void)creatUI
{
    [self creatHeaderVUI];
    
    //登录板块
    self.loginV = [[BBLoginView alloc]initWithFrame:CGRectMake(0, 200, _k_w, _k_h-200)];
    [self.view addSubview:self.loginV];
    
    BBWeakSelf(self)
    self.loginV.forgetPasswordBlock = ^{
        //
        DLog(@"点击忘记密码");
        BBStrongSelf(self)
        [self.view endEditing:YES];
        BBForgetPasswordViewController *forgerPasswordVC = [[BBForgetPasswordViewController alloc]init];
        [self.navigationController pushViewController:forgerPasswordVC animated:YES];
    };
    self.loginV.loginBlock = ^(NSString *phone, NSString *password) {
        DLog(@"点登录按钮 %@--%@",phone,password);
        BBStrongSelf(self)
        [self.view endEditing:YES];
        [self goToLoginWithPhoneNo:phone password:password];
    };
    self.loginV.thirdLoginBlock = ^(BBLoginType type) {
        DLog(@"第三方登录方式 %ld",(long)type);
        BBStrongSelf(self)
        [self.view endEditing:YES];
        [self goToThirdWithType:type];
    };
    
    //注册板块
    self.registV = [[BBRegistView alloc]initWithFrame:CGRectMake(_k_w, 200, _k_w, _k_h-200)];
    [self.view addSubview:self.registV];
    
    self.registV.getCodeBlock = ^(NSString *phone,JKCountDownButton *countDownBT) {
        BBStrongSelf(self)
        [self getCodeRequest:phone countDownBt:countDownBT];
    };
    
    self.registV.registBlock = ^(NSString *phone, NSString *code, NSString *password) {
        BBStrongSelf(self)
        [self.view endEditing:YES];
        [self registRequest:phone code:code password:password];
    };
    
    self.registV.agreeProtocolBlock = ^(BOOL isAgree) {
        BBStrongSelf(self)
        _isAgreeRegistProtocol = isAgree;
        [self.view endEditing:YES];
    };
    self.registV.clickProtocolBlock = ^{
        BBStrongSelf(self)
        [self.view endEditing:YES];
    };
    
}
#pragma mark --- 获取验证码请求
-(void)getCodeRequest:(NSString *)phone countDownBt:(JKCountDownButton *)countDownBt
{
//    [QMUITips showSucceed:@"注册成功"];
//    BBEditInformationViewController *editInfoVC = [[BBEditInformationViewController alloc]init];
//    editInfoVC.comesFrom = BBEditInformationVCComesFromRegistSuccess;
//    editInfoVC.skipBlock = ^{
//        //注册成功，再次输入账号密码登录
//        [self changLoginOrRegist:YES];
//    };
//    [self.navigationController pushViewController:editInfoVC animated:YES];
    
    [BBRequestTool bb_requestGetCodeWithPhone:phone codeType:BBGetCodeTypeRegist successBlock:^(EnumServerStatus status, id object) {
        BBLoginResultModel *getCodeResultM = [BBLoginResultModel mj_objectWithKeyValues:object];
        if (getCodeResultM.code == 0) {
            [QMUITips showSucceed:@"验证码发送成功"];
            countDownBt.enabled = NO;
            [countDownBt startCountDownWithSecond:60];
        }else{
            [QMUITips showError:@"验证码发送失败"];
            [countDownBt stopCountDown];
            countDownBt.enabled = YES;
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        [QMUITips showError:@"验证码发送失败"];
        [countDownBt stopCountDown];
        countDownBt.enabled = YES;
    }];
}

#pragma mark --- 注册点击事件
-(void)registRequest:(NSString *)phone code:(NSString *)code password:(NSString *)password
{
    if (!_isAgreeRegistProtocol) {
        [QMUITips showWithText:@"您先同意《软件注册协议》" inView:self.view hideAfterDelay:1.5];
        return;
    }
    
    if (![phone bb_isPhoneNumber]) {
        [QMUITips showError:@"请输入正确手机号" inView:self.view hideAfterDelay:1.5];
        return;
    }
    
    [BBRequestTool bb_requestRegistWithPhone:phone code:code password:password successBlock:^(EnumServerStatus status, id object) {
        BBLoginResultModel *registRestltM = [BBLoginResultModel mj_objectWithKeyValues:object];
        if (registRestltM.code == 0) {
            [QMUITips showSucceed:@"注册成功"];
            BBEditInformationViewController *editInfoVC = [[BBEditInformationViewController alloc]init];
            editInfoVC.comesFrom = BBEditInformationVCComesFromRegistSuccess;
            editInfoVC.skipBlock = ^{
                //注册成功，再次输入账号密码登录
                [self changLoginOrRegist:YES];
            };
            [self.navigationController pushViewController:editInfoVC animated:YES];
        }else{
            if (registRestltM.msg.length > 0) {
                [QMUITips showError:registRestltM.msg inView:self.view hideAfterDelay:1.5];
                return ;
            }else{
                [QMUITips showError:@"注册失败" inView:self.view hideAfterDelay:1.5];
                return ;
            }
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        [QMUITips showError:@"注册失败" inView:self.view hideAfterDelay:1.5];
        return ;
    }];
    
}
-(void)goToLoginWithPhoneNo:(NSString *)phoneNo password:(NSString *)password
{
    if (![phoneNo bb_isPhoneNumber]) {
        [QMUITips showError:@"请填写正确手机号"];
        return;
    }
    //账号密码登录
    [BBRequestTool bb_requestLoginWithPhone:phoneNo password:password loginType:BBLoginTypeDefault uid:nil openid:nil successBlock:^(EnumServerStatus status, id object) {
        NSLog(@"success %@",object);
        BBLoginResultModel *loginResultM = [BBLoginResultModel mj_objectWithKeyValues:object];
        if (loginResultM.code == 0) {
            
            BBUser *user = loginResultM.data;
            user.password = password;
            [BBUser bb_saveUser:user];
            
            //登录成功拉用户信息
            [self getUserInfo];
            
        }else{
            [QMUITips showWithText:loginResultM.msg inView:self.view hideAfterDelay:1.5];
            return ;
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"filed %@",object);
        [QMUITips showWithText:@"登录失败" inView:self.view hideAfterDelay:1.2];
        return ;
    }];
}
#pragma mark --- 登录成功后要先获取用户信息
-(void)getUserInfo
{
    [BBRequestTool bb_requestGetUserInfoWithSuccessBlock:^(EnumServerStatus status, id object) {
        NSDictionary *userInfoResultDict = (NSDictionary *)object;
        int resultCode = [[userInfoResultDict objectForKey:@"code"] intValue];
        NSString *resultMsg = [userInfoResultDict objectForKey:@"msg"];
        
        
        if (resultCode == 0) {
            [QMUITips showSucceed:@"登录成功"];

            NSDictionary *userInfoDict = [userInfoResultDict objectForKey:@"data"];
            
            //此处多说一点，因为登录的时候已经保存了一个
            BBUser *user = [BBUser bb_getUser];
            user.hasLogined = YES;

            for (NSString *dictKey in userInfoDict.allKeys) {
                if ([user.properties containsObject:dictKey]) {
                    [user setValue:[userInfoDict objectForKey:dictKey] forKey:dictKey];
                }
            }
            
            [BBUser bb_saveUser:user];
            
            if (self.BBLoginOrRegistResultBlock) {
                self.BBLoginOrRegistResultBlock(YES);
            }
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }else{
            [QMUITips showWithText:resultMsg inView:self.view hideAfterDelay:1.5];
            return ;
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        [QMUITips showWithText:@"获取用户信息失败" inView:self.view hideAfterDelay:1.2];
        return ;
    }];
}
-(void)goToThirdWithType:(BBLoginType)type
{
 
//    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ
//                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
//
//                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
//                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
//                                       associateHandler (user.uid, user, user);
//                                       NSLog(@"dd%@",user.rawData);
//                                       NSLog(@"dd%@",user.credential);
//
//                                   }
//                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
//
//                                    if (state == SSDKResponseStateSuccess){
//
//                                    }
//
//                                }];
    
    if (type == BBLoginTypeWeiXin) {
        [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
            //成功走这里
            DLog(@"233");
#warning to
            NSString *str = [NSString stringWithFormat:@"%@ 已同意微信登录",user.nickname];
            [QMUITips showSucceed:str inView:self.view hideAfterDelay:2];
        } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
            //失败走这里
            DLog(@"微信3登录结果 %lu",(unsigned long)state);
            NSString *resultStr = @"微信登录授权失败";
            if (state == SSDKResponseStateCancel) {
                resultStr = @"您已取消微信登录";
            }
            [QMUITips showWithText:resultStr inView:self.view hideAfterDelay:2];
        }];
    }
 
}
-(void)creatHeaderVUI
{
    self.headerV = [[BBLoginRegistHeaderView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 200)];
    [self.view addSubview:self.headerV];
    BBWeakSelf(self)
    self.headerV.closeBlock = ^{
        BBStrongSelf(self)
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    self.headerV.LoginRegistSelectedBlock = ^(BOOL isLogin) {
        BBStrongSelf(self)
        [self changLoginOrRegist:isLogin];
    };
}
-(void)changLoginOrRegist:(BOOL)isLogin
{
    if (isLogin) {
        if (_currentIsLogin) {
            return;
        }else{
            _currentIsLogin = YES;
            [self.headerV loginAction];
            [UIView animateWithDuration:0.20 delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
                self.loginV.frame = CGRectMake(0, 200, _k_w, _k_h-200);
                self.registV.frame = CGRectMake(_k_w, 200, _k_w, _k_h-200);
            } completion:^(BOOL finished) {
                
            }];
        }
        
    }else{
        if (!_currentIsLogin) {
            return;
        }else{
            _currentIsLogin = NO;
            [UIView animateWithDuration:0.20 delay:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
                self.loginV.frame = CGRectMake(-_k_w, 200, _k_w, _k_h-200);
                self.registV.frame = CGRectMake(0, 200, _k_w, _k_h-200);
            } completion:^(BOOL finished) {
                
            }];
        }
        
    }
}


@end
