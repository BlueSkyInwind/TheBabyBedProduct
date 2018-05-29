//
//  ConfigurationWifiViewController.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BaseViewController.h"

@interface ConfigurationWifiViewController : BaseViewController

/* 扫描结果*/
@property(nonatomic,strong)NSString * scanID;

@property (weak, nonatomic) IBOutlet UIView *chooseView;

@property (weak, nonatomic) IBOutlet UITextField *chooseTextField;
@property (weak, nonatomic) IBOutlet UIButton *chooseButton;
@property (weak, nonatomic) IBOutlet UIView *inputView;

@property (weak, nonatomic) IBOutlet UITextField *inputTextfield;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;









@end
