//
//  BBEarlyEducationMusicListViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/9.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBEarlyEducationMusicListViewController.h"
#import "BBMusicCategory.h"
#import "BBEarlyEdutionMusicListCell.h"
#import "BBMusicViewController.h"
#import "BBEarlyEducationMusicDetailViewController.h"


@interface BBEarlyEducationMusicListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *musicLists;
@end

@implementation BBEarlyEducationMusicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = k_color_vcBg;
    self.titleStr = self.aMusicCategory.cat_name;
    
    [self creatUI];
    [self getListData];
}
-(void)getListData
{
    [self.tableView ly_startLoading];
    [BBRequestTool bb_requestEarlyEdutionSubListListWithCategoryId:[NSString stringWithFormat:@"%ld",(long)self.aMusicCategory.cat_id] successBlock:^(EnumServerStatus status, id object) {
        NSLog(@"success 早教sublistlist");
        BBMusicResult *musicListResult = [BBMusicResult mj_objectWithKeyValues:object];
        if (musicListResult.retcode == 0) {
            BBMusicAudioinfos *audioInfos = musicListResult.audioinfos;
            [self.musicLists addObjectsFromArray:audioInfos.contents];
            [self.tableView reloadData];
            [self.tableView ly_endLoading];
        }else{
            [QMUITips showInfo:@"获取列表失败"];
            [self.tableView ly_endLoading];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"fail 早教失败t");
        [self.tableView ly_endLoading];
    }];
}
-(void)creatUI
{
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectMake(0, PPDevice_navBarHeight, _k_w, _k_h-PPDevice_navBarHeight) delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    self.tableView.ly_emptyView = [LYEmptyView emptyViewWithImageStr:nil titleStr:@"该列表未查询到歌曲" detailStr:@"你可以去其它列表看看"];
    self.tableView.ly_emptyView.autoShowEmptyView = NO;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.musicLists.count;
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
        musicVC.musicTitle = [self.musicListName bb_safe];
        musicVC.musics = self.musicLists;
        musicVC.playingIndex = indexPath.item;
        [self presentToMusicViewWithMusicVC:musicVC];
    };
    
    if (self.musicLists.count > indexPath.row) {
        [cell setupCell:self.musicLists[indexPath.row]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BBEarlyEducationMusicDetailViewController *musicDetailVC = [[BBEarlyEducationMusicDetailViewController alloc]init];
    [self.navigationController pushViewController:musicDetailVC animated:YES];
}

- (void)presentToMusicViewWithMusicVC:(BBMusicViewController *)musicVC {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:musicVC];
    [navigationController setNavigationBarHidden:YES];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}


    
-(NSMutableArray *)musicLists
{
    if (!_musicLists) {
        _musicLists = [NSMutableArray array];
    }
    return _musicLists;
}

@end
