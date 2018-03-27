//
//  TheConsoleViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "TheConsoleViewController.h"
#import "HistoryFeverViewController.h"
#import "ConsoleHeaderView.h"
#import "ConsoleBodyView.h"
#import "ConsoleRateViewController.h"
#import "ConsoleTemperatureViewController.h"
#import "ConsoleRoomTemperatureViewController.h"


@interface TheConsoleViewController ()

@property (nonatomic,strong)ConsoleHeaderView * headerView;
@property (nonatomic,strong)ConsoleBodyView * bodyView;


@end

@implementation TheConsoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    _headerView = [[NSBundle mainBundle]loadNibNamed:@"ConsoleHeaderView" owner:self options:nil].lastObject;
    _headerView.backBtn.hidden = true;
    _headerView.settingBtn.hidden = true;
    _headerView.statusLabel.hidden = true;
    [self.view addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@190);
    }];
    
    _bodyView = [[NSBundle mainBundle]loadNibNamed:@"ConsoleBodyView" owner:self options:nil].lastObject;
    [self.view addSubview:_bodyView];
    [_bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.headerView.mas_bottom).with.offset(5);
        make.height.equalTo(@(_k_h - 190));
    }];
    
    __weak typeof (self) weakSelf = self;
    _bodyView.bobyTemperatureBtnClick = ^(UIButton *button) {
        
//        ConsoleTemperatureViewController * temVC = [[ConsoleTemperatureViewController alloc]init];
//        [weakSelf.navigationController pushViewController:temVC animated:true];

        HistoryFeverViewController * historyFeverVC = [[HistoryFeverViewController alloc]init];
        [weakSelf.navigationController pushViewController:historyFeverVC animated:true];
    };
    
    _bodyView.roomTemperatureBtnClick = ^(UIButton *button) {
        ConsoleRoomTemperatureViewController * consoleRoomTemperature = [[ConsoleRoomTemperatureViewController alloc]init];
        [weakSelf.navigationController pushViewController:consoleRoomTemperature animated:true];
    };
    
    _bodyView.cryingBtnClick = ^(UIButton *button) {
        ConsoleRateViewController * rateVC = [[ConsoleRateViewController alloc]init];
        rateVC.rateType = BabyCryType;
        [weakSelf.navigationController pushViewController:rateVC animated:true];
    };
    
    _bodyView.wettingBtnClick = ^(UIButton *button) {
        ConsoleRateViewController * rateVC = [[ConsoleRateViewController alloc]init];
        rateVC.rateType = BabyWetType;
        [weakSelf.navigationController pushViewController:rateVC animated:true];
    };
    
    _bodyView.qulitBtnClick = ^(UIButton *button) {
        ConsoleRateViewController * rateVC = [[ConsoleRateViewController alloc]init];
        rateVC.rateType = BabyKickType;
        [weakSelf.navigationController pushViewController:rateVC animated:true];
    };
    
    _bodyView.videoBtnClick = ^(UIButton *button) {
        
    };
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
