//
//  MyViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "MyViewController.h"
#import "BBMyListCell.h"
#import "BBMyHeaderView.h"
#import "BBLoginAndRegistViewController.h"
#import "BBSettingViewController.h"
#import "BBHelpAndSuggestionViewController.h"
#import "BBMyDeviceViewController.h"
#import "BBMyAccountViewController.h"
#import "BBFamilyMemberViewController.h"
#import "BBMyRewardViewController.h"
#import "BBEditInformationViewController.h"

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
    
    headerV.avatarClickedBlock = ^{
        BBEditInformationViewController *editVC = [[BBEditInformationViewController alloc]init];
        [self.navigationController pushViewController:editVC animated:YES];
    };
    
    headerV.loginOrRegistBlock = ^(BBMyHeaderView *headerV) {
        //登录/注册
        [self bb_goLoginRegistVC:^(BOOL isSuccess) {
            if (isSuccess) {
                [headerV updateUserMess];
            }
        }];
    };
    
    headerV.funcBlock = ^(BBMyHeaderViewFuncType funcType) {
        [self handleFuncAction:funcType];
    };
    

    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectMake(0, 264, _k_w, _k_h-49-264) delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    self.tableView.scrollEnabled = NO;
    
}
-(void)handleFuncAction:(BBMyHeaderViewFuncType)funcType
{
    switch (funcType) {
        case BBMyHeaderViewFuncTypeMyAccount:
        {
            BBMyAccountViewController *myAccountVC = [[BBMyAccountViewController alloc] init];
            [self.navigationController pushViewController:myAccountVC animated:YES];
        }
            break;
            case BBMyHeaderViewFuncTypeMyDevice:
        {
            BBMyDeviceViewController *deviceVC = [[BBMyDeviceViewController alloc]init];
            [self.navigationController pushViewController:deviceVC animated:YES];
        }
            break;
            case BBMyHeaderViewFuncTypeFamilyMember:
        {
            BBFamilyMemberViewController *familyMemberVC = [[BBFamilyMemberViewController alloc]init];
            [self.navigationController pushViewController:familyMemberVC animated:YES];
        }
            
        default:
            break;
    }
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
    NSArray *imgs = @[
                      @"gliwu",
                      @"gwenjian",
                      @"gshezhi"
                      ];
    
    NSArray *titles = @[
                        @"任务奖励",
                        @"帮助意见",
                        @"设置"
                        ];
    BBMyListCell *cell = [BBMyListCell bb_cellMakeWithTableView:tableView];
    if (imgs.count > indexPath.row) {
        [cell setupCellWithImgName:imgs[indexPath.row] title:titles[indexPath.row]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //任务奖励
        BBMyRewardViewController *myRewardVC = [[BBMyRewardViewController alloc]init];
        [self.navigationController pushViewController:myRewardVC animated:YES];
    }else if (indexPath.row == 1){
        //帮助建议
        BBHelpAndSuggestionViewController *helpSuggestionVC = [[BBHelpAndSuggestionViewController alloc]init];
        [self.navigationController pushViewController:helpSuggestionVC animated:YES];
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

