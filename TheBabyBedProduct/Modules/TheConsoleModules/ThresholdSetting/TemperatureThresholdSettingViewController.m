//
//  TemperatureThresholdSettingViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "TemperatureThresholdSettingViewController.h"
#import "ForecastValuesModel.h"

@interface TemperatureThresholdSettingViewController ()<UITextFieldDelegate>

@end

@implementation TemperatureThresholdSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleStr = @"预值设定";
    [self configureView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    __weak typeof (self) weakSelf = self;
    [self getTemperatureThresholdValueComplication:^(BOOL isSuccess, ForecastValuesInfo *info) {
        if (isSuccess) {
            self.lowerTemperatureTextfield.text = info.minVal;
            self.highTemperatureTextfield.text = info.maxVal;
        }
    }];
}
-(void)configureView{
    
    self.saveBtn.layer.cornerRadius = self.saveBtn.frame.size.height / 2;
    self.saveBtn.clipsToBounds = true;
    
    self.lowerTemperatureTextfield.keyboardType = UIKeyboardTypeNumberPad;
    self.lowerTemperatureTextfield.layer.borderWidth = 1;
    self.lowerTemperatureTextfield.delegate = self;
    self.lowerTemperatureTextfield.layer.borderColor = rgb(128, 128, 128, 1).CGColor;
    self.highTemperatureTextfield.keyboardType = UIKeyboardTypeNumberPad;
    self.highTemperatureTextfield.layer.borderWidth = 1;
    self.highTemperatureTextfield.delegate = self;
    self.highTemperatureTextfield.layer.borderColor = rgb(128, 128, 128, 1).CGColor;
    
}

- (IBAction)saveBtnClick:(id)sender {
    if (self.lowerTemperatureTextfield.text == nil || [self.lowerTemperatureTextfield.text  isEqual: @""]) {
        [QMUITips showWithText:@"请输入最低温度值" inView:self.view hideAfterDelay:0.5];
        return;
    }
    if (self.highTemperatureTextfield.text == nil || [self.highTemperatureTextfield.text  isEqual: @""]) {
        [QMUITips showWithText:@"请输入最高温度值" inView:self.view hideAfterDelay:0.5];
         return;
    }
    __weak typeof (self) weakSelf = self;
    [self SetTemperatureThresholdValueComplication:^(BOOL isSuccess) {
        if (isSuccess) {
            [QMUITips showWithText:@"保存成功" inView:self.view hideAfterDelay:0.5];
            [weakSelf.navigationController popViewControllerAnimated:true];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}

#pragma mark --- 网络请求 ----

-(void)SetTemperatureThresholdValueComplication:(void(^)(BOOL isSuccess))finish{
    [BBRequestTool SetThresholdValueDeviceType:@"2" minValue:self.lowerTemperatureTextfield.text maxValue:self.highTemperatureTextfield.text deviceId:BBUserHelpers.deviceId
                                           img:nil
                                  successBlock:^(EnumServerStatus status, id object) {
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
-(void)getTemperatureThresholdValueComplication:(void(^)(BOOL isSuccess,ForecastValuesInfo * info))finish{
    [BBRequestTool GetThresholdValueDeviceType:@"2" deviceId:[BBUser bb_getUser].deviceId successBlock:^(EnumServerStatus status, id object) {
        ForecastValuesModel *resultM = [[ForecastValuesModel alloc] initWithDictionary:object error:nil];
        if (resultM.code == 0) {
            finish(true,resultM.data);
        }else{
            [QMUITips showWithText:resultM.msg inView:self.view hideAfterDelay:0.5];
            finish(false,nil);
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        finish(false,nil);
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
