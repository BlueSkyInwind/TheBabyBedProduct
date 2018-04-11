//
//  TemperatureThresholdSettingViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "TemperatureThresholdSettingViewController.h"

@interface TemperatureThresholdSettingViewController ()

@end

@implementation TemperatureThresholdSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"阈值设定";
    [self addBackItem];

}

-(void)configureView{
    
    
}

- (IBAction)saveBtnClick:(id)sender {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- 网络请求 ----

-(void)SetTemperatureThresholdValueComplication:(void(^)(BOOL isSuccess))finish{
    [BBRequestTool SetThresholdValueDeviceType:@"2" minValue:self.lowerTemperatureTextfield.text maxValue:self.highTemperatureTextfield.text deviceId:@"" successBlock:^(EnumServerStatus status, id object) {
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
