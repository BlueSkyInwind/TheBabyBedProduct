//
//  ConsoleTemperatureViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ConsoleTemperatureViewController.h"
#import "ThermometerView.h"
#import "ConsoleHeaderView.h"
#import "TemperatureThresholdSettingViewController.h"
#import "HistoryFeverViewController.h"
#import "ForecastValuesModel.h"

@interface ConsoleTemperatureViewController (){
    
    CGFloat minThresholdValue;
    CGFloat maxThresholdValue;

}

@property (nonatomic,strong)ConsoleHeaderView * headerView;
@property (nonatomic,strong)ThermometerView * thermometerView;

@end

@implementation ConsoleTemperatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"体温";
    [self addBackItem];
    [self configureView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sensorDataUpdates:) name:YDA_EVENT_NOTIFICATION object:nil ];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = true;
    [self getCryingThresholdValueComplication:^(BOOL isSuccess, ForecastValuesInfo *info) {
        if (isSuccess) {
            minThresholdValue = info.minVal.floatValue;
            maxThresholdValue = info.maxVal.floatValue;
        }
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = false;
}

-(void)configureView{
    
    __weak typeof (self) weakSelf = self;
    _headerView = [[NSBundle mainBundle]loadNibNamed:@"ConsoleHeaderView" owner:self options:nil].lastObject;
    _headerView.titleLabel.text = self.title;
    _headerView.statusLabel.text = @"宝宝体温正常";
    [self.view addSubview:_headerView];
    
    _headerView.backButtonClick = ^(UIButton *button) {
        [weakSelf.navigationController popViewControllerAnimated:true];
    };
    
    _headerView.settingButtonClick = ^(UIButton *button) {
        TemperatureThresholdSettingViewController * temperatureSetVC = [[TemperatureThresholdSettingViewController alloc]init];
        [weakSelf.navigationController pushViewController:temperatureSetVC animated:true];
    };
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@210);
    }];
    
    _thermometerView = [[NSBundle mainBundle]loadNibNamed:@"ThermometerView" owner:self options:nil].lastObject;
    [self.view addSubview:_thermometerView];
    [_thermometerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.headerView.mas_bottom).with.offset(5);
        make.height.equalTo(@(_k_h - 210));
    }];
    [_thermometerView updateAlarTemProgressWithNumber:50];
    _thermometerView.historyChartClick = ^{
        HistoryFeverViewController * historyFeverVC = [[HistoryFeverViewController alloc]init];
        [weakSelf.navigationController pushViewController:historyFeverVC animated:true];
    };
}
#pragma mark - 传感器数据通知状态
-(void)sensorDataUpdates:(NSNotification *)notification{
    NSDictionary * valueDic = notification.userInfo;
    NSString * bobyTemp = [NSString stringWithFormat:@"%@",valueDic[Body_Temp_Value]];
    CGFloat temp = bobyTemp.floatValue;
    [_thermometerView updateAlarTemProgressWithNumber:temp];
    NSString * tempState = @"宝宝体温正常";
    if ([bobyTemp floatValue] > maxThresholdValue){
        tempState = @"宝宝体温偏高";
    }else if ([bobyTemp floatValue] < minThresholdValue){
        tempState = @"宝宝体温偏低";
    }
    _headerView.statusLabel.text = tempState;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [_thermometerView updateAlarTemProgressWithNumber:20];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getCryingThresholdValueComplication:(void(^)(BOOL isSuccess,ForecastValuesInfo * info))finish{
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
