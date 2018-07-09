//
//  BBEarlyEducationSearchListViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/7/9.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBEarlyEducationSearchListViewController.h"
#import "GKSearchBar.h"
#import "LYEmptyViewHeader.h"
#import "BBMusic.h"
#import "BBEarlyEdutionMusicListCell.h"
#import "BBMusicViewController.h"
#import "BBEarlyEducationMusicDetailViewController.h"

@interface BBEarlyEducationSearchListViewController ()<GKSearchBarDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) GKSearchBar *searchBar;
@property(nonatomic,strong) NSMutableArray<BBMusic *> *musics;
@end

@implementation BBEarlyEducationSearchListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationView.height += 44;
    self.titleStr = @"搜索";
    self.view.backgroundColor = k_color_vcBg;
    [self createhUI];
}

-(void)createhUI
{
    [self.navigationView addSubview:self.searchBar];
    self.searchBar.frame = CGRectMake(10, PPDevice_navBarHeight, _k_w-20, 44);
    [self.searchBar layoutIfNeeded];
    
    self.tableView = [PPMAKE(PPMakeTypeTableVPlain) pp_make:^(PPMake *make) {
        make.intoView(self.view);
        make.frame(CGRectMake(0, self.searchBar.bottom, _k_w, _k_h-self.searchBar.bottom));
        make.delegate(self);
    }];
    
    self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:nil titleStr:@"没有搜索结果" detailStr:nil];
//    self.tableView.ly_emptyView.autoShowEmptyView = NO;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.musics.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBEarlyEdutionMusicListCell *cell = [BBEarlyEdutionMusicListCell bb_cellMakeWithTableView:tableView];
    
    cell.playBlock = ^{
        NSLog(@"点击了第%ld行",indexPath.row);
        BBMusicViewController *musicVC = [BBMusicViewController sharedInstance];
        musicVC.musics = self.musics;
        BBMusic *music = self.musics[indexPath.row];
        musicVC.musicTitle = music.name;
        musicVC.playingIndex = indexPath.item;
        [self presentToMusicViewWithMusicVC:musicVC];
    };
    
    if (self.musics.count > indexPath.row) {
        [cell setupCell:self.musics[indexPath.row]];
    }
    return cell;
}
- (void)presentToMusicViewWithMusicVC:(BBMusicViewController *)musicVC {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:musicVC];
    [navigationController setNavigationBarHidden:YES];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BBEarlyEducationMusicDetailViewController *musicDetailVC = [[BBEarlyEducationMusicDetailViewController alloc]init];
    [self.navigationController pushViewController:musicDetailVC animated:YES];
}

#pragma mark - GKSearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(GKSearchBar *)searchBar {
    return YES;
}
- (void)searchBarSearchBtnClicked:(GKSearchBar *)searchBar
{
    if (!self.searchBar.text || self.searchBar.text.length == 0) {
        [QMUITips showWithText:@"请输入关键字后再查询" inView:self.view hideAfterDelay:1.5];
        return;
    }
    [self.tableView ly_startLoading];
    [BBRequestTool bb_requestEarlyEdutionQueryWithKeyWord:searchBar.text successBlock:^(EnumServerStatus status, id object) {
        DLog(@"搜索成功了 %@",object)
        BBMusicResult *musicListResult = [BBMusicResult mj_objectWithKeyValues:object];
        if (musicListResult.retcode == 0) {
            BBMusicAudioinfos *audioInfos = musicListResult.audioinfos;
            [self.musics addObjectsFromArray:audioInfos.contents];
            [self.tableView reloadData];
            [self.tableView ly_endLoading];
        }else{
            [self.musics removeAllObjects];
            [self.tableView reloadData];
            [self.tableView ly_endLoading];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        DLog(@"搜索失败了 %@",object)
        [self.musics removeAllObjects];
        [self.tableView reloadData];
        [self.tableView ly_endLoading];
    }];
}
- (void)searchBar:(GKSearchBar *)searchBar textDidChange:(NSString *)text
{
    if (text.length == 0) {
        [self.tableView ly_startLoading];
        [self.musics removeAllObjects];
        [self.tableView reloadData];
        [self.tableView ly_endLoading];
    }
}

#pragma mark - 懒加载
- (GKSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar              = [[GKSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _searchBar.placeholder  = @"搜索";
//        _searchBar.iconAlign    = GKSearchBarIconAlignCenter;
        _searchBar.iconImage    = [UIImage imageNamed:@"cm2_topbar_icn_search"];
        _searchBar.delegate     = self;
        if (@available(iOS 11.0, *)) {
            [_searchBar.heightAnchor constraintLessThanOrEqualToConstant:44].active = YES;
        }
    }
    return _searchBar;
}
-(NSMutableArray<BBMusic *> *)musics
{
    if (!_musics) {
        _musics = [NSMutableArray array];
    }
    return _musics;
}
@end
