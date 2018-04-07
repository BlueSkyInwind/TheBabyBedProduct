//
//  ScanDeviceCodeViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/3.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ScanDeviceCodeViewController.h"
#import "QRScanView.h"
#import "ConfigurationWifiViewController.h"

@interface ScanDeviceCodeViewController ()<UITextFieldDelegate>{
    CGRect qrFrame;
}

/* 扫描视图*/
@property(nonatomic,strong)QRScanView * qrScanView;

@end

@implementation ScanDeviceCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"扫一扫";
    [self addBackItem];

    [self configrueView];
    
}
- (IBAction)sureButtonClick:(id)sender {
    
    [self pushConfigurationWifiVC];
}

-(void)viewDidLayoutSubviews{
    qrFrame = _qrView.frame;
    __weak typeof (self) weakSelf = self;
    if (_qrScanView) {
        return;
    }
    _qrScanView = [QRScanView defaultShareFrame:CGRectMake(0, 0, _qrView.frame.size.width, _qrView.frame.size.height) resultBlock:^(NSString *result) {
        [weakSelf.qrScanView stop];
        
        
    }];
    [self.qrView addSubview:_qrScanView];
}

-(void)configrueView{
    
    self.sureButton.layer.cornerRadius = self.sureButton.bounds.size.height / 2;
    self.sureButton.clipsToBounds = true;
    self.SerialNumberTextField.delegate = self;
    self.SerialNumberTextField.layer.borderColor = rgb(145, 145, 145, 1).CGColor;
    self.SerialNumberTextField.layer.borderWidth = 0.8;
    
}

- (void)reStartScan
{
    if (!_qrScanView) {
        return;
    }
    [_qrScanView start];
    if (_qrScanView.is_AnmotionFinished) {
        [_qrScanView loopDrawLine];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reStartScan];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_qrScanView) {
        [_qrScanView stop];
    }
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
    
    
}


-(void)pushConfigurationWifiVC {
    
    ConfigurationWifiViewController * configurationVC = [[ConfigurationWifiViewController alloc]init];
    [self.navigationController pushViewController:configurationVC animated:true];
    
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
