//
//  DeviceConnectingViewController.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "DeviceConnectingViewController.h"
#import "DeviceConnectAnimationView.h"
#import <JMAirKiss/JMAirKiss.h>
#import "BLEDeviceStatusViewController.h"
#import "BLEScanConnectViewController.h"

@interface DeviceConnectingViewController ()
/* <#Description#>*/
@property(nonatomic,strong)DeviceConnectAnimationView * animationView;
/**<#Description#>*/
@property (nonatomic,strong)JMAirKissConnection  * airKissConnection;
@end

@implementation DeviceConnectingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设备链接";
    [self addBackItem];
    [self connectAirkiss];
    
}
-(void)connectAirkiss{
    
    if (self.airKissConnection != nil) {
        return;
    }
    __weak typeof (self) weakSelf = self;
    [self addConnectAnimationView];
    self.airKissConnection = [[JMAirKissConnection alloc]init];
    self.airKissConnection.connectionSuccess = ^() {
        [weakSelf dismissAnimationView];
        [weakSelf showConnectSuccessPopView];
    };
    self.airKissConnection.connectionFailure = ^() {
        [weakSelf dismissAnimationView];
        [weakSelf showConnectFailPopView];
    };
    [self.airKissConnection connectAirKissWithSSID:_ssid
                                          password:_wifiPassword];
}

-(void)addConnectAnimationView{
    
    _animationView = [[DeviceConnectAnimationView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h - 300)];
    [self.view addSubview:_animationView];
    [_animationView beginAnimation];
    
}

-(void)dismissAnimationView{
    
    [UIView animateWithDuration:0.2 animations:^{
        _animationView.alpha = 0;
    } completion:^(BOOL finished) {
        [_animationView removeFromSuperview];
        _animationView = nil;
    }];
}

-(void)showConnectSuccessPopView{
    
    [[GlobalAlertViewManager shareInstance]promptsPopViewWithtitle:@"连接成功" content:@"不错过告警消息请关注公众号：xxxxxx" cancelTitle:@"进入首页" sureTitle:@"去关注" completion:^(NSInteger index) {
        if (index == 0) {
            //进去首页
            __weak typeof (self) weakSelf = self;
            [self applyBindDevice:_scanId finish:^(BOOL isSuccess) {
                if (isSuccess){
                    [BBUser bb_getUser].deviceId = weakSelf.scanId;
                    [weakSelf.navigationController popToRootViewControllerAnimated:true];
                }
            }];
        }else if (index == 1){
            //关注公众号
            
        }
    }];
}

-(void)showConnectFailPopView{
    
    [[GlobalAlertViewManager shareInstance]promptsPopViewWithtitle:@"连接失败" content:@"请确保您的Wi-Fi密码输入正确" cancelTitle:@"蓝牙连接" sureTitle:@"再试一次" completion:^(NSInteger index) {
        if (index == 0) {
            //蓝牙连接
            [self SetTheBluetooth];
        }else if (index == 1){
            //再试一次
            [self.navigationController popViewControllerAnimated:true];
        }
    }];
}

-(void)SetTheBluetooth{
    BOOL isOpen = [[GlobalTool getContentWithKey:BLE_POWER_NOTIFI] boolValue];
    if (!isOpen) {
        BLEDeviceStatusViewController * statusVC = [[BLEDeviceStatusViewController alloc]init];
        [self.navigationController pushViewController:statusVC animated:true];
    }else{
        BLEScanConnectViewController * connectingVC = [[BLEScanConnectViewController alloc]init];
        [self.navigationController pushViewController:connectingVC animated:true];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)applyBindDevice:(NSString *)deviceId finish:(void(^)(BOOL isSuccess))finish{
    
    [BBRequestTool applyBindDeviceId:deviceId successBlock:^(EnumServerStatus status, id object) {
        BaseResultModel *resultM = [[BaseResultModel alloc] initWithDictionary:object error:nil];
        if (resultM.code == 0) {
            finish(true);
        }else{
            [QMUITips showWithText:resultM.msg inView:self.view hideAfterDelay:0.5];
            finish(false);
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        finish(false);
    }];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
