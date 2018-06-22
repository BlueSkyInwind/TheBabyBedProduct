//
//  BBInviteFriendsViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBInviteFriendsViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface BBInviteFriendsViewController ()

@end

@implementation BBInviteFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_color_vcBg;
    self.title = @"邀请好友";
    
    [self createUI];
}
-(void)createUI
{
    UILabel *recommendLB = [[UILabel alloc]initWithFrame:CGRectMake(60, 120, _k_w-60*2, 150)];
    [self.view addSubview:recommendLB];
    NSString *inviteStr = @"邀请码：";
#warning todo pp604 
    NSString *inviteCode = @"789605";
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@\n\n家人接受邀请后可查看宝宝状态，收到宝宝通知消息，一起守护宝宝健康",inviteStr,inviteCode]];
    [mutStr pp_setFont:[UIFont systemFontOfSize:17]];
    [mutStr pp_setFont:[UIFont systemFontOfSize:20] range:[mutStr.string rangeOfString:inviteStr]];
    
    [mutStr pp_setKern:@1];
    [mutStr pp_setColor:kUIColorFromRGB(0xff4d4d) range:[mutStr.string rangeOfString:inviteCode]];
    recommendLB.attributedText = mutStr;
    recommendLB.numberOfLines = 0;
    recommendLB.textAlignment = NSTextAlignmentCenter;
    
    QMUIFillButton *wxBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:wxBT];
    wxBT.titleLabel.font = [UIFont systemFontOfSize:25];
    wxBT.titleTextColor = [UIColor whiteColor];
    wxBT.fillColor = rgb(31, 203, 42, 1);
    wxBT.cornerRadius = 32;
    [wxBT setTitle:@"微信邀请" forState:UIControlStateNormal];
    [wxBT addTarget:self action:@selector(wxInviteAction) forControlEvents:UIControlEventTouchUpInside];
    
    QMUIFillButton *dxBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:dxBT];
    dxBT.titleLabel.font = [UIFont systemFontOfSize:25];
    dxBT.titleTextColor = [UIColor whiteColor];
    dxBT.fillColor = rgb(77, 206, 227, 1);
    dxBT.cornerRadius = 32;
    [dxBT setTitle:@"短信邀请" forState:UIControlStateNormal];
    [dxBT addTarget:self action:@selector(dxInviteAction) forControlEvents:UIControlEventTouchUpInside];
    
    dxBT.frame = CGRectMake(120, _k_h-PPDevice_realBottomVH(60)-64, _k_w-240, 64);
    wxBT.frame = CGRectMake(120, dxBT.top-15-64, dxBT.width, dxBT.height);
}
-(void)wxInviteAction
{
    [self toShareWithPlatformType:SSDKPlatformSubTypeWechatSession];
}

-(void)dxInviteAction
{
    [self toShareWithPlatformType:SSDKPlatformTypeSMS];

}
-(void)toShareWithPlatformType:(SSDKPlatformType)platformType
{
    
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
    [shareParams SSDKSetupShareParamsByText:@"点击下面的链接可注册并绑定婴儿床"
                                     images:@"http://img1.imgtn.bdimg.com/it/u=407406776,3648841261&fm=214&gp=0.jpg"
                                        url:[NSURL URLWithString:[NSString stringWithFormat:@"%@/h5/toYdaShare",K_Url_BBBase]]
                                      title:@"婴儿香邀请绑定"
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
    }];
}
@end