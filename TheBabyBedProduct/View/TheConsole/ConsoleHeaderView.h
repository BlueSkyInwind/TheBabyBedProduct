//
//  ConsoleHeaderView.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/23.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BackButtonClick)(UIButton * button);
typedef void (^SettingButtonClick)(UIButton * button);
@interface ConsoleHeaderView : UIView
@property (weak, nonatomic) IBOutlet UIButton *consoleHeaderBtn;
@property (weak, nonatomic) IBOutlet UILabel *consoleHeaderLabel;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *settingBtnConstraint;

@property (copy, nonatomic)BackButtonClick backButtonClick;
@property (copy, nonatomic)SettingButtonClick settingButtonClick;

-(void)resetConsoleSettingBtn:(CGFloat)constant;
@end
