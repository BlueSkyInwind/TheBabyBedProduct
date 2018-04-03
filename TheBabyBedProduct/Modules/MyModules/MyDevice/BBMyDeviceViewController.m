//
//  BBMyDeviceViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/29.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMyDeviceViewController.h"

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
    self.title = @"我的小雅智能";
    self.view.backgroundColor = k_color_vcBg;
    
//    [self creatUI];
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatUI
{
    UIImageView *topImgBgV = [UIImageView bb_imgVMakeWithSuperV:self.view imgName:@"console_header_Icon"];
    topImgBgV.frame = CGRectMake(0, 0, _k_w, 436);
    topImgBgV.userInteractionEnabled = YES;
    
    UIButton *backBt = [UIButton bb_btMakeWithSuperV:topImgBgV imageName:@"cryingChooseDate_left_Icon"];
    backBt.frame = CGRectMake(0, 20, 50, 44);
    [backBt addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat tableY = topImgBgV.bottom-50;
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectMake(0, tableY, _k_w, _k_h-tableY) delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning todo 没有绑定为1
    return 2;
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
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}
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
