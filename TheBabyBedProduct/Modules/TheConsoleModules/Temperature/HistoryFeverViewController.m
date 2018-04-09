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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
