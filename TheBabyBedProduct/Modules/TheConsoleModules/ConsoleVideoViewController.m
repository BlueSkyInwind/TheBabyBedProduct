//
//  ConsoleVideoViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/11.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ConsoleVideoViewController.h"
#import "BBFamilyMember.h"
#import "BBFamilyMemberListCell.h"

@interface ConsoleVideoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *talbeView;
/** 当前页码 从0开始*/
@property(nonatomic,assign)NSInteger currentPage;
/** 是否正在刷新 */
@property(nonatomic,assign)BOOL isRefreshing;
/** 是否正在加载更多 */
@property(nonatomic,assign)BOOL isLoadMore;
/** 总数 */
@property(nonatomic,assign)NSInteger totalCount;
@property(nonatomic,strong) NSMutableArray<BBFamilyMember *> *applyingUsers;
@end

@implementation ConsoleVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"视频";
    self.currentPage = 0;
    self.isRefreshing = NO;
    self.isLoadMore = NO;
    self.totalCount = 0;
    
    [self addBackItem];
    [self creatUI];
    [self getVideoApplyListData];
}
-(void)getVideoApplyListData
{
    [self.talbeView ly_startLoading];
    [BBRequestTool bb_requestApplyListWithApplyType:BBApplyTypeVideo pageNo:self.currentPage pageSize:10 SuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"apply list 1 %@",object);
        BBFamilyMemberListResult *result = [BBFamilyMemberListResult mj_objectWithKeyValues:object];
        if (result.code == 0) {
            [self.applyingUsers addObjectsFromArray:result.data];
            self.totalCount = result.count;
        }else{
            [QMUITips showWithText:result.msg inView:self.view hideAfterDelay:1.2];
        }
        [self.talbeView reloadData];
        [self _endRefreshing];
        [self.talbeView ly_endLoading];
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"apply list 2 %@",object);
        [self.talbeView reloadData];
        [self _endRefreshing];
        [self.talbeView ly_endLoading];
    }];
}

-(void)creatUI
{
    self.talbeView = [UITableView bb_tableVMakeWithSuperV:self.view frame:self.view.bounds delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    //下拉刷新
    self.talbeView.mj_header = [UITableView pp_headerForNomaWithTarget:self action:@selector(_headerRefreshAction) hasLastDate:NO enterStartRefresh:NO];
    
    //上拉加载
    self.talbeView.mj_footer = [UITableView pp_footerForAutoNormalWithTarger:self action:@selector(_bottomLoadMoreDataAction)];
    self.talbeView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:nil titleStr:@"还没有家庭成员申请视频观看权限" detailStr:@"你可以去邀请家庭成员绑定哦~"];
    self.talbeView.ly_emptyView.autoShowEmptyView = NO;
    
    //设置tableVheader
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, PPHeight(280))];
    headerV.backgroundColor = [UIColor redColor];
    self.talbeView.tableHeaderView = headerV;
    
}
-(void)_headerRefreshAction
{
    if (self.isRefreshing || self.isLoadMore) {
        [self _endRefreshing];
        return;
    }else{
        [self.applyingUsers removeAllObjects];
        [self.talbeView reloadData];
        self.isRefreshing = YES;
        self.isLoadMore = NO;
        self.currentPage = 0;
        self.totalCount = 0;
        [self getVideoApplyListData];
    }
}
-(void)_bottomLoadMoreDataAction
{
    if (self.isRefreshing || self.isLoadMore) {
        [self _endRefreshing];
        return;
    }else{
        self.isLoadMore = YES;
        self.isRefreshing = NO;
        if (self.applyingUsers.count >= self.totalCount && self.totalCount > 0) {
            [self.talbeView.mj_footer endRefreshingWithNoMoreData];//已加载全部
            return;
        }
        self.currentPage += 1;
        [self getVideoApplyListData];
    }
}
-(void)_endRefreshing
{
    self.isRefreshing = NO;
    self.isLoadMore = NO;
    [self.talbeView.mj_header endRefreshing];
    [self.talbeView.mj_footer endRefreshing];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.applyingUsers.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBFamilyMemberListCell *cell = [BBFamilyMemberListCell bb_cellMakeWithTableView:tableView];
    if (self.applyingUsers.count > indexPath.row) {
        [cell setupWithFamilyMember:self.applyingUsers[indexPath.row] applyType:BBApplyTypeVideo];
    }
    cell.setOrAgreeBlock = ^(BOOL isSetting) {
        NSLog(@"%@--%ld",isSetting?@"设置":@"同意",(long)indexPath.row);
        [self changeApplyStatusWithFamilyMember:self.applyingUsers[indexPath.row]];
    };
    
    cell.refuseBlock = ^{
#warning todo 拒绝
    };
    return cell;
}
-(void)changeApplyStatusWithFamilyMember:(BBFamilyMember *)familyMember
{
    if (![familyMember.memberID bb_isSafe]) {
        [QMUITips showInfo:@"获取成员信息失败，稍后再试！" inView:self.view hideAfterDelay:2];
        return;
    }
    [BBRequestTool bb_requestChangeStatusWithFamilyMemberId:familyMember.memberID status:BBApplyStatusAgree successBlock:^(EnumServerStatus status, id object) {
        NSLog(@"changestatus success %@",object);
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"changestatus fail %@",object);

    }];
}


-(NSMutableArray<BBFamilyMember *> *)applyingUsers
{
    if (!_applyingUsers) {
        _applyingUsers = [NSMutableArray array];
    }
    return _applyingUsers;
}
@end
