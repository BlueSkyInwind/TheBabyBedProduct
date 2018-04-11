//
//  KickQulitChartViewController.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "KickQulitChartViewController.h"
#import "KickQulitChartView.h"

@interface KickQulitChartViewController ()

@property(nonatomic,strong)KickQulitChartView * kickQulitChartView;

@end

@implementation KickQulitChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"踢被";
    [self addBackItem];
    [self configureView];
}

-(void)configureView{
    
    _kickQulitChartView = [[KickQulitChartView alloc]initWithFrame:CGRectMake(0, NaviBarHeight, _k_w, _k_h / 2)];
    _kickQulitChartView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_kickQulitChartView];
    
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
