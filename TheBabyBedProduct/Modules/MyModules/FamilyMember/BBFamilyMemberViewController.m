//
//  BBFamilyMemberViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/29.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBFamilyMemberViewController.h"
#import "BBFamilyMemberListCell.h"
//#import "LWShareService.h"
#import "BBPermissionManageViewController.h"
#import "LYEmptyViewHeader.h"
#import "BBFamilyMember.h"
#import "BBInviteFriendsViewController.h"

@interface BBFamilyMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isLeft;
    UIButton *_bingingBT;
    UIButton *_applyRecordBT;
    BOOL _hasLeftLoad;
    BOOL _hasRightLoad;
}
@property(nonatomic,strong) UITableView *leftTableView;
@property(nonatomic,strong) UITableView *rightTableView;
@property(nonatomic,strong) NSMutableArray<BBFamilyMember *> *bindingedUsers;
@property(nonatomic,strong) NSMutableArray<BBFamilyMember *> *applyingUsers;

/** 当前页码 从0开始*/
@property(nonatomic,assign)NSInteger leftCurrentPage;
/** 是否正在刷新 */
@property(nonatomic,assign)BOOL leftIsRefreshing;
/** 是否正在加载更多 */
@property(nonatomic,assign)BOOL leftIsLoadMoreing;
/** 总数 */
@property(nonatomic,assign)NSInteger leftTotalCount;


/** 当前页码 从1开始*/
@property(nonatomic,assign)NSInteger rightCurrentPage;
/** 是否正在刷新 */
@property(nonatomic,assign)BOOL rightIsRefreshing;
/** 是否正在加载更多 */
@property(nonatomic,assign)BOOL rightIsLoadMoreing;
/** 总数 */
@property(nonatomic,assign)NSInteger rightTotalCount;

@end

@implementation BBFamilyMemberViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = k_color_vcBg;
    
    self.title = @"家庭成员";
    
    _hasLeftLoad = NO;
    _hasRightLoad = NO;
    
    self.leftCurrentPage = 0;
    self.leftIsRefreshing = NO;
    self.leftIsLoadMoreing = NO;
    self.leftTotalCount = 0;
    
    self.rightCurrentPage = 0;
    self.rightIsRefreshing = NO;
    self.rightIsLoadMoreing = NO;
    self.rightTotalCount = 0;
    
    _isLeft = YES;
    [self getBindListData];
    [self creatUI];
    
    UIButton *invireBt = [UIButton bb_btMakeWithSuperV:nil bgColor:nil titleColor:k_color_515151 titleFontSize:14 title:@"邀请好友"];
    [invireBt addTarget:self action:@selector(inviteMemberAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:invireBt];
    self.navigationItem.rightBarButtonItem = item;
    
}
#pragma mark --- 获取已绑定用户列表
-(void)getBindListData
{
    _hasLeftLoad = YES;
    [self.leftTableView ly_startLoading];
    [BBRequestTool bb_requestBindListWithPageNo:self.leftCurrentPage pageSize:10 SuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"bind list %@",object);
        BBFamilyMemberListResult *result = [BBFamilyMemberListResult mj_objectWithKeyValues:object];
        if (result.code == 0) {
            [self.bindingedUsers addObjectsFromArray:result.data];
            self.leftTotalCount = result.count;
        }else{
            [QMUITips showWithText:result.msg inView:self.view hideAfterDelay:1.2];
        }
        [self.leftTableView reloadData];
        [self _endRefreshing];
        [self.leftTableView ly_endLoading];
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"bind list %@",object);
        [self.leftTableView reloadData];
        [self _endRefreshing];
        [self.leftTableView ly_endLoading];
    }];
}
-(void)getApplyListData
{
    _hasRightLoad = YES;
    [self.rightTableView ly_startLoading];
    [BBRequestTool bb_requestApplyListWithApplyType:BBApplyTypeBind pageNo:self.rightCurrentPage pageSize:10 SuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"apply list 1 %@",object);
        BBFamilyMemberListResult *result = [BBFamilyMemberListResult mj_objectWithKeyValues:object];
        if (result.code == 0) {
            [self.applyingUsers addObjectsFromArray:result.data];
            self.rightTotalCount = result.count;
        }else{
            [QMUITips showWithText:result.msg inView:self.view hideAfterDelay:1.2];
        }
        [self.rightTableView reloadData];
        [self _endRefreshing];
        [self.rightTableView ly_endLoading];
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"apply list 2 %@",object);
        [self.rightTableView reloadData];
        [self _endRefreshing];
        [self.rightTableView ly_endLoading];
    }];
}
#pragma mark 结束刷新
- (void)_endRefreshing
{
    
    if (_isLeft) {
        self.leftIsRefreshing = NO;
        self.leftIsLoadMoreing = NO;
        [self.leftTableView.mj_header endRefreshing];
        [self.leftTableView.mj_footer endRefreshing];
    }else{
        self.rightIsRefreshing = NO;
        self.rightIsLoadMoreing = NO;
        [self.rightTableView.mj_header endRefreshing];
        [self.rightTableView.mj_footer endRefreshing];
    }
}
-(void)inviteMemberAction
{
    BBInviteFriendsViewController *inviteFriendsVC = [[BBInviteFriendsViewController alloc]init];
    [self.navigationController pushViewController:inviteFriendsVC animated:YES];
    
}



-(void)creatUI
{
    UIView *topV = [[UIView alloc]initWithFrame:CGRectFlatMake(10, 64, _k_w-20, 44)];
    [self.view addSubview:topV];
    topV.backgroundColor = [UIColor whiteColor];
    
    UIButton *bingingedBt = [UIButton bb_btMakeWithSuperV:topV bgColor:nil titleColor:k_color_appOrange titleFontSize:16 title:@"已绑定用户"];
    _bingingBT = bingingedBt;
    bingingedBt.frame = CGRectFlatMake(0, 0, topV.width/2, 44);
    [bingingedBt addTarget:self action:@selector(bingingActin) forControlEvents:UIControlEventTouchUpInside];

    UIButton *applyRecordBt = [UIButton bb_btMakeWithSuperV:topV bgColor:nil titleColor:k_color_515151 titleFontSize:16 title:@"申请记录"];
    _applyRecordBT = applyRecordBt;
    applyRecordBt.frame = CGRectFlatMake(topV.width/2, 0, topV.width/2, 44);
    [applyRecordBt addTarget:self action:@selector(applyRecordActin) forControlEvents:UIControlEventTouchUpInside];

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(topV.width/2, 5, 1, 34)];
    line.backgroundColor = K_color_line;
    [topV addSubview:line];
    
    
    self.leftTableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectMake(0, 64+44, _k_w, _k_h-64-33) delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    self.leftTableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:nil titleStr:@"还没有家庭成员绑定" detailStr:@"你可以邀请家庭成员绑定哦~"];
    self.leftTableView.ly_emptyView.autoShowEmptyView = NO;

    //下拉刷新
    self.leftTableView.mj_header = [UITableView pp_headerForNomaWithTarget:self action:@selector(_leftHeaderRefreshAction) hasLastDate:NO enterStartRefresh:NO];
    
    //上拉加载
    self.leftTableView.mj_footer = [UITableView pp_footerForAutoNormalWithTarger:self action:@selector(_leftLoadMoreDataAction)];
    
    
    //右边
    self.rightTableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectMake(_k_w, 64+44, _k_w, _k_h-64-33) delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    self.rightTableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:nil titleStr:@"还没有家庭成员申请绑定" detailStr:@"你可以邀请家庭成员绑定哦~"];
    self.rightTableView.ly_emptyView.autoShowEmptyView = NO;
    
    //下拉刷新
    self.rightTableView.mj_header = [UITableView pp_headerForNomaWithTarget:self action:@selector(_rightHeaderRefreshAction) hasLastDate:NO enterStartRefresh:NO];
    
    //上拉加载
    self.rightTableView.mj_footer = [UITableView pp_footerForAutoNormalWithTarger:self action:@selector(_rightLoadMoreDataAction)];
    
}
#pragma mark --- 下拉刷新事件
-(void)_leftHeaderRefreshAction
{
    
    if (self.leftIsRefreshing || self.leftIsLoadMoreing) {
        [self _endRefreshing];
        return;
    }else{
        [self.bindingedUsers removeAllObjects];
        [self.leftTableView reloadData];
        self.leftIsRefreshing = YES;
        self.leftIsLoadMoreing = NO;
        self.leftCurrentPage = 0;
        self.leftTotalCount = 0;
        [self getBindListData];
    }
}
-(void)_rightHeaderRefreshAction
{
    
    if (self.rightIsRefreshing || self.rightIsLoadMoreing) {
        [self _endRefreshing];
        return;
    }else{
        [self.applyingUsers removeAllObjects];
        [self.rightTableView reloadData];
        self.rightIsRefreshing = YES;
        self.rightIsLoadMoreing = NO;
        self.rightCurrentPage = 0;
        self.rightTotalCount = 0;
        [self getApplyListData];
    }
}
-(void)_leftLoadMoreDataAction
{
    
    if (self.leftIsRefreshing || self.leftIsLoadMoreing) {
        [self _endRefreshing];
        return;
    }else{
        self.leftIsLoadMoreing = YES;
        self.leftIsRefreshing = NO;
        if (self.bindingedUsers.count >= self.leftTotalCount && self.leftTotalCount > 0) {
            [self.leftTableView.mj_footer endRefreshingWithNoMoreData];//已加载全部
            return;
        }
        self.leftCurrentPage += 1;
        [self getBindListData];
    }
    
}
-(void)_rightLoadMoreDataAction
{
    if (self.rightIsRefreshing || self.rightIsLoadMoreing) {
        [self _endRefreshing];
        return;
    }else{
        self.rightIsRefreshing = YES;
        self.rightIsLoadMoreing = NO;
        if (self.bindingedUsers.count >= self.rightTotalCount && self.rightTotalCount > 0) {
            [self.rightTableView.mj_footer endRefreshingWithNoMoreData];//已加载全部
            return;
        }
        self.rightCurrentPage += 1;
        [self getApplyListData];
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isLeft) {
        return self.bindingedUsers.count;
    }
    return self.applyingUsers.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBFamilyMemberListCell *cell = [BBFamilyMemberListCell bb_cellMakeWithTableView:tableView];
    if (_isLeft) {
        if (self.bindingedUsers.count > indexPath.row) {
            [cell setupWithFamilyMember:self.bindingedUsers[indexPath.row] applyType:BBApplyTypeBind];
        }
    }else{
        if (self.applyingUsers.count > indexPath.row) {
            [cell setupWithFamilyMember:self.applyingUsers[indexPath.row] applyType:BBApplyTypeAll];
        }
    }
    cell.setOrAgreeBlock = ^(BOOL isSetting) {
        if (isSetting) {
            //设置
            BBPermissionManageViewController *permissionManagVC = [[BBPermissionManageViewController alloc]init];
            [self.navigationController pushViewController:permissionManagVC animated:YES];
        }else{
           //同意
        }
    };

    cell.refuseBlock = ^{
#warning todo 拒绝
    };
    return cell;
}


-(void)bingingActin
{
    if (_isLeft) {
        return;
    }
    [_bingingBT bb_btSetTitleColor:k_color_appOrange];
    [_applyRecordBT bb_btSetTitleColor:k_color_515151];
    _isLeft = YES;
    [UIView animateWithDuration:0.25 delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        self.leftTableView.left = 0;
        self.rightTableView.left = _k_w;
    } completion:nil];
    if (!_hasLeftLoad) {
        [self getBindListData];
    }
}
-(void)applyRecordActin
{
    if (!_isLeft) {
        return;
    }
    [_bingingBT bb_btSetTitleColor:k_color_515151];
    [_applyRecordBT bb_btSetTitleColor:k_color_appOrange];
    _isLeft = NO;
    [UIView animateWithDuration:0.25 delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        self.leftTableView.left = -_k_w;
        self.rightTableView.left = 0;
    } completion:nil];
    if (!_hasRightLoad) {
        [self getApplyListData];
    }
}

-(NSMutableArray<BBFamilyMember *> *)bindingedUsers
{
    if (!_bindingedUsers) {
        _bindingedUsers = [NSMutableArray array];
    }
    return _bindingedUsers;
}

-(NSMutableArray<BBFamilyMember *> *)applyingUsers
{
    if (!_applyingUsers) {
        _applyingUsers = [NSMutableArray array];
    }
    return _applyingUsers;
}
@end
