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

@interface BBEarlyEducationMusicListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *musicLists;
@end

@implementation BBEarlyEducationMusicListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = k_color_vcBg;
    self.title = self.aMusicCategory.cat_name;
    
    [self creatUI];
    [self getListData];
}
-(void)getListData
{
    [BBRequestTool bb_requestEarlyEdutionSubListListWithCategoryId:[NSString stringWithFormat:@"%ld",(long)self.aMusicCategory.cat_id] successBlock:^(EnumServerStatus status, id object) {
        NSLog(@"success 早教sublistlist");
        BBMusicResult *musicListResult = [BBMusicResult mj_objectWithKeyValues:object];
        if (musicListResult.retcode == 0) {
            BBMusicAudioinfos *audioInfos = musicListResult.audioinfos;
            [self.musicLists addObjectsFromArray:audioInfos.contents];
            [self.tableView reloadData];
        }else{
            [QMUITips showInfo:@"获取列表失败"];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"fail 早教失败t");
    }];
}
-(void)creatUI
{
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:self.view.bounds delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    
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
    };
    if (self.musicLists.count > indexPath.row) {
        [cell setupCell:self.musicLists[indexPath.row]];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BBMusicViewController *musicVC = [BBMusicViewController sharedInstance];
    musicVC.musicTitle = @"热门推荐";
    musicVC.musics = self.musicLists;
    
    musicVC.playingIndex = indexPath.item;
    
    [self presentToMusicViewWithMusicVC:musicVC];
    
    //    [QMUITips showLoadingInView:self.view];
}

- (void)presentToMusicViewWithMusicVC:(BBMusicViewController *)musicVC {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:musicVC];
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