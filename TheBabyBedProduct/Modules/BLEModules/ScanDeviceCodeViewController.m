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
#import "BLEPairingViewController.h"

@interface ScanDeviceCodeViewController ()<UITextFieldDelegate>{
    CGRect qrFrame;
    
}

/* 扫描视图*/
@property(nonatomic,strong)QRScanView * qrScanView;
@property(nonatomic,strong)NSString * deviceid;

@end

@implementation ScanDeviceCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleStr = @"扫一扫";
    [self configrueView];
}
- (IBAction)sureButtonClick:(id)sender {
    if ([self.SerialNumberTextField.text isEqualToString:@""] || self.SerialNumberTextField.text == nil) {
        return;
    }
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
        weakSelf.deviceid = [self parsingScanString:result];
        [weakSelf pushConfigurationWifiVC];
    }];
    [self.qrView addSubview:_qrScanView];
}
-(void)configrueView{
    
    self.sureButton.layer.cornerRadius = self.sureButton.bounds.size.height / 2;
    self.sureButton.clipsToBounds = true;
    self.sureButton.hidden = true;
    self.SerialNumberTextField.delegate = self;
    self.SerialNumberTextField.layer.borderColor = rgb(145, 145, 145, 1).CGColor;
    self.SerialNumberTextField.layer.borderWidth = 0.8;
    
}

-(NSString *)parsingScanString:(NSString *)scanStr{
    
    NSDictionary * dic = [self dictionaryWithUrlString:scanStr];
    NSString * deviceID;
    if (dic.allKeys.count > 0 && [dic.allKeys containsObject:@"deviceId"]) {
        deviceID = dic[@"deviceId"];
    }
    return deviceID;
}

- (void)reStartScan
{
    if (!_qrScanView) {
        return;
    }
    [_qrScanView start];
    if (!_qrScanView.is_AnmotionFinished) {
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
    self.sureButton.hidden = false;

    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
   self.deviceid = textField.text;

}
-(void)pushConfigurationWifiVC {
    
    if (BBGlobalUtility.airkissCount >= 3) {
        BLEPairingViewController * blePairingVC = [[BLEPairingViewController alloc]init];
        [self.navigationController pushViewController:blePairingVC animated:true];
        return;
    }
    
    ConfigurationWifiViewController * configurationVC = [[ConfigurationWifiViewController alloc]init];
    configurationVC.scanID = self.deviceid;
    [self.navigationController pushViewController:configurationVC animated:true];
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:Character_Number] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSDictionary *)dictionaryWithUrlString:(NSString *)urlStr
{
    if (urlStr && urlStr.length && [urlStr rangeOfString:@"?"].length == 1) {
        NSArray *array = [urlStr componentsSeparatedByString:@"?"];
        if (array && array.count == 2) {
            NSString *paramsStr = array[1];
            if (paramsStr.length) {
                NSMutableDictionary *paramsDict = [NSMutableDictionary dictionary];
                NSArray *paramArray = [paramsStr componentsSeparatedByString:@"&"];
                for (NSString *param in paramArray) {
                    if (param && param.length) {
                        NSArray *parArr = [param componentsSeparatedByString:@"="];
                        if (parArr.count == 2) {
                            [paramsDict setObject:parArr[1] forKey:parArr[0]];
                        }
                    }
                }
                return paramsDict;
            }else{
                return nil;
            }
        }else{
            return nil;
        }
    }else{
        return nil;
    }
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
