//
//  BBFamilyMemberViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/29.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBFamilyMemberViewController.h"
#import "BBFamilyMemberListCell.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "LWShareService.h"
#import "BBPermissionManageViewController.h"

@interface BBFamilyMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isLeft;
    UIButton *_bingingBT;
    UIButton *_applyRecordBT;
}
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *bindingedUsers;
@property(nonatomic,strong) NSMutableArray *applyingUsers;
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
    _isLeft = YES;
    
    [self getBindListData];
    [self creatUI];
    
    UIButton *invireBt = [UIButton bb_btMakeWithSuperV:nil bgColor:nil titleColor:k_color_515151 titleFontSize:14 title:@"邀请好友"];
    [invireBt addTarget:self action:@selector(inviteMemberAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:invireBt];
    self.navigationItem.rightBarButtonItem = item;
    
}
-(void)getBindListData
{
#warning pp605
    [BBRequestTool bb_requestBindListWithPageNo:0 pageSize:10 SuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"bind list %@",object);
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"bind list %@",object);

    }];
}
-(void)getApplyListData
{
    [BBRequestTool bb_requestApplyListWithPageNo:0 pageSize:10 SuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"apply list 1 %@",object);
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"apply list 2 %@",object);
    }];
}
-(void)inviteMemberAction
{
    [LWShareService shared].shareBtnClickBlock = ^(NSIndexPath *index) {
        [self toShareWithIndexpath:index];
    };
    
    [[LWShareService shared] showInViewController:self];
    
}
-(void)toShareWithIndexpath:(NSIndexPath *)indexPath
{
    SSDKPlatformType platformType = SSDKPlatformSubTypeQQFriend;
    if (indexPath.item == 1) {
        platformType = SSDKPlatformSubTypeWechatTimeline;
    }else if (indexPath.item == 2){
        platformType = SSDKPlatformSubTypeWechatSession;
    }else if (indexPath.item == 3){
        platformType = SSDKPlatformTypeSinaWeibo;
    }
    
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                     images:nil
                                        url:[NSURL URLWithString:@"http://mob.com"]
                                      title:@"分享标题"
                                       type:SSDKContentTypeAuto];
    //有的平台要客户端分享需要加此方法，例如微博
    [shareParams SSDKEnableUseClientShare];
    
    [ShareSDK share:platformType parameters:shareParams onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        DLog(@"微信好友分享结果 %lu",(unsigned long)state);
        NSString *shareResultStr = @"";
        if (state == SSDKResponseStateSuccess) {
            shareResultStr = @"分享成功";
        }else if (state == SSDKResponseStateFail){
            shareResultStr = @"分享失败";
        }else if (state == SSDKResponseStateCancel){
            shareResultStr = @"您取消了分享";
        }
        if (shareResultStr.length > 0) {
            [QMUITips showWithText:shareResultStr inView:self.view hideAfterDelay:1.5];
        }
        
        [LWShareServices hidden];
    }];
}

-(void)creatUI
{
    UIView *topV = [[UIView alloc]initWithFrame:CGRectFlatMake(10, 64, _k_w-20, 33)];
    [self.view addSubview:topV];
    topV.backgroundColor = [UIColor whiteColor];
    
    UIButton *bingingedBt = [UIButton bb_btMakeWithSuperV:topV bgColor:nil titleColor:k_color_appOrange titleFontSize:16 title:@"已绑定用户"];
    _bingingBT = bingingedBt;
    bingingedBt.frame = CGRectFlatMake(0, 0, topV.width/2, 33);
    [bingingedBt addTarget:self action:@selector(bingingActin) forControlEvents:UIControlEventTouchUpInside];

    UIButton *applyRecordBt = [UIButton bb_btMakeWithSuperV:topV bgColor:nil titleColor:k_color_515151 titleFontSize:16 title:@"申请记录"];
    _applyRecordBT = applyRecordBt;
    applyRecordBt.frame = CGRectFlatMake(topV.width/2, 0, topV.width/2, 33);
    [applyRecordBt addTarget:self action:@selector(applyRecordActin) forControlEvents:UIControlEventTouchUpInside];

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(topV.width/2, 5, 1, 23)];
    line.backgroundColor = K_color_line;
    [topV addSubview:line];
    
    
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectMake(0, 64+33, _k_w, _k_h-64-33) delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBFamilyMemberListCell *cell = [BBFamilyMemberListCell bb_cellMakeWithTableView:tableView];
    [cell setupCellWithUser:nil isleft:_isLeft];
    cell.setOrCancelBlock = ^{
        if (_isLeft) {
            BBPermissionManageViewController *permissionManagVC = [[BBPermissionManageViewController alloc]init];
            [self.navigationController pushViewController:permissionManagVC animated:YES];
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
    [self getBindListData];
}
-(void)applyRecordActin
{
    if (!_isLeft) {
        return;
    }
    [_bingingBT bb_btSetTitleColor:k_color_515151];
    [_applyRecordBT bb_btSetTitleColor:k_color_appOrange];
    _isLeft = NO;
    
    [self getApplyListData];
}

-(NSMutableArray *)bindingedUsers
{
    if (!_bindingedUsers) {
        _bindingedUsers = [NSMutableArray array];
    }
    return _bindingedUsers;
}

-(NSMutableArray *)applyingUsers
{
    if (!_applyingUsers) {
        _applyingUsers = [NSMutableArray array];
    }
    return _applyingUsers;
}
@end
