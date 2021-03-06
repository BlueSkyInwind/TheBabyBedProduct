//
//  BBAccountNumberViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBAccountNumberViewController.h"
#import "BBAcountNumberListCell.h"
#import "BBModifyPasswordViewController.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>

@interface BBAccountNumberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *settings;
@property(nonatomic,strong) NSArray *accountNumbers;
@end

@implementation BBAccountNumberViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = k_color_vcBg;
    self.titleStr = @"账号设置";
    [self creatUI];
}
-(void)creatUI
{
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectMake(0, PPDevice_navBarHeight, _k_w, _k_h-PPDevice_navBarHeight) delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    
    UIView *fotterV = [[UIView alloc]init];
    self.tableView.tableFooterView = fotterV;
    
    UILabel *currentVersionLB = [UILabel bb_lbMakeWithSuperV:fotterV fontSize:14 alignment:NSTextAlignmentCenter textColor:k_color_515151];
    currentVersionLB.text = [NSString stringWithFormat:@"当前版本%@",[GlobalTool getAppVersion]];
    currentVersionLB.frame = CGRectMake(0, 0, _k_w, 20);
    
    if (BBUserHelpers.hasLogined) {
        QMUIFillButton *signOutBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
        [fotterV addSubview:signOutBT];
        signOutBT.titleLabel.font = [UIFont systemFontOfSize:18];
        signOutBT.fillColor = rgb(255, 236, 183, 1);
        signOutBT.titleTextColor = k_color_515151;
        [signOutBT setTitle:@"退出登录" forState:UIControlStateNormal];
        signOutBT.frame = CGRectMake(40, 20+5, _k_w-80, 44);
        [signOutBT addTarget:self action:@selector(signOutAction) forControlEvents:UIControlEventTouchUpInside];
        fotterV.frame = CGRectMake(0, 0, _k_w, 20+44+5);

    }else{
        fotterV.frame = CGRectMake(0, 0, _k_w, 20);
    }
}

-(void)signOutAction
{
    UIAlertController *alertC = [UIAlertController bb_alertControllerMakeForAlertCancelAndOKWithTitle:@"您真的要退出登录？" message:nil OKHandler:^(UIAlertAction *action) {
        
        //退出登录，只需要本地清空token即可
        BBUser *emptyUser = [[BBUser alloc]init];
        emptyUser.hasLogined = NO;  //保险起见，还是加上
        [BBUser bb_saveUser:emptyUser];
        
        [self.tableView reloadData];
        [QMUITips showLoading:@"您已退出登录" inView:self.view];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self presentViewController:alertC animated:YES completion:nil];
  
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.settings.count;
    }
    return self.accountNumbers.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 60;
    }
    return 100;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor clearColor];
    UILabel *recommenderLB = [UILabel bb_lbMakeWithSuperV:v fontSize:12 alignment:NSTextAlignmentCenter textColor:k_color_153153153];
    recommenderLB.textAlignment = NSTextAlignmentCenter;
    [v addSubview:recommenderLB];
    if (section == 0) {
        recommenderLB.frame = CGRectMake(0, 0, _k_w, 32);
        recommenderLB.text = @"设置以后可通过手机号加密登录";
    }else{
        recommenderLB.frame = CGRectMake(0, 0, _k_w, 36);
        recommenderLB.text = @"绑定微信账号更方便收到告警信息，快捷不错过";
    }
    return v;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBAcountNumberListCell *cell = [BBAcountNumberListCell bb_cellMakeWithTableView:tableView];
    if (indexPath.section == 0) {
        [cell setupCellWithTitle:self.settings[indexPath.row]];
    }else{
        [cell setupCellWithTitle:self.accountNumbers[indexPath.row]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            //登录密码
            BBModifyPasswordViewController *modigyPasswordVC = [[BBModifyPasswordViewController alloc]init];
            [self.navigationController pushViewController:modigyPasswordVC animated:YES];
        }
    }else{
        if (indexPath.row == 0) {
            if (!BBUserHelpers.hasWeiXinBinding) {
                [self bindinggWX];
            }
        }else if (indexPath.row == 1){
            if (!BBUserHelpers.hasQQBinding) {
                [self bindingQQ];
            }
        }else{
            if (!BBUserHelpers.hasWeiBoBinding) {
                [self bindingWB];
            }
        }
    }
}
-(void)bindinggWX
{
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeWechat onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        //成功走这里
        [QMUITips showSucceed:@"微信登录授权成功" inView:self.view hideAfterDelay:2];
        [self goToLoginWithLoginType:BBLoginTypeWeiXin uid:user.uid openid:user.uid];
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
-(void)bindingQQ
{
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
        //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
        NSLog(@"dd%@",user.rawData);
        NSLog(@"dd%@",user.credential);
        NSString *str = @"QQ登录授权成功";
        [QMUITips showSucceed:str inView:self.view hideAfterDelay:2];
        [self goToLoginWithLoginType:BBLoginTypeQQ uid:user.uid openid:user.uid];

    } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        //失败走这里
        DLog(@"QQ登录结果 %lu",(unsigned long)state);
        NSString *resultStr = @"QQ登录授权失败";
        if (state == SSDKResponseStateCancel) {
            resultStr = @"您已取消QQ登录";
        }
        [QMUITips showWithText:resultStr inView:self.view hideAfterDelay:2];
    }];

}
-(void)bindingWB
{
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeSinaWeibo onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
        //成功走这里
        NSString *str = @"微博登录授权成功";
        [QMUITips showSucceed:str inView:self.view hideAfterDelay:2];
        [self goToLoginWithLoginType:BBLoginTypeWeiBo uid:user.uid openid:user.uid];
    } onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
        //失败走这里
        DLog(@"微博登录结果 %lu",(unsigned long)state);
        NSString *resultStr = @"微博登录授权失败";
        if (state == SSDKResponseStateCancel) {
            resultStr = @"您已取消微博登录";
        }
        [QMUITips showWithText:resultStr inView:self.view hideAfterDelay:2];
    }];
}

-(void)goToLoginWithLoginType:(BBLoginType)loginType
                          uid:(NSString *)uid
                       openid:(NSString *)openid
{
    BBUser *user = [BBUser bb_getUser];
    NSString *phoneNo = user.username;
    NSString *password = user.password;
    
    [BBRequestTool bb_requestLoginWithPhone:phoneNo password:password loginType:loginType uid:uid openid:openid successBlock:^(EnumServerStatus status, id object) {
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
                if ([[user properties] containsObject:dictKey]) {
                    [user setValue:[userInfoDict objectForKey:dictKey] forKey:dictKey];
                }
            }
            
            [BBUser bb_saveUser:user];
            [self.tableView reloadData];
            
        }else{
            [QMUITips showWithText:resultMsg inView:self.view hideAfterDelay:1.5];
            return ;
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        [QMUITips showWithText:@"获取用户信息失败" inView:self.view hideAfterDelay:1.2];
        return ;
    }];
}


-(NSArray *)settings
{
    if (!_settings) {
        _settings = @[@"手机号码",@"登录密码"];
    }
    return _settings;
}
-(NSArray *)accountNumbers
{
    if (!_accountNumbers) {
        _accountNumbers = @[@"微信账号",@"QQ账号",@"微博账号"];
    }
    return _accountNumbers;
}

@end
