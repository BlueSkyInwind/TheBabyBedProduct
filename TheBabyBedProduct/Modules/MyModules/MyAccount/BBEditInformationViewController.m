//
//  BBEditInformationViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/30.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBEditInformationViewController.h"
#import "BBEditInfoAvatarCell.h"
#import "BBNotificationSettingListCell.h"

@interface BBEditInformationViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *_babayName;
}
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray<NSString *> *titles;
@end

@implementation BBEditInformationViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_color_vcBg;
    self.title = @"编辑资料";
    
    [self creatUI];
}
-(void)creatUI
{
    if (self.comesFrom == BBEditInformationVCComesFromRegistSuccess) {
        UIButton *skipBt = [UIButton bb_btMakeWithSuperV:nil bgColor:nil titleColor:k_color_appOrange titleFontSize:12 title:@"跳过"];
        skipBt.layer.masksToBounds = YES;
        skipBt.frame = CGRectMake(0, 0, 35, 35);
        skipBt.layer.cornerRadius = 17.5;
        skipBt.layer.borderWidth = 1.2;
        skipBt.layer.borderColor = k_color_appOrange.CGColor;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:skipBt];
        [skipBt addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    }
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:self.view.bounds delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 87)];
    self.tableView.tableFooterView = v;
    v.backgroundColor = [UIColor clearColor];

    QMUIFillButton *saveBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [v addSubview:saveBT];
    saveBT.frame = CGRectMake(40, 20, _k_w-80, 47);
    saveBT.titleLabel.font = [UIFont systemFontOfSize:18];
    saveBT.fillColor = rgb(255, 236, 183, 1);
    saveBT.titleTextColor = k_color_515151;
    [saveBT setTitle:@"保  存" forState:UIControlStateNormal];
    [saveBT addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)skipAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.skipBlock) {
        self.skipBlock();
    }
}
-(void)saveAction
{
#warning todo 
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 84;
    }
    return 47;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        BBEditInfoAvatarCell *cell = [BBEditInfoAvatarCell bb_cellMakeWithTableView:tableView];
        [cell setupCellAvatar:nil];
        return cell;
    }else{
        BBNotificationSettingListCell *cell = [BBNotificationSettingListCell bb_cellMakeWithTableView:tableView];
        if (self.titles.count > indexPath.row) {
            [cell setupCellStyle:BBNotificationSettingListCellStyleEditInformation title:self.titles[indexPath.row]];
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            
        }
            break;
            
        case 1:
        {
            //宝宝姓名
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"宝宝姓名" message:@"请填写您的宝宝的姓名" preferredStyle:UIAlertControllerStyleAlert];
            [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                DLog(@"%@",textField.text);
            }];
            UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *OKAlertAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [self updateBabyName:indexPath];
            }];
            
            [alertC addAction:cancelAlertAction];
            [alertC addAction:OKAlertAction];
            [self presentViewController:alertC animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}

-(void)updateBabyName:(NSIndexPath *)indexPath
{
    BBNotificationSettingListCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.subTextLB.text = _babayName;
}

-(NSArray<NSString *> *)titles
{
    if (!_titles) {
        _titles = @[@"头像",@"宝宝姓名",@"性别",@"所在地",@"出生日期",@"身份"];
    }
    return _titles;
}

@end
