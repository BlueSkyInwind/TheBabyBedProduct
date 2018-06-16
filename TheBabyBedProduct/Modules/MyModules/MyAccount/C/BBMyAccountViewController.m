//
//  BBMyAccountViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/30.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMyAccountViewController.h"
#import "BBMyAccountExpenceRecordListCell.h"
#import "BBConsumeRecord.h"
#import "LYEmptyViewHeader.h"
#import "BBMyBalanceViewController.h"

@interface BBMyAccountViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
/** 消费记录数组 */
@property(nonatomic,strong) NSMutableArray *expenceRecords;

/** 当前页码 从1开始*/
@property(nonatomic,assign)NSInteger currentPage;
/** 是否正在刷新 */
@property(nonatomic,assign)BOOL isRefreshing;
/** 是否正在加载更多 */
@property(nonatomic,assign)BOOL isLoadMoreing;
/** 总数 */
@property(nonatomic,assign)NSInteger totalCount;

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
    
    self.currentPage = 0;
    self.isRefreshing = NO;
    self.isLoadMoreing = NO;
    self.totalCount = 0;
    
    [self creatUI];
    
}
-(void)getCurListData
{
    [self.tableView ly_startLoading];
    [BBRequestTool bb_requestCurListWithPageNo:self.currentPage pageSize:10 SuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"我的账户 %@",object);
        BBConsumeRecordListResult *result = [BBConsumeRecordListResult mj_objectWithKeyValues:object];
        if (result.code == 0) {
            [self.expenceRecords addObjectsFromArray:result.data];
            self.totalCount = result.count;
            [self.tableView reloadData];
            [self _endRefreshing];
        }else{
            [QMUITips showWithText:result.msg inView:self.view hideAfterDelay:1.5];
            [self _endRefreshing];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"我的账户 22 %@",object);
        [self _endRefreshing];
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

    UILabel *accountSurplusLB = [UILabel bb_lbMakeWithSuperV:topView fontSize:16 alignment:NSTextAlignmentCenter textColor:k_color_515151];
    #warning todo 账户余额
    NSNumber *surplusCount = BBUserHelpers.price;
    if ([surplusCount floatValue]) {
        accountSurplusLB.text = [NSString stringWithFormat:@"%@",surplusCount];
    }else{
        accountSurplusLB.text = @"--";
    }
    
    imgV.frame = CGRectMake(imgX, topMargin, imgW, imgH);
    accountSurplusTextLB.frame = CGRectMake(0, imgV.bottom+5, _k_w, 20);
    accountSurplusLB.frame = CGRectMake(0, accountSurplusTextLB.bottom+5, _k_w, 20);
    
    [self creatTableViewUI];
}

-(void)creatTableViewUI
{
    CGFloat tabVY = 64+96;
    CGFloat bottomH = 67;
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectFlatMake(0, tabVY, _k_w, _k_h-tabVY-bottomH) delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 10)];
    headerV.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = headerV;
    
    //下拉刷新
    self.tableView.mj_header = [UITableView pp_headerForNomaWithTarget:self action:@selector(_headerRefreshAction) hasLastDate:NO enterStartRefresh:NO];
     [self.tableView.mj_header beginRefreshing];
    
    //上拉加载
    self.tableView.mj_footer = [UITableView pp_footerForAutoNormalWithTarger:self action:@selector(_loadMoreDataAction)];
    
    self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:nil titleStr:@"未查询到您的相关消费记录" detailStr:@"你可以充值、观看视频消费后再来看一看"];
    self.tableView.ly_emptyView.autoShowEmptyView = NO;
    
    
    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, _k_h-67, _k_w, 67)];
    bottomV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomV];
    
    //登录
    QMUIFillButton *rechargeBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [bottomV addSubview:rechargeBT];
    rechargeBT.titleLabel.font = [UIFont systemFontOfSize:18];
    rechargeBT.fillColor = rgb(255, 236, 183, 0.5);
    rechargeBT.titleTextColor = k_color_515151;
    [rechargeBT setTitle:@"充  值" forState:UIControlStateNormal];
    rechargeBT.frame = CGRectMake(30, 10, _k_w-30*2, 47);
    [rechargeBT addTarget:self action:@selector(toRechatge) forControlEvents:UIControlEventTouchUpInside];
    
    
}
#pragma mark --- 下拉刷新事件
-(void)_headerRefreshAction
{
    if (_isRefreshing || _isLoadMoreing) {
        [self _endRefreshing];
        return;
    }else{
        [self.expenceRecords removeAllObjects];
        [self.tableView reloadData];
        self.isRefreshing = YES;
        self.isLoadMoreing = NO;
        self.currentPage = 0;
        self.totalCount = 0;
        [self getCurListData];
    }
}
-(void)_loadMoreDataAction
{
    if (_isRefreshing || _isLoadMoreing) {
        [self _endRefreshing];
        return;
    }else{
        self.isLoadMoreing = YES;
        self.isRefreshing = NO;
        self.currentPage += 1;
        [self getCurListData];
    }
}
#pragma mark 结束刷新
- (void)_endRefreshing
{
    
    self.isRefreshing = NO;
    self.isLoadMoreing = NO;
    [self.tableView.mj_header endRefreshing];
    if (self.expenceRecords.count >= self.totalCount && self.totalCount > 0) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];//已加载全部
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
    [self.tableView ly_endLoading];
}
#pragma mark --- 点击“充值”
-(void)toRechatge
{
    BBMyBalanceViewController *balanceVC = [[BBMyBalanceViewController alloc]init];
    [self.navigationController pushViewController:balanceVC animated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _expenceRecords.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBMyAccountExpenceRecordListCell *cell = [BBMyAccountExpenceRecordListCell bb_cellMakeWithTableView:tableView];
    if (self.expenceRecords.count > indexPath.row) {
        [cell setupCellWithConsumeRecord:self.expenceRecords[indexPath.row]];
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
