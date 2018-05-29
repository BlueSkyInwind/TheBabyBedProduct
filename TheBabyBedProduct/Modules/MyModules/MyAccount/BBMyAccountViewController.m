//
//  BBMyAccountViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/30.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMyAccountViewController.h"
#import "BBMyAccountExpenceRecordListCell.h"

@interface BBMyAccountViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
/** 消费记录数组 */
@property(nonatomic,strong) NSMutableArray *expenceRecords;
@end

@implementation BBMyAccountViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_color_vcBg;
    self.title = @"我的账户";
    [self getCurListData];
    [self creatUI];
    
}
-(void)getCurListData
{
    [BBRequestTool bb_requestCurListWithPageNo:0 pageSize:10 SuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"我的账户 %@",object);
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"我的账户 22 %@",object);
    }];
}
-(void)creatUI
{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, _k_w, 96)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    CGFloat imgW = 63/2;
    CGFloat imgH = 36/2;
    CGFloat imgX = (_k_w-imgW)/2;
    CGFloat topMargin = 10;
    
    UIImageView *imgV = [UIImageView bb_imgVMakeWithSuperV:topView imgName:@"balance"];
    UILabel *accountSurplusTextLB = [UILabel bb_lbMakeWithSuperV:topView fontSize:16 alignment:NSTextAlignmentCenter textColor:k_color_515151];
    accountSurplusTextLB.text = @"账户余额";
#warning todo 账户余额
    UILabel *accountSurplusLB = [UILabel bb_lbMakeWithSuperV:topView fontSize:16 alignment:NSTextAlignmentCenter textColor:k_color_515151];
    accountSurplusLB.text = @"30";
    
    imgV.frame = CGRectMake(imgX, topMargin, imgW, imgH);
    accountSurplusTextLB.frame = CGRectMake(0, imgV.bottom, _k_w, 20);
    accountSurplusLB.frame = CGRectMake(0, accountSurplusTextLB.bottom, _k_w, 20);
    
    [self creatTableViewUI];
}
-(void)creatTableViewUI
{
    CGFloat tabVY = 64+96;
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectFlatMake(0, tabVY, _k_w, _k_h-tabVY) delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 10)];
    headerV.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerV;
    
    UIView *footerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 280)];
    footerV.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footerV;
    
    //登录
    QMUIFillButton *rechargeBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [footerV addSubview:rechargeBT];
    rechargeBT.titleLabel.font = [UIFont systemFontOfSize:18];
    rechargeBT.fillColor = rgb(255, 236, 183, 0.5);
    rechargeBT.titleTextColor = k_color_515151;
    [rechargeBT setTitle:@"充  值" forState:UIControlStateNormal];
    rechargeBT.frame = CGRectMake(30, 150, _k_w-30*2, 47);
    [rechargeBT addTarget:self action:@selector(toRechatge) forControlEvents:UIControlEventTouchUpInside];
    
    
}
#pragma mark --- 点击“充值”
-(void)toRechatge
{
    [QMUITips showInfo:@"充值后续完善"];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return _expenceRecords.count;
#warning todo
    return 8;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBMyAccountExpenceRecordListCell *cell = [BBMyAccountExpenceRecordListCell bb_cellMakeWithTableView:tableView];
    if (self.expenceRecords.count > indexPath.row) {
#warning todo
        
    }
    return cell;
}
-(NSMutableArray *)expenceRecords
{
    if (!_expenceRecords) {
        _expenceRecords = [NSMutableArray array];
    }
    return _expenceRecords;
}
@end
