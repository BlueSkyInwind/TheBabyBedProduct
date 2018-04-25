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
@interface BBMyRewardViewController ()

@end

@implementation BBMyRewardViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = k_color_vcBg;
    
    self.title = @"任务奖励";
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
    
    UIView *userIntegralBgV = [[UIView alloc]initWithFrame:CGRectMake(0, 64+10, _k_w, 100)];
    [self.view addSubview:userIntegralBgV];
    userIntegralBgV.backgroundColor = [UIColor whiteColor];
    UIImageView *avatarImgV = [UIImageView bb_imgVMakeWithSuperV:userIntegralBgV imgName:@"touxianggg"];
    avatarImgV.frame = CGRectFlatMake(leftMargin, avatarImgY, avatarImgW, avatarImgW);
    
    BBUser *user = [BBUser bb_getUser];
    UILabel *mesLB = [UILabel bb_lbMakeWithSuperV:userIntegralBgV fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    mesLB.text = [NSString stringWithFormat:@"%@   %lu积分",[user.username bb_safe],(unsigned long)user.totalScore];
    
    mesLB.frame = CGRectMake(lbX, avatarImgV.top+6, lbW, 30);
    QMUIFillButton *IntegralConvertBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [userIntegralBgV addSubview:IntegralConvertBT];
    IntegralConvertBT.frame = CGRectMake(btX, btY, btW, btH);
    IntegralConvertBT.titleLabel.font = [UIFont systemFontOfSize:15];
    if (user.totalScore > 0) {
        IntegralConvertBT.fillColor = rgb(255, 155, 57, 1);
        IntegralConvertBT.userInteractionEnabled = YES;
    }else{
        IntegralConvertBT.fillColor = rgb(153, 153, 153, 1);
        IntegralConvertBT.userInteractionEnabled = NO;
    }
    IntegralConvertBT.titleTextColor = [UIColor whiteColor];
    IntegralConvertBT.cornerRadius = 6;
    [IntegralConvertBT setTitle:@"积分兑换" forState:UIControlStateNormal];
    [IntegralConvertBT addTarget:self action:@selector(IntegralConvertAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *recommenderLB = [UILabel bb_lbMakeWithSuperV:userIntegralBgV fontSize:12 alignment:NSTextAlignmentCenter textColor:k_color_153153153];
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
    bottomLB.text = @"您已连续签到2天";
    bottomLB.frame = CGRectMake(lbX1, topLB.bottom, lbW1, 20);
    
    QMUIFillButton *signInBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [signInBgV addSubview:signInBT];
    signInBT.frame = CGRectMake(btX, (signInTotalH-btH)/2, btW, btH);
    signInBT.titleLabel.font = [UIFont systemFontOfSize:15];
    signInBT.fillColor = rgb(255, 155, 57, 1);
    signInBT.titleTextColor = [UIColor whiteColor];
    signInBT.cornerRadius = 6;
    [signInBT setTitle:@"签到" forState:UIControlStateNormal];
    [signInBT addTarget:self action:@selector(signInAction) forControlEvents:UIControlEventTouchUpInside];
    
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
    BBUser *user = [BBUser bb_getUser];
    NSUInteger totalMinute = user.totalScore*10;
    NSString *title = [NSString stringWithFormat:@"是否将积分兑换为%lu观看分钟",(unsigned long)totalMinute];
    UIAlertController *alertC = [UIAlertController bb_alertControllerMakeForAlertCancelAndOKWithTitle:title message:nil OKHandler:^(UIAlertAction *action) {
        [self exchangeAction];
    }];
    [self presentViewController:alertC animated:YES completion:nil];
}
-(void)exchangeAction
{
    [BBRequestTool bb_requestExchangeWithSuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"积分兑换 success %@",object);
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"积分兑换 fail %@",object);
    }];
}
-(void)signInAction
{
#warning todo 签到
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
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:nil
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"分享标题"
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

@end
