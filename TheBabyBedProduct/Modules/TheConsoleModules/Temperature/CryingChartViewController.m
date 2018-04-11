//
//  CryingChartViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "CryingChartViewController.h"
#import "CryingChartView.h"

@interface CryingChartViewController ()
@property(nonatomic,strong)CryingChartView * cryingChartView;

@end

@implementation CryingChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"哭闹";
    [self addBackItem];
    [self configureView];
}

-(void)configureView{
    
    _cryingChartView = [[CryingChartView alloc]initWithFrame:CGRectMake(0, NaviBarHeight, _k_w, _k_h / 2)];
    _cryingChartView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_cryingChartView];
    
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
