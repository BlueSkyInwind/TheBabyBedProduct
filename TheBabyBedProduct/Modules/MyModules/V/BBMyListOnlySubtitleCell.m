//
//  BBMyListOnlySubtitleCell.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMyListOnlySubtitleCell.h"
#import "UILabel+EasilyMake.h"
#import "UIImageView+EasilyMake.h"

@interface BBMyListOnlySubtitleCell ()
@property(nonatomic,strong) UIImageView *imgV;
@property(nonatomic,strong) UILabel *textLB;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UILabel *subTextLB;

@end

@implementation BBMyListOnlySubtitleCell

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
-(void)setupCellWithImgName:(NSString *)imgName title:(NSString *)title subTitle:(NSString *)subTitle
{
    self.imgV.image = [UIImage imageNamed:imgName];
    self.textLB.text = title;
    self.subTextLB.text = subTitle;
}
-(void)creatCellUI
{
    self.imgV = [UIImageView bb_imgVMakeWithSuperV:self.contentView];
    self.textLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    self.subTextLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:16 alignment:NSTextAlignmentRight textColor:k_color_515151];
    
    CGFloat totalH = 47;
    CGFloat leftMargin = 20;
    CGFloat imgW = 19;
    CGFloat imgY = (totalH-19)/2;
    self.imgV.frame = CGRectMake(leftMargin, imgY, imgW, imgW);
    
    CGFloat subTitleW = 60;
    
    CGFloat textLBX = self.imgV.right+8;
    CGFloat textLBW = _k_w-leftMargin-textLBX-subTitleW;
    
    self.textLB.frame = CGRectMake(textLBX, 0, textLBW, totalH);
    self.subTextLB.frame = CGRectMake(_k_w-leftMargin-subTitleW, 0, subTitleW, totalH);
    
    self.line = [[UIView alloc]initWithFrame:CGRectFlatMake(leftMargin, 47, _k_w-leftMargin, 0.5)];
    [self.contentView addSubview:self.line];
    self.line.backgroundColor = kUIColorFromRGB(0xe0e0e0);}

@end
