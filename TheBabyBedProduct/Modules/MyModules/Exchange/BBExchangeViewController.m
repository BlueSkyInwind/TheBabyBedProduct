//
//  BBExchangeViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/18.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBExchangeViewController.h"
#import "BBExchangeList.h"
#import "LYEmptyViewHeader.h"
#import "BBExchangeListCell.h"

@interface BBExchangeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
/** 消费记录数组 */
@property(nonatomic,strong) NSMutableArray *exchanges;
/** 当前页码 从1开始*/
@property(nonatomic,assign)NSInteger currentPage;
/** 是否正在刷新 */
@property(nonatomic,assign)BOOL isRefreshing;
/** 是否正在加载更多 */
@property(nonatomic,assign)BOOL isLoadMoreing;
/** 总数 */
@property(nonatomic,assign)NSInteger totalCount;
@end

@implementation BBExchangeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = k_color_vcBg;
    self.titleStr = @"积分兑换列表";
    self.currentPage = 0;
    self.isRefreshing = NO;
    self.isLoadMoreing = NO;
    self.totalCount = 0;
    [self creatUI];
}
-(void)creatUI
{
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectMake(0, PPDevice_navBarHeight, _k_w, _k_h-PPDevice_navBarHeight) delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    //下拉刷新
    self.tableView.mj_header = [UITableView pp_headerForNomaWithTarget:self action:@selector(_headerRefreshAction) hasLastDate:NO enterStartRefresh:NO];
    [self.tableView.mj_header beginRefreshing];
    
    //上拉加载
    self.tableView.mj_footer = [UITableView pp_footerForAutoNormalWithTarger:self action:@selector(_loadMoreDataAction)];
    
    self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:nil titleStr:@"未查询到您的相关积分兑换记录" detailStr:nil];
    self.tableView.ly_emptyView.autoShowEmptyView = NO;
}
#pragma mark --- 下拉刷新事件
-(void)_headerRefreshAction
{
    if (_isRefreshing || _isLoadMoreing) {
        [self _endRefreshing];
        return;
    }else{
        [self.exchanges removeAllObjects];
        [self.tableView reloadData];
        self.isRefreshing = YES;
        self.isLoadMoreing = NO;
        self.currentPage = 0;
        self.totalCount = 0;
        [self getExchangeListData];
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
        [self getExchangeListData];
    }
}
#pragma mark 结束刷新
- (void)_endRefreshing
{
    
    self.isRefreshing = NO;
    self.isLoadMoreing = NO;
    [self.tableView.mj_header endRefreshing];
    if (self.exchanges.count >= self.totalCount && self.totalCount > 0) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];//已加载全部
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
    [self.tableView ly_endLoading];
}
-(void)getExchangeListData
{
    [self.tableView ly_startLoading];
    [BBRequestTool bb_requestExchangeListWithPageNo:1 successBlock:^(EnumServerStatus status, id object) {
        NSLog(@"success %@",object);
        BBExchangeListResult *result = [BBExchangeListResult mj_objectWithKeyValues:object];
        if (result.code == 0) {
            [self.exchanges addObjectsFromArray:result.data];
#warning todo pp605
//            self.totalCount = result.count;
            self.totalCount = self.exchanges.count;
            [self.tableView reloadData];
            [self _endRefreshing];
        }else{
            [QMUITips showWithText:result.msg inView:self.view hideAfterDelay:1.5];
            [self _endRefreshing];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"fail %@",object);
        [self _endRefreshing];
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.exchanges.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBExchangeListCell *cell = [BBExchangeListCell bb_cellMakeWithTableView:tableView];
    if (self.exchanges.count > indexPath.row) {
        [cell setupWithExchange:self.exchanges[indexPath.row]];
    }
    return cell;
}

-(NSMutableArray *)exchanges
{
    if (!_exchanges) {
        _exchanges = [NSMutableArray array];
    }
    return _exchanges;
}

@end
