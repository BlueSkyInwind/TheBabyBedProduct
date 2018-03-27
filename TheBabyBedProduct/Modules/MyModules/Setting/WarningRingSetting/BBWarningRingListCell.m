//
//  BBWarningRingListCell.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBWarningRingListCell.h"
#import "UILabel+EasilyMake.h"
#import "UIImageView+EasilyMake.h"

@interface BBWarningRingListCell ()
@property(nonatomic,strong) UILabel *ringNameLB;
@property(nonatomic,strong) UIImageView *selectedStatusImgV;
@property(nonatomic,strong) UIView *line;
@end

@implementation BBWarningRingListCell
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
-(void)setupCellWithRingName:(NSString *)ringName isSelected:(BOOL)isSelected
{
    if (ringName.length > 0) {
        self.ringNameLB.text = ringName;
    }
    self.imageView.image = [UIImage imageNamed:(isSelected?@"pitchon":@"unchecked")];
}
-(void)creatCellUI
{
    CGFloat leftMargin = 23;
    CGFloat rightMargin = 12;
    CGFloat imgW = 17;
    CGFloat imgMargin = 15;
    CGFloat nameLBW = _k_w-leftMargin-rightMargin*2-imgW;
    
    self.ringNameLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    self.ringNameLB.frame = CGRectMake(leftMargin, 0, nameLBW, self.height);
    
    self.selectedStatusImgV = [UIImageView bb_imgVMakeWithSuperV:self.contentView];
    self.selectedStatusImgV.frame = CGRectFlatMake(_k_w-rightMargin-imgW, imgMargin, imgW, imgW);
    
    self.line = [[UIView alloc]initWithFrame:CGRectFlatMake(leftMargin, self.height-0.5, _k_w-leftMargin-rightMargin, 0.5)];
    [self.contentView addSubview:self.line];
}
@end
