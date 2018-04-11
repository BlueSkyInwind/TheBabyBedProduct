//
//  TemperatureThresholdSettingViewController.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TemperatureThresholdSettingViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *lowerTemperatureTextfield;

@property (weak, nonatomic) IBOutlet UITextField *highTemperatureTextfield;

@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end
