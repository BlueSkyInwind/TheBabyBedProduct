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
#import "BBDeviceHeaderBottomView.h"

@interface BBMyDeviceViewController ()
@property(nonatomic,strong) UITableView *tableView;
/** 设备信息title数组 */
@property(nonatomic,strong) NSMutableArray *deviceMessageTitles;
/** 已连接的传感器数组 */
@property(nonatomic,strong) NSMutableArray *sensors;
@property(nonatomic,strong) BBDeviceHeaderBottomView *headerBottomView;
@end

@implementation BBMyDeviceViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的设备";
    self.view.backgroundColor = k_color_vcBg;
    
    [self.deviceMessageTitles addObjectsFromArray:@[@"设备状态",@"设备型号",@"硬件版本",@"设备ID"]];
    
    [self creatUI];
    
    BBUserDevice *device = [BBUserDevice bb_getUserDevice];
    if ([device.deviceId bb_isSafe]) {
        [self.headerBottomView updateDeviceHBView];
        [self setupSensorsWithDevice:device];
    }else{
        [self getMyDeviceData];
    }
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
            
            [self setupSensorsWithDevice:userDevice];
            [self.headerBottomView updateDeviceHBView];
            [self.tableView reloadData];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
    }];
}
-(void)setupSensorsWithDevice:(BBUserDevice *)device
{
    if ([device.bindTB isEqualToString:@"1"]) {
        [self.sensors addObject:@"踢被传感器"];
    }
    if ([device.bindTW isEqualToString:@"1"]) {
        [self.sensors addObject:@"体温传感器"];
    }
    if ([device.bindWD isEqualToString:@"1"]) {
        [self.sensors addObject:@"温度传感器"];
    }
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
    self.headerBottomView = [[BBDeviceHeaderBottomView alloc]initWithFrame:CGRectMake(0, bingingDeviceY, _k_w, 58)];
    self.headerBottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.headerBottomView];

    BBWeakSelf(self)
    self.headerBottomView.bingingOrCancelBlock = ^(NSString *deviceId) {
        if (deviceId) {
            //已经绑定了，要解绑
            BBStrongSelf(self)
            [self toCancelBinding];
        }else{
#warning todo pp

        }
    };
    
    CGFloat tableY = self.headerBottomView.bottom;
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectMake(0, tableY, _k_w, _k_h-tableY) delegate:self bgColor:k_color_vcBg style:UITableViewStyleGrouped];
}
-(void)toCancelBinding
{
    UIAlertController *alertC = [UIAlertController bb_alertControllerMakeForAlertCancelAndOKWithTitle:@"确定要解除已绑定设备吗？" message:nil OKHandler:^(UIAlertAction *action) {
        
        //退出绑定，需要本地清空设备信息
        BBUserDevice *device = [[BBUserDevice alloc]init];
        device.deviceId = nil;  //保险起见，还是加上
        [BBUserDevice bb_saveUserDevice:device];
        
        [self.headerBottomView updateDeviceHBView];
        [self.tableView reloadData];
        
        [QMUITips showWithText:@"您已解除绑定"];
    }];
    [self presentViewController:alertC animated:YES completion:nil];
}

-(void)toGoManagersAction
{
#warning todo pp
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
            cell.deleteSensorBlock = ^(BBMyDevieceCellBindingType bindingType) {
                [self toDeleteSensor:bindingType];
            };
        }
    }
    return cell;
}
-(void)toDeleteSensor:(BBMyDevieceCellBindingType)bindingType
{
#warning todo
    
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
