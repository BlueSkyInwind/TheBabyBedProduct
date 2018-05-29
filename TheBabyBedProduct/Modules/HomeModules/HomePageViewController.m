//
//  HomePageViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomeLeftItemView.h"
#import "HomeTableViewCell.h"
#import "HomeHeaderView.h"
#import "ConsoleTemperatureViewController.h"
#import "ConsoleRateViewController.h"
#import "ConsoleRoomTemperatureViewController.h"
#import "MessageViewController.h"
#import "AddDeviceView.h"
#import "ScanDeviceCodeViewController.h"
#import "ScanDeviceCodeViewController.h"
#import "BBSignInPopView.h"

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray * imgArr;
    NSArray * titleArr;
    
}

/**<#Description#>*/
@property (nonatomic,strong)AddDeviceView  * addDeviceView;

@property (nonatomic,strong)UITableView * homeTableView;
/* cell*/
@property(nonatomic,strong)HomeTableViewCell * homeCell;

/* 头部视图*/
@property(nonatomic,strong)HomeHeaderView * headerView;

@end

@implementation HomePageViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (BBUserHelpers.isNeedPopSignIn) {
        
        BBUser *user = [BBUser bb_getUser];
        
        BBSignInPopView *signInPopV = [BBSignInPopView signInPopView];
        
        BBWeakSelf(signInPopV)
        signInPopV.signInBlock = ^{
            [BBRequestTool bb_requestSignInWithSuccessBlock:^(EnumServerStatus status, id object) {
                NSLog(@"签到成功 %@",object);
                BBStrongSelf(signInPopV)
                NSDictionary *result = (NSDictionary *)object;
                if ([result.allKeys containsObject:@"msg"]) {
                    NSString *msg = [result objectForKey:@"msg"];
                    if ([msg containsString:@"已签到"] || [msg containsString:@"请求成功"]) {
                        
                        [signInPopV signInSuccess];
                        
                        user.latestSignInDate = [NSDate bb_todayStr];
                        [BBUser bb_saveUser:user];
                    }
                }
            } failureBlock:^(EnumServerStatus status, id object) {
                [QMUITips showInfo:@"签到失败"];
            }];
        };

        [signInPopV show];
        
        user.latestHomePagePopSingInDate = [NSDate bb_todayStr];
        [BBUser bb_saveUser:user];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad]; 
    // Do any additional setup after loading the view.
//    [self configureAddDeviceView];
    [self configureView];
    [[BBUdpSocketManager shareInstance] createAsyncUdpSocket];

}

-(void)configureAddDeviceView{
    __weak typeof (self) weakSelf = self;
    _addDeviceView = [[AddDeviceView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_addDeviceView];
    _addDeviceView.addDeviceClick = ^{
      //添加设备点击
        [weakSelf popAddDeviceAlertView];
      };
    [_addDeviceView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)configureView{
    
    imgArr = @[@"home_room_Icon",@"home_temperature_Icon",@"home_wetting_Icon",@"home_kickqulit_Icon"];
    titleArr = @[@"室内外温度",@"体温",@"尿湿状态",@"踢被状态"];

    __weak typeof (self) weakSelf = self;
    HomeLeftItemView * leftItemView = [[HomeLeftItemView alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    leftItemView.nameLabel.text = @"欧阳马克";
    leftItemView.homeHeaderClick = ^(UIButton *button) {
        //婴儿头像的点击回调
        [weakSelf configureAddDeviceView];
    };
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftItemView];
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithImage:[[[UIImage imageNamed:@"home_message_Icon"] TransformtoSize:CGSizeMake(32, 32)] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonItemClick)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    _homeTableView = [[UITableView alloc]init];
    _homeTableView.delegate = self;
    _homeTableView.dataSource = self;
    _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _homeTableView.scrollEnabled = false;
    _homeTableView.backgroundColor = rgb(247, 249, 251, 1);
    [self.view addSubview:_homeTableView];
    [_homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_homeTableView registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
    
    _headerView = [HomeHeaderView initWithBabyStatus:@[@"home_histroy_Icon",@"home_crystatus_Icon",@"home_happystatus_Icon"]];
    _homeTableView.tableHeaderView = _headerView;
    
}
-(void)rightButtonItemClick{
    
    MessageViewController * messageVC = [[MessageViewController alloc]init];
    messageVC.hidesBottomBarWhenPushed = true;
    [self.navigationController pushViewController:messageVC animated:true];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 47;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    _homeCell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell" forIndexPath:indexPath];
    if (!_homeCell) {
        _homeCell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeTableViewCell"];
    }
    [_homeCell setIcon:imgArr[indexPath.row] title:titleArr[indexPath.row] content:@"正常"];
    return _homeCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    switch (indexPath.row) {
        case 0:{
            ConsoleRoomTemperatureViewController * consoleRoomTemperature = [[ConsoleRoomTemperatureViewController alloc]init];
            [self.navigationController pushViewController:consoleRoomTemperature animated:true];
        }
            break;
        case 1:{
            ConsoleTemperatureViewController * temVC = [[ConsoleTemperatureViewController alloc]init];
            [self.navigationController pushViewController:temVC animated:true];
        }
            break;
        case 2:{
            ConsoleRateViewController * rateVC = [[ConsoleRateViewController alloc]init];
            rateVC.rateType = BabyWetType;
            [self.navigationController pushViewController:rateVC animated:true];
        }
            break;
        case 3:{
            ConsoleRateViewController * rateVC = [[ConsoleRateViewController alloc]init];
            rateVC.rateType = BabyKickType;
            [self.navigationController pushViewController:rateVC animated:true];
        }
            break;
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 11;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = rgb(247, 249, 251, 1);
    return view;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)popAddDeviceAlertView{
    __weak typeof (self) weakSelf = self;
    [[GlobalAlertViewManager shareInstance] promptsPopViewWithtitle:nil content:@"请绑定您的婴儿床" cancelTitle:@"取消" sureTitle:@"确定" completion:^(NSInteger index) {
        if (index == 1) {
            // 进入设备扫描
            [self pushScanVC];
        }
    }];
}

-(void)pushScanVC{
    ScanDeviceCodeViewController *  scanDeviceCodeVC = [[ScanDeviceCodeViewController alloc]init];
    [self.navigationController pushViewController:scanDeviceCodeVC animated:true];
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
