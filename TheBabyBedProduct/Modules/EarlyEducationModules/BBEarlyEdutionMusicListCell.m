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
    
}
-(void)creatCellUI
{
    self.avatarImgV = [UIImageView bb_imgVMakeWithSuperV:self.contentView];
    
    self.musicNameLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    self.playBT = [UIButton bb_btMakeWithSuperV:self.contentView imageName:@"yinyuebofang"];
    [self.playBT addTarget:self action:@selector(playAction) forControlEvents:UIControlEventTouchUpInside];
    [self configureFrame];
}
-(void)playAction
{
    if (self.playBlock) {
        self.playBlock();
    }
}
-(void)configureFrame
{
    CGFloat cellH = 64;
    CGFloat imgX = 14;
    CGFloat imgW = 40;
    CGFloat imgY = (cellH-imgW)/2;
    self.avatarImgV.layer.masksToBounds = YES;
    self.avatarImgV.layer.cornerRadius = imgW/2;
    self.avatarImgV.frame = CGRectMake(imgX, imgY, imgW, imgW);
    
    CGFloat playBtW = 60;
    CGFloat musicNameX = self.avatarImgV.right+18;
    CGFloat musicNameY = 0;
    CGFloat musicNameW = _k_w-musicNameX-playBtW;
    self.musicNameLB.frame = CGRectMake(musicNameX, musicNameY, musicNameW, cellH);
        
    self.playBT.frame = CGRectMake(_k_w-playBtW, 0, playBtW, cellH);
    //41*41
    [self.playBT setImageEdgeInsets:UIEdgeInsetsMake(21.5, 19.5, 21.5, 19.5)];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 62.5, _k_w, 1.5)];
    [self.contentView addSubview:line];
    line.backgroundColor = kUIColorFromRGBA(0x515151,0.1);
}

@end
