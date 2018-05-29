//
//  ConfigurationWifiViewController.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ConfigurationWifiViewController.h"
#import "DeviceConnectingViewController.h"
#import "JMAirKissShareTools.h"
#import "BLEDeviceStatusViewController.h"

@interface ConfigurationWifiViewController ()<UITextFieldDelegate>{
    
    NSString            *_ssidStr;
    NSString            *_pswStr;
}

@end

@implementation ConfigurationWifiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"配置";
    [self addBackItem];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getSSID)
                                                 name:UIApplicationDidBecomeActiveNotification
                                               object:nil];
    [self configureView];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getSSID];
}
-(void)configureView{
    
    self.view.backgroundColor = rgb(247, 249, 251, 1);
    
    self.chooseView.layer.cornerRadius = 5;
    self.chooseView.clipsToBounds = YES;
    self.chooseView.layer.borderWidth = 1;
    self.chooseView.qmui_borderColor = rgb(150, 150, 150, 1);
    self.inputTextfield.delegate = self;
    self.inputView.layer.cornerRadius = self.inputView.frame.size.height / 2;
    self.inputView.clipsToBounds = YES;
    
    self.sureButton.layer.cornerRadius = self.sureButton.frame.size.height / 2;
    self.sureButton.clipsToBounds = YES;
}

- (IBAction)chooseButtonClick:(id)sender {
    
    
    
}

- (IBAction)sureButtonClick:(id)sender {
    
    _pswStr = _inputTextfield.text;
    if (_pswStr == nil || _pswStr.length == 0) {
        [QMUITips showWithText:@"请输入WiFi密码" inView:self.view hideAfterDelay:0.5];
        return;
    }
    
//    BLEDeviceStatusViewController * blePairingVC = [[BLEDeviceStatusViewController alloc]init];
//    [self.navigationController pushViewController:blePairingVC animated:true];
    DeviceConnectingViewController * connectVC = [[DeviceConnectingViewController alloc]init];
    connectVC.ssid = _ssidStr;
    connectVC.wifiPassword = _inputTextfield.text;
    [self.navigationController pushViewController:connectVC animated:true];
}

-(void)getSSID{
    _ssidStr = [JMAirKissShareTools fetchSSIDInfo][@"SSID"];
    if (_ssidStr == nil || [_ssidStr isEqualToString:@""]) {
        [[GlobalAlertViewManager shareInstance]promptsPopViewWithtitle:nil content:@"请开启手机wifi后重试" cancelTitle:@"取消" sureTitle:@"确定" completion:^(NSInteger index) {
            if (index == 0) {
                
            }else if (index == 1){
             [GlobalTool openSystemSetting:@"App-Prefs:root=WIFI"];
            }
        }];
    }else {
        _chooseTextField.text  = _ssidStr;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:Character_Number] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL canChange = [string isEqualToString:filtered];
    return canChange;
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
