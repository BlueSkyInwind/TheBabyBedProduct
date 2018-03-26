//
//  CryingThresholdSettingViewController.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CryingThresholdSettingViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *decibelTextField;
@property (weak, nonatomic) IBOutlet UITableView *displayTableView;
@property (weak, nonatomic) IBOutlet UILabel *quietnessLabel;
@property (weak, nonatomic) IBOutlet UILabel *cryingLabel;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end
