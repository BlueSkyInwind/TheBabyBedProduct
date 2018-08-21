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
#import "WettingChartViewController.h"
#import "CryingChartViewController.h"
#import "KickQulitChartViewController.h"

@interface ConsoleRateViewController (){
    
    UIImage * currentImage;
    UIColor * currentColor;
}

@property (nonatomic,strong)ConsoleHeaderView * headerView;
@property (nonatomic,strong)ConsoleRateView * rateView;
@property (nonatomic,strong)NSString * statusStr;

@end

@implementation ConsoleRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initVcData];
    self.view.backgroundColor = [UIColor whiteColor];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sensorDataUpdates:) name:YDA_EVENT_NOTIFICATION object:nil ];
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
    currentColor = rgb(69, 207, 229, 1);
    switch (self.rateType) {
        case BabyCryType:{
            self.title = @"哭闹";
            currentImage = [UIImage imageNamed:@"babycrying_normal_Icon"];
        }
            break;
        case BabyKickType:{
            self.title = @"踢被";
            currentImage = [UIImage imageNamed:@"babyQulit_normal_Icon"];
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
    
    [[self rac_valuesAndChangesForKeyPath:@"statusStr" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(RACTwoTuple<id,NSDictionary *> * _Nullable x) {
        
    }];
}

#pragma mark - 传感器数据通知状态
-(void)sensorDataUpdates:(NSNotification *)notification{
    NSDictionary * valueDic = notification.userInfo;
    DLog(@"%@",valueDic);
    switch (self.rateType) {
        case BabyCryType:{
            NSString * cryState = @"您的宝宝很乖哦，正在睡觉";
            NSString * shortStr = @"安静";
            NSNumber * cryValue = valueDic[Baby_Cry_State];
            if ([cryValue shortValue] == 1) {
                cryState = @"您的宝宝正在哭闹";
                shortStr = @"哭闹";
                [_rateView updateProgressWithNumber:100];
            }
            _headerView.statusLabel.text = cryState;
            _rateView.titleLabel.text = shortStr;
        }
            break;
        case BabyKickType:{
            NSString * kickState = @"宝宝盖被正常";
            NSString * shortStr = @"正常";
            NSNumber * kickValue = valueDic[Baby_Urine_Value];
            if ([kickValue shortValue] == 1){
                kickState = @"宝宝踢被啦";
                shortStr = @"踢被";
                [_rateView updateProgressWithNumber:100];
            }
            _headerView.statusLabel.text = kickState;
            _rateView.titleLabel.text = shortStr;
        }
            break;
        case BabyWetType:{
            NSString * wetState;
            NSString * shotStr;
            NSNumber * wetValue = valueDic[Env_Humidity_Value];
            if ([wetValue shortValue] < 10){
                wetState = @"您的宝宝尿不湿干爽";
                shotStr = @"干爽";
            }else if([wetValue shortValue] > 10 &&  [wetValue shortValue] < 50){
                wetState = @"您的宝宝尿不湿轻度尿湿";
                shotStr = @"轻度";
            }else{
                wetState = @"您的宝宝尿不湿已过湿，请注意更换";
                shotStr = @"过湿";
            }
            [_rateView updateProgressWithNumber:[wetValue floatValue]];
            _headerView.statusLabel.text = wetState;
            _rateView.titleLabel.text = shotStr;
        }
            break;
        default:
            break;
    }
}
-(void)configureView{
    
    __weak typeof (self) weakSelf = self;
    _headerView = [[NSBundle mainBundle]loadNibNamed:@"ConsoleHeaderView" owner:self options:nil].lastObject;
    _headerView.titleLabel.text = self.title;
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
    switch (self.rateType) {
        case BabyCryType:{
            CryingChartViewController * cryingVC = [[CryingChartViewController alloc]init];
            [self.navigationController pushViewController:cryingVC animated:true];

        }
            break;
        case BabyKickType:{
            KickQulitChartViewController * kickQulitVC = [[KickQulitChartViewController alloc]init];
            [self.navigationController pushViewController:kickQulitVC animated:true];
            
        }
            break;
        case BabyWetType:{
            WettingChartViewController * chartVC = [[WettingChartViewController alloc]init];
            [self.navigationController pushViewController:chartVC animated:true];
        }
            break;
        default:
            break;
    }
}
-(void)pushThresholdSettingVC{
    
    switch (self.rateType) {
        case BabyCryType:{
            [QMUITips showWithText:@"尽请期待" inView:self.view hideAfterDelay:0.5];

//            CryingThresholdSettingViewController * setVC = [[CryingThresholdSettingViewController alloc]init];
//            [self.navigationController pushViewController:setVC animated:true];
        }
            break;
        case BabyKickType:{
            [QMUITips showWithText:@"尽请期待" inView:self.view hideAfterDelay:0.5];
//
//            KickQulitThresholdSettingViewController * setVC = [[KickQulitThresholdSettingViewController alloc]init];
//            [self.navigationController pushViewController:setVC animated:true];
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


//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    [_rateView updateProgressWithNumber:100];
//
//}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
