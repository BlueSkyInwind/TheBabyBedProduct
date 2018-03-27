//
//  BBMyListSubTitleCell.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMyListSubTitleCell.h"
#import "UILabel+EasilyMake.h"
#import "UIImageView+EasilyMake.h"

@interface BBMyListSubTitleCell ()
@property(nonatomic,strong) UIImageView *imgV;
@property(nonatomic,strong) UILabel *textLB;
@property(nonatomic,strong) UIImageView *arrowImgV;
@property(nonatomic,strong) UIView *line;

@property(nonatomic,strong) UILabel *subTextLB;
@end

@implementation BBMyListSubTitleCell

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
    self.subTextLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:14 alignment:NSTextAlignmentRight textColor:k_color_153153153];
    self.arrowImgV = [UIImageView bb_imgVMakeWithSuperV:self.contentView imgName:@"youyi"];
    
    CGFloat totalH = 47;
    CGFloat leftMargin = 20;
    CGFloat imgW = 19;
    CGFloat imgY = (totalH-19)/2;
    self.imgV.frame = CGRectMake(leftMargin, imgY, imgW, imgW);
    
    CGFloat arrowW = 6;
    CGFloat arrowH = 11;
    CGFloat arrowY = (totalH-arrowH)/2;
    CGFloat arrowX = _k_w-leftMargin-arrowW;
    
    CGFloat textLBX = self.imgV.right+8;
    CGFloat textLBW = 80;
    CGFloat subTextLBW = _k_w-leftMargin-textLBX-arrowW-5-80;
    
    self.textLB.frame = CGRectMake(textLBX, 0, textLBW, totalH);
    self.subTextLB.frame = CGRectMake(self.textLB.right, 0, subTextLBW, totalH);
    self.arrowImgV.frame = CGRectMake(arrowX, arrowY, arrowW, arrowH);
    
    self.line = [[UIView alloc]initWithFrame:CGRectFlatMake(leftMargin, 47, _k_w-leftMargin, 0.5)];
    [self.contentView addSubview:self.line];
    self.line.backgroundColor = kUIColorFromRGB(0xe0e0e0);}
@end
