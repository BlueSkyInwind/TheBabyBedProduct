//
//  EarlyEducationViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "EarlyEducationViewController.h"
#import "UIImage+category.h"
#import "BBEarlyEducationHeaderView.h"
#import "BBEarlyEducationCell.h"
#import "BBEarlyEducationMusicListViewController.h"
#import "BBMusicCategory.h"
#import "BBMusicHotRecommend.h"
#import "GKSearchBar.h"

#import "GKWYMusicModel.h"
#import "BBMusicViewController.h"

static NSString * const kEarlyEducationCellIdentifier = @"EarlyEducationCellIdentifier";
static NSString * const kEarlyEducationHeaderViewIdentifier = @"EarlyEducationHeaderViewIdentifier";

#define k_item_margin 5

@interface EarlyEducationViewController ()<GKSearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) GKSearchBar *searchBar;
@property(nonatomic,strong)UICollectionView *collectionView;
/** GCS music 分类 */
@property(nonatomic,strong) NSMutableArray<BBMusicCategory *> *musicCategories;
/** 热门推荐 */
@property(nonatomic,strong) NSMutableArray<BBMusic *> *hotRecommends;
/** 顶部items数组 */
@property(nonatomic,strong) NSArray *titleArrs;
/** item起始数组都加的一个模型 */
@property(nonatomic,strong) BBMusicCategory *aTempCategory;
@end

@implementation EarlyEducationViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self creatUI];
    [self getEarlyEdutionList];
    
    self.titleArrs = @[@"胎教音乐",@"经典童话",@"睡前故事",@"音乐启蒙",
                       @"古诗精选",@"经典音乐",@"小提琴曲",@"古典音乐"];
    self.aTempCategory = [[BBMusicCategory alloc]init];
}
-(void)creatUI
{
    [self creatHeaderSearchUI];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = k_item_margin;
    flowLayout.minimumInteritemSpacing = k_item_margin;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+44, _k_w, _k_h-64-44-50) collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = k_color_vcBg;
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerClass:[BBEarlyEducationCell class] forCellWithReuseIdentifier:kEarlyEducationCellIdentifier];
    [self.collectionView registerClass:[BBEarlyEducationHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kEarlyEducationHeaderViewIdentifier];
    
}
-(void)getAllSubCategories:(NSMutableArray *)categoryIds
{
    if (categoryIds.count == 0) {
        return;
    }
    [BBRequestTool bb_requestEarlyEdutionSubListWithCategoryIds:categoryIds SuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"11em succes %@",object);
        BBMusicCategoryResult *result = [BBMusicCategoryResult mj_objectWithKeyValues:object];
        if (result.retcode == 0) {
            BBMusicCategoryAudioinfos *audioInfos = result.audioinfos;
            for (BBMusicCategory *category in audioInfos.cats) {
                if ([self.titleArrs containsObject:category.cat_name]) {
                    NSUInteger index = [self.titleArrs indexOfObject:category.cat_name];
                    [self.musicCategories replaceObjectAtIndex:index withObject:category];
                }
            }            
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"11em error %@",object);
    }];
}
-(void)getEarlyEdutionList
{
    [BBRequestTool bb_requestEarlyEdutionListWithSuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"em succes %@",object);
        BBMusicCategoryResult *result = [BBMusicCategoryResult mj_objectWithKeyValues:object];
        if (result.retcode == 0) {
            BBMusicCategoryAudioinfos *audioInfos = result.audioinfos;
            NSMutableArray *categoryIds = [NSMutableArray array];
            for (BBMusicCategory *category in audioInfos.cats) {
                [categoryIds addObject:[NSString stringWithFormat:@"%ld",(long)category.cat_id]];
            }
            [self getAllSubCategories:categoryIds];
            
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        
    }];
    
    //6707 6708  6948 7156 7716 16815 17164 17174 17176 17466 19025
    
    [BBRequestTool bb_requestEarlyEdutionHotRecommendWithSuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"em succes %@",object);
        BBMusicHotRecommendResult *result = [BBMusicHotRecommendResult mj_objectWithKeyValues:object];
        if (result.retcode == 0) {
            BBMusicHotRecommendAudioinfos *audioinfos = result.audioinfos;
            [self.hotRecommends addObjectsFromArray:audioinfos.contents];
            [self.collectionView reloadData];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"em error %@",object);
    }];
}
-(void)creatHeaderSearchUI
{
    UIView *searchBGV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 64+44)];
    searchBGV.backgroundColor = UI_MAIN_COLOR;
    [self.view addSubview:searchBGV];
    
    UILabel *titleLB = [UILabel bb_lbMakeWithSuperV:searchBGV fontSize:18 alignment:NSTextAlignmentCenter textColor:k_color_515151];
//    titleLB.frame = CGRectMake(0, 20, _k_w, 44);
    titleLB.text = @"早教";
    [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(searchBGV);
        make.top.equalTo(searchBGV.mas_top).offset(20);
        make.height.equalTo(@44);
    }];
    
    [searchBGV addSubview:self.searchBar];
    [self.searchBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchBGV).offset(10);
        make.top.equalTo(titleLB.mas_bottom).offset(0);
        make.right.equalTo(searchBGV).offset(-10);

        make.height.mas_equalTo(44.0f);
    }];
    [self.searchBar layoutIfNeeded];
    
    
}
#pragma mark - 懒加载
- (GKSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar              = [[GKSearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _searchBar.placeholder  = @"搜索";
        _searchBar.iconAlign    = GKSearchBarIconAlignCenter;
        _searchBar.iconImage    = [UIImage imageNamed:@"cm2_topbar_icn_search"];
        _searchBar.delegate     = self;
        
        if (@available(iOS 11.0, *)) {
            [_searchBar.heightAnchor constraintLessThanOrEqualToConstant:44].active = YES;
        }
    }
    return _searchBar;
}
#pragma mark - EVNCustomSearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(GKSearchBar *)searchBar {
//    GKWYSearchViewController *searchVC = [GKWYSearchViewController new];
//    [self.navigationController pushViewController:searchVC animated:YES];
    NSLog(@"点击了serachbar");
    return NO;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        BBEarlyEducationHeaderView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kEarlyEducationHeaderViewIdentifier forIndexPath:indexPath];
        [self setupHeaderViewAction:headerV];
        return headerV;
    }
    return nil;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.hotRecommends.count > 6) {
        return 6;
    }
    return self.hotRecommends.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BBEarlyEducationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kEarlyEducationCellIdentifier forIndexPath:indexPath];
    if(self.hotRecommends.count > indexPath.item){
        [cell setupCellWithAHotRecommend:self.hotRecommends[indexPath.item]];
    }
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemW = (_k_w-k_item_margin*2)/3;
    CGFloat itemH = itemW*90/105+34;
    return CGSizeMake(itemW, itemH);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(_k_w, 514);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    GKWYMusicModel *model = [GKWYMusicModel new];
//    model.song_id       = songModel.songid;
//    model.song_name     = songModel.songname;
//    model.artist_name   = songModel.artistname;
//    
//    [kWYPlayerVC playMusicWithModel:model];
    
    BBMusicViewController *musicVC = [BBMusicViewController sharedInstance];
    musicVC.musicTitle = @"热门推荐";
    musicVC.musics = self.hotRecommends;
    musicVC.playingIndex = indexPath.item;
    BBMusic *selectedMusic = self.hotRecommends[indexPath.item];
    BBMusic *playingMusic = [musicVC currentPlayingMusic];
    if (![selectedMusic.musicID isEqualToString:playingMusic.musicID]) {
        [musicVC playMusicWithSpecialIndex:indexPath.item];
    }
    
//    [self presentToMusicViewWithMusicVC:musicVC];
    [self presentViewController:musicVC animated:YES completion:nil];

//    [QMUITips showLoadingInView:self.view];
}

- (void)presentToMusicViewWithMusicVC:(BBMusicViewController *)musicVC {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:musicVC];
    [self.navigationController presentViewController:navigationController animated:YES completion:nil];
}
                                                 
#pragma mark --- 处理header上轮播图和板块点击跳转事件
-(void)setupHeaderViewAction:(BBEarlyEducationHeaderView *)headerV
{
    BBWeakSelf(self)
    headerV.bannerClickBlock = ^(NSInteger selectedIndex) {
        DLog(@"点击banner的 %ld 个",(long)selectedIndex);
    };
    
    headerV.itemClickedBlock = ^(BBEarlyEducationItemType itemType) {
        DLog(@"点击item");
        
        BBEarlyEducationMusicListViewController *musicListVC = [[BBEarlyEducationMusicListViewController alloc]init];
        musicListVC.musicListName = self.titleArrs[itemType];
        musicListVC.aMusicCategory = self.musicCategories[itemType];
        [self.navigationController pushViewController:musicListVC animated:YES];
    };
    
    headerV.lookMoreBlock = ^{
        DLog(@"查看更多");
    };
        
}
                                        

-(NSMutableArray<BBMusicCategory *> *)musicCategories
{
    if (!_musicCategories) {
        _musicCategories = [NSMutableArray array];
        for (int i = 0; i < 8; i++) {
            [_musicCategories addObject:_aTempCategory];
        }
    }
    return _musicCategories;
}
-(NSMutableArray<BBMusic *> *)hotRecommends
{
    if (!_hotRecommends) {
        _hotRecommends = [NSMutableArray array];
    }
    return _hotRecommends;
}
@end
