//
//  BBNotificationSettingViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBNotificationSettingViewController.h"
#import "BBNotificationSettingListCell.h"
#import "BBWarningRingSettingViewController.h"

@interface BBNotificationSettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *titles;
@end

@implementation BBNotificationSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = k_color_vcBg;
    self.titleStr = @"通知设置";
    [self creatUI];
}
-(void)creatUI
{
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectMake(0, PPDevice_navBarHeight, _k_w, _k_h-PPDevice_navBarHeight) delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return self.titles.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 64;
    }
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *v = [UIView new];
        v.backgroundColor = [UIColor clearColor];
        UILabel *recommenderLB = [UILabel bb_lbMakeWithSuperV:v fontSize:13 alignment:NSTextAlignmentCenter textColor:k_color_153153153];
        recommenderLB.numberOfLines = 0;
        NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc]initWithString:@"您关闭通知将不能及时接收宝宝信息\n在“设置”-“通知”功能中，找到程序APP进行更改"];
        [mutStr pp_setLineSpacing:4];
        recommenderLB.attributedText = mutStr;
        recommenderLB.textAlignment = NSTextAlignmentCenter;
        [v addSubview:recommenderLB];
        recommenderLB.frame = CGRectMake(0, 0, _k_w, 52);
        return v;
    }
    return nil;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBNotificationSettingListCell *cell = [BBNotificationSettingListCell bb_cellMakeWithTableView:tableView];
    if (indexPath.section == 0) {
        [cell setupCellStyle:BBNotificationSettingListCellStyleArrow title:@"微信接收报警通知"];
    }else{
        if (self.titles.count > indexPath.row) {
            NSString *title = self.titles[indexPath.row];
            if ([title isEqualToString:@"声音"]) {
                [cell setupCellStyle:BBNotificationSettingListCellStyleArrow title:title];
            }else{
                [cell setupCellStyle:BBNotificationSettingListCellStyleSwitch title:title];
            }
        }
    }
    return cell;
}
-(NSArray *)titles
{
    if (!_titles) {
        _titles = @[@"报警模块设置",@"声音",@"报警模块设置",@"体温报警",@"尿湿报警",@"踢被报警",@"哭闹报警"];
    }
    return _titles;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 1) {
        BBWarningRingSettingViewController *setRingVC = [[BBWarningRingSettingViewController alloc]init];
        [self.navigationController pushViewController:setRingVC animated:YES];
    }
}
@end
