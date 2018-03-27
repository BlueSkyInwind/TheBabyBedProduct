//
//  MyViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "MyViewController.h"
#import "BBMyListCell.h"
#import "UITableView+EasilyMake.h"
#import "UITableViewCell+EasilyMake.h"
#import "BBMyHeaderView.h"
#import "BBLoginAndRegistViewController.h"
#import "BBSettingViewController.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation MyViewController
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self creatUI];
}
-(void)creatUI
{

    BBMyHeaderView *headerV = [[BBMyHeaderView alloc]initWithFrame:CGRectMake(0, -20, _k_w, 264+20) user:nil];
    [self.view addSubview:headerV];

    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectMake(0, 264, _k_w, _k_h-49-264) delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    self.tableView.scrollEnabled = NO;
    
}
-(void)btnAction
{
    BBLoginAndRegistViewController *loginRegistVC = [[BBLoginAndRegistViewController alloc]init];
    [self presentViewController:loginRegistVC animated:YES completion:nil];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBMyListCell *cell = [BBMyListCell bb_cellMakeWithTableView:tableView];
    [cell setupCellWithRow:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //
    }else if (indexPath.row == 1){
        //
    }else{
       //设置
        BBSettingViewController *settingVC = [[BBSettingViewController alloc]init];
        [self.navigationController pushViewController:settingVC animated:YES];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

@end

