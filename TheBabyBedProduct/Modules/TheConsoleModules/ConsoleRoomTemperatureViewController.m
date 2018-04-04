//
//  ConsoleRoomTemperatureViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ConsoleRoomTemperatureViewController.h"
#import "ConsoleHeaderView.h"
#import "RoomIndicatorView.h"
#import "RoomTemperatureChartViewController.h"

@interface ConsoleRoomTemperatureViewController ()


@property (nonatomic,strong)ConsoleHeaderView * headerView;
@property (nonatomic,strong)RoomIndicatorView * indicatorView;


@end

@implementation ConsoleRoomTemperatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"环境温度";
    [self configureView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = true;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = false;
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
        
    };
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@210);
    }];
    
    _indicatorView = [[NSBundle mainBundle]loadNibNamed:@"RoomIndicatorView" owner:self options:nil].lastObject;
    [self.view addSubview:_indicatorView];
    _indicatorView.roomTemperatureCurveClick = ^{
        RoomTemperatureChartViewController * roomTemPeratureChartVC = [[RoomTemperatureChartViewController alloc]init];
        roomTemPeratureChartVC.isOutside = false;
        [weakSelf.navigationController pushViewController:roomTemPeratureChartVC animated:true];
    };
    _indicatorView.outdoorTemperatureCurveClick = ^{
        RoomTemperatureChartViewController * roomTemPeratureChartVC = [[RoomTemperatureChartViewController alloc]init];
        roomTemPeratureChartVC.isOutside = true;
        [weakSelf.navigationController pushViewController:roomTemPeratureChartVC animated:true];
    };
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.headerView.mas_bottom).with.offset(5);
        make.height.equalTo(@(_k_h - 210));
    }];
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
