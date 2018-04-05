//
//  WettingChartViewController.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "WettingChartViewController.h"
#import "WettingChartView.h"

@interface WettingChartViewController ()


@property(nonatomic,strong)WettingChartView * wettingChartView;

@end

@implementation WettingChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"尿湿";
    [self addBackItem];

    [self configureView];
}

-(void)configureView{
    
    _wettingChartView = [[WettingChartView alloc]initWithFrame:CGRectMake(0, NaviBarHeight, _k_w, _k_h / 2)];
    _wettingChartView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_wettingChartView];

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
