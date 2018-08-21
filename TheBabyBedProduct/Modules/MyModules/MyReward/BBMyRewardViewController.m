//
//  BBMyRewardViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/30.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//
//此处建议：可以考虑把分享的放到LWShareService处理，我还是老话，时间紧，就拷贝粘贴了！！！

#import "BBMyRewardViewController.h"
#import "LWShareService.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "BBSignInPopView.h"
#import "BBExchange.h"

@interface BBMyRewardViewController ()
{
    UILabel *_userNameMesLB;
    QMUIFillButton *_IntegralConvertBT;
    UILabel *_totalSignInLB;
    QMUIFillButton *_signInBT;
}
@end

@implementation BBMyRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = k_color_vcBg;
    
    self.titleStr = @"每日任务";
    [self creatUI];
    
}
-(void)creatUI
{
    CGFloat leftMargin = 10;
    CGFloat avatarImgW = 50;
    CGFloat totalH = 100;
    CGFloat avatarImgY = (totalH-avatarImgW)/2;
    
    CGFloat btW = 72;
    CGFloat btH = 34;
    CGFloat btY = (totalH-btH)/2;
    CGFloat btX = _k_w-leftMargin-btW;
    
    CGFloat lbW = btX-avatarImgW-leftMargin-5;
    CGFloat lbX = leftMargin+avatarImgW+5;
    
    UIView *userIntegralBgV = [[UIView alloc]initWithFrame:CGRectMake(0, PPDevice_navBarHeight+10, _k_w, 100)];
    [self.view addSubview:userIntegralBgV];
    userIntegralBgV.backgroundColor = [UIColor whiteColor];
    UIImageView *avatarImgV = [UIImageView bb_imgVMakeWithSuperV:userIntegralBgV imgName:@"touxianggg"];
    avatarImgV.frame = CGRectFlatMake(leftMargin, avatarImgY, avatarImgW, avatarImgW);
    
    UILabel *mesLB = [UILabel bb_lbMakeWithSuperV:userIntegralBgV fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    _userNameMesLB = mesLB;
    
    mesLB.frame = CGRectMake(lbX, avatarImgV.top+6, lbW, 30);
    QMUIFillButton *IntegralConvertBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    _IntegralConvertBT = IntegralConvertBT;
    [userIntegralBgV addSubview:IntegralConvertBT];
    IntegralConvertBT.frame = CGRectMake(btX, btY, btW, btH);
    IntegralConvertBT.titleLabel.font = [UIFont systemFontOfSize:15];
    IntegralConvertBT.titleTextColor = [UIColor whiteColor];
    IntegralConvertBT.cornerRadius = 6;
    [IntegralConvertBT setTitle:@"积分兑换" forState:UIControlStateNormal];
    [IntegralConvertBT addTarget:self action:@selector(IntegralConvertAction) forControlEvents:UIControlEventTouchUpInside];
    
    BBUser *user = [BBUser bb_getUser];
    [self updateUIWithUser:user];
    
    UILabel *recommenderLB = [UILabel bb_lbMakeWithSuperV:userIntegralBgV fontSize:12 alignment:NSTextAlignmentCenter textColor:k_color_153153153];
#warning pp605
    recommenderLB.text = @"1积分可兑换10分钟";
    recommenderLB.frame = CGRectFlatMake(0, 70, _k_w, 30);
    
    UIView *signInBgV = [[UIView alloc]initWithFrame:CGRectFlatMake(0, userIntegralBgV.bottom+10, _k_w, 70)];
    [self.view addSubview:signInBgV];
    signInBgV.backgroundColor = [UIColor whiteColor];
    
    CGFloat signInTotalH = 70;
    CGFloat calendarX = 20;
    CGFloat calendarY = (signInTotalH-calendarX)/2;
    CGFloat lbW1 = btX-calendarX*2-10;
    CGFloat lbX1 = calendarX*2+10;
    
    UIImageView *calendarImgV = [UIImageView bb_imgVMakeWithSuperV:signInBgV imgName:@"signin"];
    calendarImgV.frame = CGRectMake(calendarX, calendarY, calendarX, calendarX);
    
    UILabel *topLB = [UILabel bb_lbMakeWithSuperV:signInBgV fontSize:15 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    topLB.text = @"连续签到送积分";
    topLB.frame = CGRectMake(lbX1, 12, lbW1, 26);
    UILabel *bottomLB = [UILabel bb_lbMakeWithSuperV:signInBgV fontSize:13 alignment:NSTextAlignmentLeft textColor:k_color_153153153];
    _totalSignInLB = bottomLB;
    bottomLB.text = [NSString stringWithFormat:@"您已连续签到%ld天",(long)user.totalSignInDays];
    bottomLB.frame = CGRectMake(lbX1, topLB.bottom, lbW1, 20);
    
    QMUIFillButton *signInBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    _signInBT = signInBT;
    [signInBgV addSubview:signInBT];
    signInBT.frame = CGRectMake(btX, (signInTotalH-btH)/2, btW, btH);
    signInBT.titleLabel.font = [UIFont systemFontOfSize:15];
    
    signInBT.titleTextColor = [UIColor whiteColor];
    signInBT.cornerRadius = 6;
    if (BBUserHelpers.hasTodaySignIn) {
        [signInBT setTitle:@"已签到" forState:UIControlStateNormal];
        signInBT.fillColor = rgb(255, 155, 57, 0.5);
    }else{
        [signInBT setTitle:@"签到" forState:UIControlStateNormal];
        signInBT.fillColor = rgb(255, 155, 57, 1);
        [signInBT addTarget:self action:@selector(signInAction) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UIView *shareBgV = [[UIView alloc]initWithFrame:CGRectFlatMake(0, signInBgV.bottom+10, _k_w, 70)];
    [self.view addSubview:shareBgV];
    shareBgV.backgroundColor = [UIColor whiteColor];
    
    UIImageView *shareImgV = [UIImageView bb_imgVMakeWithSuperV:shareBgV imgName:@"share"];
    shareImgV.frame = CGRectMake(calendarX, calendarY, calendarX, calendarX);
    
    UILabel *topLB1 = [UILabel bb_lbMakeWithSuperV:shareBgV fontSize:15 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    topLB1.text = @"分享给好友赚观看分钟";
    topLB1.frame = CGRectMake(lbX1, 12, lbW1, 26);
    UILabel *bottomLB1 = [UILabel bb_lbMakeWithSuperV:shareBgV fontSize:13 alignment:NSTextAlignmentLeft textColor:k_color_153153153];
    bottomLB1.text = @"大片都在这里";
    bottomLB1.frame = CGRectMake(lbX1, topLB.bottom, lbW1, 20);
    
    QMUIFillButton *shareBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [shareBgV addSubview:shareBT];
    shareBT.frame = CGRectMake(btX, (signInTotalH-btH)/2, btW, btH);
    shareBT.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBT.fillColor = rgb(255, 155, 57, 1);
    shareBT.titleTextColor = [UIColor whiteColor];
    shareBT.cornerRadius = 6;
    [shareBT setTitle:@"分享" forState:UIControlStateNormal];
    [shareBT addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark --- 积分兑换
-(void)IntegralConvertAction
{
//    BBUser *user = [BBUser bb_getUser];
//    NSUInteger totalMinute = user.totalScore*10;
    NSString *title = [NSString stringWithFormat:@"是否将积分兑换为观看分钟"];
    UIAlertController *alertC = [UIAlertController bb_alertControllerMakeForAlertCancelAndOKWithTitle:title message:nil OKHandler:^(UIAlertAction *action) {
        [self exchangeAction];
    }];
    [self presentViewController:alertC animated:YES completion:nil];
}
-(void)exchangeAction
{
    [BBRequestTool bb_requestExchangeWithSuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"积分兑换 success %@",object);
        BBExchangeResult *result = [BBExchangeResult mj_objectWithKeyValues:object];
        if (result.code == 0) {
            BBExchange *exchange = result.data;
            NSString *curTimeStr = [NSString stringWithFormat:@"您已成功兑换%ld分钟观看视频时长",(long)exchange.curTime];
            [QMUITips showWithText:curTimeStr inView:self.view hideAfterDelay:2];
            
            BBUser *user = [BBUser bb_getUser];
            user.curTime = exchange.total_curTime;
            user.totalScore = 0;
            [BBUser bb_saveUser:user];
            
            [self updateUIWithUser:user];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"积分兑换 fail %@",object);
    }];
}

-(void)updateUIWithUser:(BBUser *)user
{
    NSString *messStr = @"";
    if (user.identity && [user.identity bb_isSafe]) {
        messStr = [NSString stringWithFormat:@"%@的%@   ",[user.nickName bb_safe], [user.identity bb_safe]];
    }else if (user.nickName && [user.nickName bb_isSafe]){
        messStr = [NSString stringWithFormat:@"%@   ",[user.nickName bb_safe]];
    }else{
        messStr = @"";
    }
    _userNameMesLB.text = [NSString stringWithFormat:@"%@%lu积分",messStr,(unsigned long)user.totalScore];
    
    if (user.totalScore > 0) {
        _IntegralConvertBT.fillColor = rgb(255, 155, 57, 1);
        _IntegralConvertBT.userInteractionEnabled = YES;
    }else{
        _IntegralConvertBT.fillColor = rgb(153, 153, 153, 1);
        _IntegralConvertBT.userInteractionEnabled = NO;
    }
}
-(void)signInAction
{
    BBUser *user = [BBUser bb_getUser];
    
    BBSignInPopView *signInPopV = [BBSignInPopView signInPopView];
    BBWeakSelf(signInPopV)
    signInPopV.signInBlock = ^{
        [BBRequestTool bb_requestSignInWithSuccessBlock:^(EnumServerStatus status, id object) {
            NSLog(@"签到成功 %@",object);
            BBStrongSelf(signInPopV)
            NSDictionary *result = (NSDictionary *)object;
            if ([result.allKeys containsObject:@"msg"]) {
                NSString *msg = [result objectForKey:@"msg"];
                if ([msg containsString:@"已签到"] || [msg containsString:@"请求成功"]) {
                    [signInPopV signInSuccess];
                    user.latestSignInDate = [NSDate bb_todayStr];
                    [BBUser bb_saveUser:user];
                    
                    //刷新界面
                    [self refeshUI];
                }
            }
        } failureBlock:^(EnumServerStatus status, id object) {
            [QMUITips showInfo:@"签到失败"];
        }];
    };
    
    [signInPopV show];
}
-(void)shareAction
{
    [LWShareService shared].shareBtnClickBlock = ^(NSIndexPath *index) {
        [self toShareWithIndexpath:index];
    };
    
    [[LWShareService shared] showInViewController:self];
    
}
-(void)toShareWithIndexpath:(NSIndexPath *)indexPath
{
    SSDKPlatformType platformType = SSDKPlatformSubTypeQQFriend;
    if (indexPath.item == 1) {
        platformType = SSDKPlatformSubTypeWechatTimeline;
    }else if (indexPath.item == 2){
        platformType = SSDKPlatformSubTypeWechatSession;
    }else if (indexPath.item == 3){
        platformType = SSDKPlatformTypeSinaWeibo;
    }
    
    /*
     
     String msg = "点击下面的链接可注册并绑定婴儿床:" + Constants.HOST_SHARE + "h5/inv/" + GApplication.getInstance().userdb.getUserInfo().getId() + "?invCode=" + code;
     短信邀请绑定的H5链接
     
     ShareUtil.getInstance().share(this, "婴儿香邀请绑定", "点击下面的链接可注册并绑定婴儿床", "http://img1.imgtn.bdimg.com/it/u=407406776,3648841261&fm=214&gp=0.jpg",url );
     分享邀请绑定的H5链接
     
     ShareUtil.getInstance().share(this, "每日任务", "分享好友赚积分", "http://img1.imgtn.bdimg.com/it/u=407406776,3648841261&fm=214&gp=0.jpg", Constants.HOST_SHARE+"h5/toYdaShare");
     每日任务赚积分的H5链接
     @PPAbner
     */
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"分享好友赚积分"
                                     images:@"http://img1.imgtn.bdimg.com/it/u=407406776,3648841261&fm=214&gp=0.jpg"
                                        url:[NSURL URLWithString:[NSString stringWithFormat:@"%@/h5/toYdaShare",K_Url_BBBase]]
                                      title:@"每日任务"
                                       type:SSDKContentTypeAuto];
    //有的平台要客户端分享需要加此方法，例如微博
    [shareParams SSDKEnableUseClientShare];
    
    [ShareSDK share:platformType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        DLog(@"微信好友分享结果 %lu",(unsigned long)state);
        NSString *shareResultStr = @"";
        if (state == SSDKResponseStateSuccess) {
            shareResultStr = @"分享成功";
        }else if (state == SSDKResponseStateFail){
            shareResultStr = @"分享失败";
        }else if (state == SSDKResponseStateCancel){
            shareResultStr = @"您取消了分享";
        }
        if (shareResultStr.length > 0) {
            [QMUITips showWithText:shareResultStr inView:self.view hideAfterDelay:1.5];
        }
        
        [LWShareServices hidden];
    }];
}
-(void)refeshUI
{
    [_signInBT setTitle:@"已签到" forState:UIControlStateNormal];
    _signInBT.fillColor = rgb(255, 155, 57, 0.5);
    BBUser *user = [BBUser bb_getUser];
    _totalSignInLB.text = [NSString stringWithFormat:@"您已连续签到%ld天",(long)(user.totalSignInDays+1)];
    
    [BBRequestTool bb_requestGetUserInfoWithSuccessBlock:^(EnumServerStatus status, id object) {
        NSDictionary *userInfoResultDict = (NSDictionary *)object;
        int resultCode = [[userInfoResultDict objectForKey:@"code"] intValue];
        
        if (resultCode == 0) {
            NSDictionary *userInfoDict = [userInfoResultDict objectForKey:@"data"];
            
            BBUser *user = [BBUser bb_getUser];
            for (NSString *dictKey in userInfoDict.allKeys) {
                if ([[user properties] containsObject:dictKey]) {
                    [user setValue:[userInfoDict objectForKey:dictKey] forKey:dictKey];
                }
            }
            [BBUser bb_saveUser:user];
            _userNameMesLB.text = [NSString stringWithFormat:@"%@   %lu积分",[user.username bb_safe],(unsigned long)user.totalScore];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
       
    }];
}

@end
