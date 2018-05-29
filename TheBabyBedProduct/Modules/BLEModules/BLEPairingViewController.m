//
//  BLEPairingViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/6.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BLEPairingViewController.h"
#import "deviceListTableViewCell.h"
#import "BaseCentralManager.h"

@interface BLEPairingViewController ()<UITableViewDelegate,UITableViewDataSource,BaseCentralManagerDelegate>{
}


/* UITAbleView*/
@property(nonatomic,strong)UITableView * deviceTableView;
/* <#Description#>*/
@property(nonatomic,strong)deviceListTableViewCell * deviceListCell;

/* <#Description#>*/
@property(nonatomic,strong)BaseCentralManager * manager;

@end

@implementation BLEPairingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设备链接";
    [self addBackItem];
    [self configureView];
    [self createCentralManager];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    
}
-(void)viewWillDisappear:(BOOL)animated{
    
    
}
-(void)createCentralManager{
    _manager = [BaseCentralManager shareInstance];
    _manager.delegate = self;
    [_manager startScan];
    [_deviceNameArr removeAllObjects];
    [self performSelector:@selector(stopScan) withObject:self afterDelay:20];
}
-(void)stopScan{
    [_manager stopScan];
}

-(void)onScanning:(NSArray *)peripheralArray{
    DLog(@"%@",peripheralArray);
    if (peripheralArray.count == 0) {
        return;
    }
    if (peripheralArray.count > _deviceNameArr.count) {
        [_deviceNameArr addObjectsFromArray:peripheralArray];
    }
    [self.deviceTableView reloadData];
}
-(void)onConnectingPeripheral:(CBPeripheral *)peripheral{
    
    
}
- (void)onConnectedPeripheral:(CBPeripheral *)peripheral{
    
    
}
- (void)onDisconnectedPeripheral:(CBPeripheral *)peripheral{
    
    
}

-(void)configureView{
    
    _deviceNameArr = [NSMutableArray array];
    _deviceImageArr = @[@"babyDed_Icon",@"bluetooth_Icon"];
    [_deviceNameArr addObject:@{thePeripheralName:@"小雅智能"}];
    
    _deviceTableView = [[UITableView alloc]init];
    _deviceTableView.delegate = self;
    _deviceTableView.dataSource = self;
    _deviceTableView.backgroundColor = rgb(247, 249, 251, 1);
    _deviceTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return _deviceNameArr.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    _deviceListCell = [tableView dequeueReusableCellWithIdentifier:@"deviceListTableViewCell" forIndexPath:indexPath];
    NSString * name  = _deviceNameArr[indexPath.section][thePeripheralName];
    if ([name hasPrefix:deviceNameP]) {
        _deviceListCell.deviceImageView.image = [UIImage imageNamed:_deviceImageArr[0]];
        _deviceListCell.deviceNameLabel.text = @"小雅智能";
    }else{
        _deviceListCell.deviceImageView.image = [UIImage imageNamed:_deviceImageArr[1]];
        _deviceListCell.deviceNameLabel.text = name;
    }
    return _deviceListCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = rgb(247, 249, 251, 1);
    return view;
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
