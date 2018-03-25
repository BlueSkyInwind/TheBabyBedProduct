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

@interface ConsoleTemperatureViewController ()

@property (nonatomic,strong)ConsoleHeaderView * headerView;
@property (nonatomic,strong)ThermometerView * thermometerView;

@end

@implementation ConsoleTemperatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"体温";
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
    
    _thermometerView = [[NSBundle mainBundle]loadNibNamed:@"ThermometerView" owner:self options:nil].lastObject;
    [self.view addSubview:_thermometerView];
    [_thermometerView mas_makeConstraints:^(MASConstraintMaker *make) {
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
