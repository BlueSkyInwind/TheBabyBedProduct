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
                            @"诗歌美文",@"经典音乐",@"钢琴曲",@"古典音乐"];
    
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
        BBItemButton *button = [[BBItemButton alloc] initWithFrame:btFrame imgName:imageArrs[i] text:titleArrs[i]];
        button.tag = i+100;
        [button.tempBT addTarget:self action:@selector(itemClickedAction:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)itemClickedAction:(NSInteger)index
{
    if (self.itemClickedBlock) {
        self.itemClickedBlock(index-100);
    }
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

@implementation BBItemButton 
-(instancetype)initWithFrame:(CGRect)frame imgName:(NSString *)imgName text:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUIWithImgName:imgName text:text];
    }
    return self;
}
-(void)creatUIWithImgName:(NSString *)imgName text:(NSString *)text
{
    CGFloat totalW = self.width;
    CGFloat totalH = self.height;
    CGFloat imgW = 53;
    CGFloat imgX = (totalW-imgW)/2;
    
    self.topImgV = [UIImageView bb_imgVMakeWithSuperV:self imgName:imgName];
    self.bottomTextLB = [UILabel bb_lbMakeWithSuperV:self fontSize:12 alignment:NSTextAlignmentCenter textColor:k_color_515151];
    self.bottomTextLB.text = text;
    self.tempBT = [UIButton bb_btMakeWithSuperV:self imageName:nil];
    
    self.topImgV.frame = CGRectFlatMake(imgX, 8, imgW, imgW);
    self.bottomTextLB.frame = CGRectFlatMake(0, self.topImgV.bottom+8, totalW, 28);
    self.tempBT.frame = self.bounds;
    [self.tempBT addTarget:self action:@selector(itemClickedAction) forControlEvents:UIControlEventTouchUpInside];
    
}

@end
