//
//  BBEarlyEdutionMusicListCell.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/5/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBEarlyEdutionMusicListCell.h"
#import "UIImageView+WebCache.h"
@interface BBEarlyEdutionMusicListCell ()
@property(nonatomic,strong) UIImageView *avatarImgV;
@property(nonatomic,strong) UILabel *musicNameLB;
@property(nonatomic,strong) UILabel *musicMessLB;
@property(nonatomic,strong) UIButton *playBT;
@end

@implementation BBEarlyEdutionMusicListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self creatCellUI];
    }
    return self;
}
-(void)setupCell:(BBMusic *)music
{
#warning pp605 占位图设置
    [self.avatarImgV sd_setImageWithURL:[NSURL URLWithString:music.icon] placeholderImage:nil];
    self.musicNameLB.text = music.name;
    self.musicMessLB.text = [NSString stringWithFormat:@"%@-%@岁  %@",music.age_from,music.age_to,music.taxonomys];
    
}
-(void)creatCellUI
{
    CGFloat cellH = 64;
    CGFloat imgX = 14;
    CGFloat imgW = 40;
    CGFloat imgY = (cellH-imgW)/2;
    self.avatarImgV = [PPMAKE(PPMakeTypeImgV) pp_make:^(PPMake *make) {
        make.intoView(self.contentView);
        make.cornerRadius(20);
        make.frame(CGRectMake(imgX, imgY, imgW, imgW));
    }];
    
    CGFloat playBtW = 60;
    CGFloat musicNameX = self.avatarImgV.right+18;
    CGFloat musicNameY = 10;
    CGFloat musicNameW = _k_w-musicNameX-playBtW;
    
    self.musicNameLB = [PPMAKE(PPMakeTypeLB) pp_make:^(PPMake *make) {
        make.intoView(self.contentView);
        make.font(kFontRegular(16));
        make.textColor(k_color_515151);
        make.frame(CGRectMake(musicNameX, musicNameY, musicNameW, 24));
    }];
    
    self.musicMessLB = [PPMAKE(PPMakeTypeLB) pp_make:^(PPMake *make) {
        make.intoView(self.contentView);
        make.font(kFontRegular(13));
        make.textColor(k_color_153153153);
        make.frame(CGRectMake(musicNameX, self.musicNameLB.bottom, musicNameW, 20));
    }];
    
    self.playBT = [PPMAKE(PPMakeTypeBT) pp_make:^(PPMake *make) {
        make.intoView(self.contentView);
        make.frame(CGRectMake(_k_w-playBtW, 0, playBtW, cellH));
        make.normalImageName(@"yinyuebofang");
        make.addTargetTouchUpInside(self, @selector(playAction));
        make.setImageEdgeInsets(21.5, 19.5, 21.5, 19.5);
    }];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 63, _k_w, 1)];
    [self.contentView addSubview:line];
    line.backgroundColor = kUIColorFromRGB(0xf2f2f2);
    
}
-(void)playAction
{
    if (self.playBlock) {
        self.playBlock();
    }
}


@end
