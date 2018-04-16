//
//  BBMyDeviceViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/29.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMyDeviceViewController.h"
#import "BBMyDevieceCell.h"
#import "BaseResultModel.h"
#import "BBUserDevice.h"

@interface BBMyDeviceViewController ()
@property(nonatomic,strong) UITableView *tableView;
/** 设备信息title数组 */
@property(nonatomic,strong) NSMutableArray *deviceMessageTitles;
/** 已连接的传感器数组 */
@property(nonatomic,strong) NSMutableArray *sensors;
@end

@implementation BBMyDeviceViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的设备";
    self.view.backgroundColor = k_color_vcBg;
    
    [self.deviceMessageTitles addObjectsFromArray:@[@"设备状态",@"设备型号",@"硬件版本",@"设备ID"]];
    
    [self creatUI];
    
    [self getMyDeviceData];
}

-(void)getMyDeviceData
{
    //获取用户设备信息，错误不处理
    [BBRequestTool bb_requestGetDeviceInfoWithSuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"获取设备信息成功 %@",object);
        BBUserDeviceResultModel *deviceRM = [BBUserDeviceResultModel mj_objectWithKeyValues:object];
        if (deviceRM.code == 0) {
            BBUserDevice *userDevice = deviceRM.data;
            [BBUserDevice bb_saveUserDevice:userDevice];
            [self.tableView reloadData];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
    }];
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatUI
{
    UIImageView *topImgBgV = [UIImageView bb_imgVMakeWithSuperV:self.view imgName:@"console_header_Icon"];
    topImgBgV.frame = CGRectMake(0, 0, _k_w, 260);
    topImgBgV.userInteractionEnabled = YES;
    
    UIButton *backBt = [UIButton bb_btMakeWithSuperV:topImgBgV imageName:@"cryingChooseDate_left_Icon"];
    backBt.frame = CGRectMake(0, 20, 50, 44);
    [backBt addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLB = [UILabel bb_lbMakeWithSuperV:topImgBgV fontSize:18 alignment:NSTextAlignmentCenter textColor:k_color_515151];
    titleLB.text = @"我的设备";
    titleLB.frame = CGRectMake(backBt.right, 20, _k_w-50-10-46, 44);
    
    UIButton *managerBT = [UIButton bb_btMakeWithSuperV:topImgBgV bgColor:[UIColor clearColor] titleColor:k_color_appOrange titleFontSize:14 title:@"管理员"];
    managerBT.frame = CGRectMake(_k_w-10-46, 20, 56, 44);
    [managerBT addTarget:self action:@selector(toGoManagersAction) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat bedImgW = 63;
    CGFloat bedImgH = 47;
    CGFloat bedImgX = (_k_w-bedImgW)/2;
    CGFloat bingingDeviceY = topImgBgV.bottom-30;
    CGFloat bedImgY = 64+(bingingDeviceY-64-bedImgH)/2;
    
    //床图片
    UIImageView *bedImgV = [UIImageView bb_imgVMakeWithSuperV:topImgBgV imgName:@"crib"];
    bedImgV.frame = CGRectMake(bedImgX, bedImgY, bedImgW, bedImgH);
    
    //绑定设备
    UIView *bingingDeviceBgV = [[UIView alloc]initWithFrame:CGRectMake(0, bingingDeviceY, _k_w, 58)];
    bingingDeviceBgV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bingingDeviceBgV];
    UILabel *leftBingingLB = [UILabel bb_lbMakeWithSuperV:bingingDeviceBgV fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    leftBingingLB.text = @"您还尚未绑定婴儿床";
    leftBingingLB.frame = CGRectMake(10, 9, _k_w-10-10-80, 40);
    
    QMUIFillButton *binding = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [bingingDeviceBgV addSubview:binding];
    binding.frame = CGRectMake(_k_w-80-10, 16, 74, 26);
    binding.titleLabel.font = [UIFont systemFontOfSize:16];
    binding.fillColor = k_color_appOrange;
    binding.titleTextColor = [UIColor whiteColor];
    [binding setTitle:@"去绑定" forState:UIControlStateNormal];
    [binding addTarget:self action:@selector(toToBinding) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat tableY = bingingDeviceBgV.bottom;
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectMake(0, tableY, _k_w, _k_h-tableY) delegate:self bgColor:k_color_vcBg style:UITableViewStyleGrouped];
}
-(void)toToBinding
{
#warning todo
}

-(void)toGoManagersAction
{
    [QMUITips showWithText:@"点击管理员"];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (BBUserDeviceHelpers.hasBindTB || BBUserDeviceHelpers.hasBindTW || BBUserDeviceHelpers.hasBindWD) {
        return 2;
    }
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.deviceMessageTitles.count;
    }else if (section == 1){
        return self.sensors.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBMyDevieceCell *cell = [BBMyDevieceCell bb_cellMakeWithTableView:tableView];
    if (indexPath.section == 0) {
        if (self.deviceMessageTitles.count > indexPath.row) {
            [cell setupCellWithIndexPath:indexPath leftTitle:self.deviceMessageTitles[indexPath.row]];
        }
    }else{
        if (self.sensors.count > indexPath.row) {
            [cell setupCellWithIndexPath:indexPath leftTitle:self.sensors[indexPath.row]];
        }
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 50)];
    headerV.backgroundColor = [UIColor clearColor];
    UILabel *titleLB = [UILabel bb_lbMakeWithSuperV:headerV fontSize:16 alignment:NSTextAlignmentLeft textColor:rgb(102, 102, 102, 1)];
    titleLB.frame = CGRectMake(10, 10, _k_w-20, 40);
    titleLB.backgroundColor = [UIColor clearColor];
    
#warning todo
    if (section == 0) {
        titleLB.text = @"基本信息";
    }else{
        titleLB.text = @"已绑定传感器";
    }
    
    return headerV;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}

-(NSMutableArray *)deviceMessageTitles
{
    if (!_deviceMessageTitles) {
        _deviceMessageTitles = [NSMutableArray array];
    }
    return _deviceMessageTitles;
}
-(NSMutableArray *)sensors
{
    if (!_sensors) {
        _sensors = [NSMutableArray array];
    }
    return _sensors;
}

@end
