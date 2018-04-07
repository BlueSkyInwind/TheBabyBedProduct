//
//  DeviceConnectingViewController.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "DeviceConnectingViewController.h"
#import "DeviceConnectAnimationView.h"
#import "BLEPairingViewController.h"

@interface DeviceConnectingViewController ()
/* <#Description#>*/
@property(nonatomic,strong)DeviceConnectAnimationView * animationView;

@end

@implementation DeviceConnectingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设备链接";
    [self addBackItem];

    [self addConnectAnimationView];
    

}
-(void)addConnectAnimationView{
    
    _animationView = [[DeviceConnectAnimationView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h - 300)];
    [self.view addSubview:_animationView];
    [_animationView beginAnimation];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self showConnectSuccessPopView];
    [self showConnectFailPopView];
}

-(void)showConnectSuccessPopView{
    
    [[GlobalAlertViewManager shareInstance]promptsPopViewWithtitle:@"连接成功" content:@"不错过告警消息请关注公众号：xxxxxx" cancelTitle:@"进入首页" sureTitle:@"去关注" completion:^(NSInteger index) {
        if (index == 0) {
            //进去首页
            [self.navigationController popToRootViewControllerAnimated:true];
        }else if (index == 1){
            //关注公众号
            
        }
    }];
    
}

-(void)showConnectFailPopView{
    
    [[GlobalAlertViewManager shareInstance]promptsPopViewWithtitle:@"连接失败" content:@"请确保您的Wi-Fi密码输入正确" cancelTitle:@"蓝牙连接" sureTitle:@"再试一次" completion:^(NSInteger index) {
        if (index == 0) {
            //蓝牙连接
            BLEPairingViewController * blePairingVC = [[BLEPairingViewController alloc]init];
            [self.navigationController pushViewController:blePairingVC animated:true];
        }else if (index == 1){
            //再试一次
            
        }
    }];
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
