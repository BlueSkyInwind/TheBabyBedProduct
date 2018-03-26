//
//  ConsoleRateViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/24.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ConsoleRateViewController.h"
#import "ConsoleRateView.h"
#import "ConsoleHeaderView.h"
#import "ConsoleRateBottonView.h"
#import "TemperatureThresholdSettingViewController.h"
#import "CryingThresholdSettingViewController.h"
#import "WettingThresholdSettingViewController.h"
#import "KickQulitThresholdSettingViewController.h"

@interface ConsoleRateViewController (){
    
    UIImage * currentImage;
    UIColor * currentColor;
}

@property (nonatomic,strong)ConsoleHeaderView * headerView;
@property (nonatomic,strong)ConsoleRateView * rateView;
@end

@implementation ConsoleRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initVcData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = true;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = false;
}
-(void)initVcData{
    
    switch (self.rateType) {
        case BabyCryType:{
            self.title = @"哭闹";
            currentImage = [UIImage imageNamed:@"babycrying_normal_Icon"];
        }
            break;
        case BabyKickType:{
            self.title = @"踢被";
            currentImage = [UIImage imageNamed:@"babyQulit_normal_Icon"];
            currentColor = rgb(69, 207, 229, 1);
        }
            break;
        case BabyWetType:{
            self.title = @"尿湿";
            currentImage = [UIImage imageNamed:@"babyWetting_normal_Icon"];
        }
            break;
        default:
            break;
    }
    [self configureView];
}

-(void)configureView{
    
    __weak typeof (self) weakSelf = self;
    _headerView = [[NSBundle mainBundle]loadNibNamed:@"ConsoleHeaderView" owner:self options:nil].lastObject;
    _headerView.consoleHeaderLabel.text = self.title;
    [self.view addSubview:_headerView];
    _headerView.backButtonClick = ^(UIButton *button) {
        [weakSelf.navigationController popViewControllerAnimated:true];
    };
    _headerView.settingButtonClick = ^(UIButton *button) {
        [weakSelf pushThresholdSettingVC];
    };
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@190);
    }];
    
    UIView * backView = [[UIView alloc]init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.headerView.mas_bottom).with.offset(5);
        make.height.equalTo(@(_k_h - 250));
    }];
    
    _rateView = [ConsoleRateView initWithFrame:CGRectMake(15, 0, _k_w - 30, _k_w - 30) image:currentImage circleColor:currentColor title:self.title];
    [backView addSubview:_rateView];
    
    [_rateView updateProgressWithNumber:0];
    
    ConsoleRateBottonView * bottomView = [[ConsoleRateBottonView alloc]initWithFrame:CGRectZero];
    bottomView.historyBtnClick = ^(UIButton *button) {
        [weakSelf pushHistoryVC];
    };
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView.mas_bottom).with.offset(2);
        make.centerX.equalTo(self.view.mas_centerX);
        make.width.equalTo(@100);
        make.height.equalTo(@23);
    }];
}

-(void)pushHistoryVC{
    
    
}
-(void)pushThresholdSettingVC{
    
    switch (self.rateType) {
        case BabyCryType:{
            CryingThresholdSettingViewController * setVC = [[CryingThresholdSettingViewController alloc]init];
            [self.navigationController pushViewController:setVC animated:true];
        }
            break;
        case BabyKickType:{
            KickQulitThresholdSettingViewController * setVC = [[KickQulitThresholdSettingViewController alloc]init];
            [self.navigationController pushViewController:setVC animated:true];
        }
            break;
        case BabyWetType:{
            WettingThresholdSettingViewController * setVC = [[WettingThresholdSettingViewController alloc]init];
            [self.navigationController pushViewController:setVC animated:true];
        }
            break;
        default:
            break;
    }
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_rateView updateProgressWithNumber:50];
    
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
