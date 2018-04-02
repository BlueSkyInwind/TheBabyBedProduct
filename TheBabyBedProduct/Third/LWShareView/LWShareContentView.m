//
//  ArtShareContentView.m
//  LWShareView
//
//  Created by LeeWong on 2018/1/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "LWShareContentView.h"
#import "LWShareCollectionViewCell.h"
#import "LWShareButton.h"

#define kMargin 10
#define kPadding 20
#define kFooterHeight 30
#define kMinimumInteritemSpacing  10
#define kItemWidth (SCREEN_W - kMargin * 2 - kPadding * 2-kMinimumInteritemSpacing*4) / 4.
#define kItemHeight 74

#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#define UI_IS_IPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
#define UI_IS_IPHONE6PLUS       (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0 || [[UIScreen mainScreen] bounds].size.width == 736.0) // Both orientations


@interface LWShareContentView () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *bottomCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *bottomFlowLayout;
@property (nonatomic, strong) UILabel *shareTipLabel;
@end

@implementation LWShareContentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}


#pragma mark - Build UI

- (void)buildUI
{
    [self.shareTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(kPadding);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.bottomCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shareTipLabel.mas_bottom).offset(kPadding);
        make.left.equalTo(self.mas_left).offset(kPadding);
        make.right.equalTo(self.mas_right).offset(-kPadding);
        make.height.equalTo(@(kItemHeight));
    }];
}

- (void)setBottomMenus:(NSArray *)bottomMenus
{
    _bottomMenus = bottomMenus;
    [self.bottomCollectionView reloadData];
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    [collectionView.collectionViewLayout invalidateLayout];
    return self.bottomMenus.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *menus = self.bottomMenus;
    LWShareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LWShareCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *item = menus[indexPath.item];
    [cell.shareBtn setTitle:item[kShareTitle] forState:UIControlStateNormal];
    [cell.shareBtn setImage:[UIImage imageNamed:item[kShareIcon]] forState:UIControlStateNormal];
    [cell.shareBtn setImage:[UIImage imageNamed:item[kShareIcon]] forState:UIControlStateHighlighted];

    cell.cellShareBlock = ^{
        [self sharedActionWithIndexPath:indexPath];
    };

    return cell;
}

-(void)sharedActionWithIndexPath:(NSIndexPath *)indexPath
{
    if (self.shareBtnClickBlock) {
        self.shareBtnClickBlock(indexPath);
    }
}




#pragma mark - Lazy Load

- (UICollectionView *)bottomCollectionView
{
    if (_bottomCollectionView == nil) {
        _bottomCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.bottomFlowLayout];
        [self addSubview:_bottomCollectionView];
        [_bottomCollectionView registerClass:[LWShareCollectionViewCell class] forCellWithReuseIdentifier:@"LWShareCollectionViewCell"];
        _bottomCollectionView.backgroundColor = [UIColor clearColor];
        _bottomCollectionView.dataSource = self;
        _bottomCollectionView.delegate = self;
        _bottomCollectionView.showsHorizontalScrollIndicator = NO;
        _bottomCollectionView.showsVerticalScrollIndicator = NO;
        [self addSubview:_bottomCollectionView];
    }
    return _bottomCollectionView;
}

- (UICollectionViewFlowLayout *)bottomFlowLayout
{
    if (_bottomFlowLayout == nil) {
        _bottomFlowLayout = [[UICollectionViewFlowLayout alloc] init];
        _bottomFlowLayout.minimumInteritemSpacing = kMinimumInteritemSpacing;
        _bottomFlowLayout.itemSize = CGSizeMake(kItemWidth, kItemHeight);
        _bottomFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _bottomFlowLayout;
}


- (UILabel *)shareTipLabel
{
    if (_shareTipLabel == nil) {
        _shareTipLabel = [[UILabel alloc] init];
        _shareTipLabel.font = [UIFont systemFontOfSize:17];
        _shareTipLabel.textColor = k_color_515151;
        _shareTipLabel.text = @"邀请好友";
        [self addSubview:_shareTipLabel];
    }
    return _shareTipLabel;
}

@end
