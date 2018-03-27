//
//  BBMyListCell.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMyListCell.h"
#import "UILabel+EasilyMake.h"
#import "UIImageView+EasilyMake.h"

@interface BBMyListCell ()
@property(nonatomic,strong) UIImageView *imgV;
@property(nonatomic,strong) UILabel *textLB;
@property(nonatomic,strong) UIImageView *arrowImgV;
@property(nonatomic,strong) UIView *line;
@end

@implementation BBMyListCell

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
-(void)setupCellWithImgName:(NSString *)imgName title:(NSString *)title
{
    self.imgV.image = [UIImage imageNamed:imgName];
    self.textLB.text = title;
}
-(void)creatCellUI
{
    self.imgV = [UIImageView bb_imgVMakeWithSuperV:self.contentView];
    self.textLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
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
    CGFloat textLBW = _k_w-leftMargin-textLBX-arrowW-10;
    
    self.textLB.frame = CGRectMake(textLBX, 0, textLBW, totalH);
    self.arrowImgV.frame = CGRectMake(arrowX, arrowY, arrowW, arrowH);

    self.line = [[UIView alloc]initWithFrame:CGRectFlatMake(leftMargin, 47, _k_w-leftMargin, 0.5)];
    [self.contentView addSubview:self.line];
    self.line.backgroundColor = kUIColorFromRGB(0xe0e0e0);
}
@end
