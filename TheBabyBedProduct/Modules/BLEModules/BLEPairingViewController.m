//
//  BLEPairingViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/6.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BLEPairingViewController.h"
#import "deviceListTableViewCell.h"

@interface BLEPairingViewController ()<UITableViewDelegate,UITableViewDataSource>


/* UITAbleView*/
@property(nonatomic,strong)UITableView * deviceTableView;
/* <#Description#>*/
@property(nonatomic,strong)deviceListTableViewCell * deviceListCell;
@end

@implementation BLEPairingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"蓝牙配对";
    [self addBackItem];
    
    [self configureView];
}

-(void)configureView{
    
    
    _deviceImageArr = @[@"babyDed_Icon",@"babyDed_Icon",@"bluetooth_Icon"];
    _deviceNameArr = @[@"小雅智能",@"小雅智能",@"蓝牙1"];
    
    _deviceTableView = [[UITableView alloc]init];
    _deviceTableView.delegate = self;
    _deviceTableView.dataSource = self;
    [self.view addSubview:_deviceTableView];
    [_deviceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_deviceTableView registerNib:[UINib nibWithNibName:@"deviceListTableViewCell" bundle:nil] forCellReuseIdentifier:@"deviceListTableViewCell"];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _deviceListCell = [tableView dequeueReusableCellWithIdentifier:@"deviceListTableViewCell" forIndexPath:indexPath];
    _deviceListCell.deviceImageView.image = [UIImage imageNamed:_deviceImageArr[indexPath.section]];
    _deviceListCell.deviceNameLabel.text = _deviceNameArr[indexPath.section];
    return _deviceListCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
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
