//
//  BBEditInfoAvatarCell.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/30.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBEditInfoAvatarCell.h"
#import "UIImageView+WebCache.h"

@interface BBEditInfoAvatarCell ()
@property(nonatomic,strong) UILabel *userNameLB;
@property(nonatomic,strong) UIImageView *avatarImgV;
@property(nonatomic,strong) UIImageView *arrowImgV;
@end

@implementation BBEditInfoAvatarCell

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
-(void)setupCellAvatar:(NSString *)avatarUrl
{
    [self.avatarImgV sd_setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:[UIImage imageNamed:@"touxianggg"]];
}

-(void)creatCellUI
{
    self.userNameLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    self.userNameLB.text = @"头像";
    
    self.avatarImgV = [UIImageView bb_imgVMakeWithSuperV:self.contentView imgName:nil];
    self.avatarImgV.layer.masksToBounds = YES;
    self.avatarImgV.layer.cornerRadius = 25;
    
    self.arrowImgV = [UIImageView bb_imgVMakeWithSuperV:self.contentView imgName:@"youyi"];

    CGFloat totalH = 64;
    CGFloat leftMargin = 10;
    
    CGFloat arrowW = 6;
    CGFloat arrowH = 11;
    CGFloat arrowY = (totalH-arrowH)/2;
    CGFloat arrowX = _k_w-leftMargin-arrowW;
    
    CGFloat textLBW = 80;
    
    self.userNameLB.frame = CGRectMake(leftMargin, 0, textLBW, totalH);
    self.avatarImgV.frame = CGRectMake(arrowX-52, 7, 50, 50);
    self.arrowImgV.frame = CGRectMake(arrowX, arrowY, arrowW, arrowH);
}
-(void)setFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x, frame.origin.y+10, frame.size.width, frame.size.height-20);
    [super setFrame:frame];
}
@end
