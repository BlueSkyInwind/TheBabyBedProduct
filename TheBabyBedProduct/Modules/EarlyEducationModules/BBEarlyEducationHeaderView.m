//
//  BBEarlyEducationHeaderView.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/29.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBEarlyEducationHeaderView.h"
#import "SDCycleScrollView.h"


@interface BBEarlyEducationHeaderView()<SDCycleScrollViewDelegate>
/** banner  */
@property(nonatomic,strong)SDCycleScrollView *bannerView;
@end

@implementation BBEarlyEducationHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}


-(void)creatUI
{
    
    [self creatBannerUI];
    
    NSArray * titleArrs = @[@"胎教音乐",@"经典童话",@"睡前故事",@"音乐启蒙",
                            @"古诗精选",@"经典音乐",@"小提琴曲",@"古典音乐"];
    
    NSArray * imageArrs = @[
                            @"antenatal",
                            @"classical",
                            @"bedtimestory",
                            @"multiplemusic",
                            @"articles",
                            @"classicmusic",
                            @"pianomusic",
                            @"classicalmusic"
                            ];
    
    NSInteger columnCount = 4;
    CGFloat btH =  95;
    CGFloat btW = self.width/columnCount;
    CGFloat verticalMargin = 8;
    
    for (NSInteger i=0; i< titleArrs.count; i++) {
        NSInteger row = i/columnCount;
        NSInteger column = i%columnCount;
        CGFloat btX = btW*column;
        CGFloat btY = verticalMargin+_bannerView.bottom+row*(btH+verticalMargin);
        CGRect btFrame = CGRectMake(btX, btY, btW, btH);
        BBItemButton *button = [[BBItemButton alloc] initWithFrame:btFrame imgName:imageArrs[i] text:titleArrs[i] tag:i];
        button.itemClickedBlcok = ^(BBEarlyEducationItemType itemType) {
            if (self.itemClickedBlock) {
                self.itemClickedBlock(itemType);
            }
        };
        [self addSubview:button];
        
    }
    //230+220+10+44+10
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 450, self.width, 10)];
    backView.backgroundColor = k_color_vcBg;
    [self addSubview:backView];
    
    UIView *lookMoreBgV = [[UIView alloc]initWithFrame:CGRectFlatMake(0, backView.bottom, self.width, 44)];
    lookMoreBgV.backgroundColor = UI_MAIN_COLOR;
    [self addSubview:lookMoreBgV];
    UILabel *hotRecommedLB = [UILabel bb_lbMakeWithSuperV:lookMoreBgV fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    hotRecommedLB.text = @"热门推荐";
    hotRecommedLB.frame = CGRectMake(12, 0, 100, 44);
    
    UILabel *lookMoreLB = [UILabel bb_lbMakeWithSuperV:lookMoreBgV fontSize:14 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    lookMoreLB.text = @"查看更多";
    lookMoreLB.textAlignment = NSTextAlignmentRight;
    lookMoreLB.frame = CGRectMake(_k_w-120, 0, 110, 44);
    UIButton *lookMoreBt = [UIButton bb_btMakeWithSuperV:lookMoreBgV imageName:nil];
    [lookMoreBt addTarget:self action:@selector(toLookMore) forControlEvents:UIControlEventTouchUpInside];
    lookMoreBt.frame = CGRectFlatMake(_k_w-120, 0, 120, 44);
    
    UIView *backView1 = [[UIView alloc] initWithFrame:CGRectMake(0, lookMoreBgV.bottom, self.width, 10)];
    backView1.backgroundColor = k_color_vcBg;
    [self addSubview:backView1];
    
}


-(void)toLookMore
{
    if (self.lookMoreBlock) {
        self.lookMoreBlock();
    }
}
-(void)creatBannerUI
{
#warning todo 占位图
    _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.width, 230) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    // 自定义分页控件小圆标颜色
    _bannerView.currentPageDotColor = [UIColor whiteColor];
    _bannerView.autoScrollTimeInterval = 3.5;
    
    _bannerView.localizationImageNamesGroup = @[
                                                @"mebackground",
                                                @"mybackground",
                                                @"mebackground"
                                                ];
    [self addSubview:_bannerView];
}


#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", (long)index);
    if (self.bannerClickBlock) {
        self.bannerClickBlock(index);
    }
    
}
@end

@interface BBItemButton ()
@property(nonatomic,strong) UIImageView *topImgV;
@property(nonatomic,strong) UILabel *bottomTextLB;
@property(nonatomic,strong) UIButton *tempBT;
@end

@implementation BBItemButton 
-(instancetype)initWithFrame:(CGRect)frame imgName:(NSString *)imgName text:(NSString *)text tag:(NSInteger)tag
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUIWithImgName:imgName text:text tag:tag];
    }
    return self;
}
-(void)creatUIWithImgName:(NSString *)imgName text:(NSString *)text tag:(NSInteger)tag
{
    CGFloat totalW = self.width;
    CGFloat imgW = 53;
    CGFloat imgX = (totalW-imgW)/2;
    
    self.topImgV = [UIImageView bb_imgVMakeWithSuperV:self imgName:imgName];
    self.bottomTextLB = [UILabel bb_lbMakeWithSuperV:self fontSize:12 alignment:NSTextAlignmentCenter textColor:k_color_515151];
    self.bottomTextLB.text = text;
    self.tempBT = [UIButton bb_btMakeWithSuperV:self imageName:nil];
    
    self.topImgV.frame = CGRectFlatMake(imgX, 8, imgW, imgW);
    self.bottomTextLB.frame = CGRectFlatMake(0, self.topImgV.bottom+8, totalW, 28);
    self.tempBT.frame = self.bounds;
    self.tempBT.tag = tag;
    [self.tempBT addTarget:self action:@selector(itemClickedAction:) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)itemClickedAction:(UIButton *)bt
{
    if (self.itemClickedBlcok) {
        self.itemClickedBlcok(bt.tag);
    }
}

@end
