//
//  RoomTemperatureChartViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/24.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "RoomTemperatureChartViewController.h"
#import "RoomTemperatureView.h"

@interface RoomTemperatureChartViewController ()
@property(nonatomic,strong)RoomTemperatureView * roomTemperatureView;

@end

@implementation RoomTemperatureChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"室内温度";
    if (self.isOutside) {
        self.title = @"室外温度";
    }
    [self configureView];
}
-(void)configureView{
    
    _roomTemperatureView = [[RoomTemperatureView alloc]initWithFrame:CGRectMake(0, NaviBarHeight, _k_w, _k_h / 2)];
    _roomTemperatureView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_roomTemperatureView];
    
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
