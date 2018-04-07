//
//  ConfigurationWifiViewController.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ConfigurationWifiViewController.h"
#import "DeviceConnectingViewController.h"

@interface ConfigurationWifiViewController ()

@end

@implementation ConfigurationWifiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"配置";
    [self addBackItem];
    [self configureView];
    
}

-(void)configureView{
    
    self.view.backgroundColor = rgb(247, 249, 251, 1);
    
    self.chooseView.layer.cornerRadius = 5;
    self.chooseView.clipsToBounds = YES;
    self.chooseView.layer.borderWidth = 1;
    self.chooseView.qmui_borderColor = rgb(150, 150, 150, 1);
    
    self.inputView.layer.cornerRadius = self.inputView.frame.size.height / 2;
    self.inputView.clipsToBounds = YES;
    
    self.sureButton.layer.cornerRadius = self.sureButton.frame.size.height / 2;
    self.sureButton.clipsToBounds = YES;
}

- (IBAction)chooseButtonClick:(id)sender {
    
    
}

- (IBAction)sureButtonClick:(id)sender {
    
    DeviceConnectingViewController * connectVC = [[DeviceConnectingViewController alloc]init];
    [self.navigationController pushViewController:connectVC animated:true];
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
