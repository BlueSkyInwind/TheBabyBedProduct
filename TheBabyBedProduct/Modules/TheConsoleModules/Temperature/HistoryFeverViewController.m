//
//  HistoryFeverViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "HistoryFeverViewController.h"
#import "TemperatureChartView.h"

@interface HistoryFeverViewController ()


@property(nonatomic,strong)TemperatureChartView * temChartView;

@end

@implementation HistoryFeverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"历史体温";
    [self addBackItem];
    [self configureView];
    [self obtainHistoryFeverValueComplication:^(BOOL isSuccess) {
        
    }];
}
-(void)configureView{
    
    _temChartView = [[TemperatureChartView alloc]initWithFrame:CGRectMake(0, NaviBarHeight, _k_w, _k_h / 2)];
    _temChartView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_temChartView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)obtainHistoryFeverValueComplication:(void(^)(BOOL isSuccess))finish{
    [BBRequestTool GetStatisticsDataDeviceType:@"2" deviceId:BBUserHelpers.deviceId successBlock:^(EnumServerStatus status, id object) {
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
