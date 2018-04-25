//
//  BLEDeviceStatusViewController.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/4/23.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BLEDeviceStatusViewController.h"
#import "GlobalPopView.h"
@interface BLEDeviceStatusViewController ()

@end

@implementation BLEDeviceStatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设备链接";
    [self addBackItem];
    [self SetTheBluetooth];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(SetTheBluetooth)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
}
-(void)SetTheBluetooth{
    
    BOOL isOpen = [[GlobalTool getContentWithKey:BLE_POWER_NOTIFI] boolValue];
    if (!isOpen) {
        [self showBLEOffStatusPopView];
    }else{
        
    }
}

-(void)showBLEOffStatusPopView{
    GlobalPopView * popView =  [GlobalPopView initWithTitle:nil superView:self.view content:@"请打开蓝牙扫描xx二维码" cancelTitle:@"取消" sureTitle:@"设置" clickcompletion:^(NSInteger index) {
        if (index == 0) {
            [self.navigationController popViewControllerAnimated:true];
        }else if (index == 1){
            //打开设置蓝牙页面
            [GlobalTool openSystemSetting:@"App-Prefs:root=Bluetooth"];
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
