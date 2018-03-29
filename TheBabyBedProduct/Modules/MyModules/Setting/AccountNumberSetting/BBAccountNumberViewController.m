//
//  BBAccountNumberViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBAccountNumberViewController.h"
#import "UITableView+EasilyMake.h"
#import "BBAcountNumberListCell.h"
#import "UITableViewCell+EasilyMake.h"
#import "UILabel+EasilyMake.h"
@interface BBAccountNumberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray *settings;
@property(nonatomic,strong) NSArray *accountNumbers;
@end

@implementation BBAccountNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = k_color_vcBg;
    
    [self creatUI];
}
-(void)creatUI
{
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:self.view.bounds delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    
    UIView *fotterV = [[UIView alloc]init];
    self.tableView.tableFooterView = fotterV;
    
    UILabel *currentVersionLB = [UILabel bb_lbMakeWithSuperV:fotterV fontSize:14 alignment:NSTextAlignmentCenter textColor:k_color_515151];
    currentVersionLB.text = [NSString stringWithFormat:@"当前版本%@",[GlobalTool getAppVersion]];
    currentVersionLB.frame = CGRectMake(0, 0, _k_w, 20);
    
    if (!BBUserHelpers.hasLogined) {
        QMUIFillButton *signOutBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
        [fotterV addSubview:signOutBT];
        signOutBT.titleLabel.font = [UIFont systemFontOfSize:18];
        signOutBT.fillColor = rgb(255, 236, 183, 1);
        signOutBT.titleTextColor = k_color_515151;
        [signOutBT setTitle:@"退出登录" forState:UIControlStateNormal];
        signOutBT.frame = CGRectMake(40, 20+5, _k_w-80, 44);
        signOutBT.userInteractionEnabled = NO;
        [signOutBT addTarget:self action:@selector(signOutAction) forControlEvents:UIControlEventTouchUpInside];
        fotterV.frame = CGRectMake(0, 0, _k_w, 20+44+5);

    }else{
        fotterV.frame = CGRectMake(0, 0, _k_w, 20);
    }
}
-(void)signOutAction
{
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.settings.count;
    }
    return self.accountNumbers.count;
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
        return 60;
    }
    return 100;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor clearColor];
    UILabel *recommenderLB = [UILabel bb_lbMakeWithSuperV:v fontSize:12 alignment:NSTextAlignmentCenter textColor:k_color_153153153];
    recommenderLB.textAlignment = NSTextAlignmentCenter;
    [v addSubview:recommenderLB];
    if (section == 0) {
        recommenderLB.frame = CGRectMake(0, 0, _k_w, 32);
        recommenderLB.text = @"设置以后可通过手机号加密登录";
    }else{
        recommenderLB.frame = CGRectMake(0, 0, _k_w, 36);
        recommenderLB.text = @"绑定微信账号更方便收到告警信息，快捷不错过";
    }
    return v;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBAcountNumberListCell *cell = [BBAcountNumberListCell bb_cellMakeWithTableView:tableView];
    if (indexPath.section == 0) {
        [cell setupCellWithTitle:self.settings[indexPath.row]];
    }else{
        [cell setupCellWithTitle:self.accountNumbers[indexPath.row]];
    }
    return cell;
}


-(NSArray *)settings
{
    if (!_settings) {
        _settings = @[@"手机号码",@"登录密码"];
    }
    return _settings;
}
-(NSArray *)accountNumbers
{
    if (!_accountNumbers) {
        _accountNumbers = @[@"微信账号",@"QQ账号",@"微博账号"];
    }
    return _accountNumbers;
}

@end
