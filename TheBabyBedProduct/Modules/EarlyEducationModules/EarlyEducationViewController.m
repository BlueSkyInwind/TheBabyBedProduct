//
//  EarlyEducationViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "EarlyEducationViewController.h"
#import "UIImage+category.h"
#import "UILabel+EasilyMake.h"
#import "BBEarlyEducationHeaderView.h"
#import "BBEarlyEducationCell.h"

static NSString * const kEarlyEducationCellIdentifier = @"EarlyEducationCellIdentifier";
static NSString * const kEarlyEducationHeaderViewIdentifier = @"EarlyEducationHeaderViewIdentifier";

#define k_item_margin 5

@interface EarlyEducationViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *hotRecommendItemTitles;
@property(nonatomic,strong) NSMutableArray *hotRecommendItemImgs;
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
    // Do any additional setup after loading the view.
   
    [self.hotRecommendItemTitles addObjectsFromArray:@[@"催眠曲",@"愉快曲",@"催眠曲1",@"愉快曲1",@"催眠曲2",@"愉快曲2"]];
    [self.hotRecommendItemImgs addObjectsFromArray:@[@"lullaby",@"berceuse",@"sleepsong",@"lullaby",@"berceuse",@"sleepsong"]];

        //berceuse
    [self creatUI];
}
-(void)creatUI
{
    [self creatHeaderSearchUI];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = k_item_margin;
    flowLayout.minimumInteritemSpacing = k_item_margin;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+35, _k_w, _k_h-64-35-50) collectionViewLayout:flowLayout];
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = k_color_vcBg;
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerClass:[BBEarlyEducationCell class] forCellWithReuseIdentifier:kEarlyEducationCellIdentifier];
    [self.collectionView registerClass:[BBEarlyEducationHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kEarlyEducationHeaderViewIdentifier];
    
}
-(void)creatHeaderSearchUI
{
    UIView *searchBGV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 64+35)];
    searchBGV.backgroundColor = UI_MAIN_COLOR;
    [self.view addSubview:searchBGV];
    
    UILabel *titleLB = [UILabel bb_lbMakeWithSuperV:searchBGV fontSize:18 alignment:NSTextAlignmentCenter textColor:k_color_515151];
    titleLB.frame = CGRectMake(0, 20, _k_w, 44);
    titleLB.text = @"早教";
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
    return self.hotRecommendItemTitles.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BBEarlyEducationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kEarlyEducationCellIdentifier forIndexPath:indexPath];
    if(self.hotRecommendItemTitles.count > indexPath.item){
        [cell setupCellWithImgName:self.hotRecommendItemImgs[indexPath.item] text:self.hotRecommendItemTitles[indexPath.item]];
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
                                                 
#pragma mark --- 处理header上轮播图和板块点击跳转事件
-(void)setupHeaderViewAction:(BBEarlyEducationHeaderView *)headerV
{
    BBWeakSelf(self)
    headerV.bannerClickBlock = ^(NSInteger selectedIndex) {
        DLog(@"点击banner的 %ld 个",(long)selectedIndex);
    };
    
    headerV.itemClickedBlock = ^(BBEarlyEducationItemType itemType) {
        DLog(@"点击item");
    };
    
    headerV.lookMoreBlock = ^{
        DLog(@"查看更多");
    };
        
}
                                        
-(NSMutableArray *)hotRecommendItemTitles
{
    if (!_hotRecommendItemTitles) {
        _hotRecommendItemTitles = [NSMutableArray array];
    }
    return _hotRecommendItemTitles;
}
-(NSMutableArray *)hotRecommendItemImgs
{
    if (!_hotRecommendItemImgs) {
        _hotRecommendItemImgs = [NSMutableArray array];
    }
    return _hotRecommendItemImgs;
}
@end
