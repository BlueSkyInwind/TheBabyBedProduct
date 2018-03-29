//
//  BBFamilyMemberListCell.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/29.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBFamilyMemberListCell.h"

@interface BBFamilyMemberListCell ()
@property(nonatomic,strong) UIImageView *avatarImgV;
@property(nonatomic,strong) UILabel *userNameLB;
@property(nonatomic,strong) UILabel *timeLB;
@property(nonatomic,strong) QMUIFillButton *settingBT;
@end

@implementation BBFamilyMemberListCell

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
-(void)setupCellWithUser:(BBUser *)user
{
    if (user) {
#warning todo
    }
    //假数据
    self.avatarImgV.image = [UIImage imageNamed:@"grandma"];
    self.userNameLB.text = @"跳跳爷爷";
    self.timeLB.text = @"2018-03-29 21:34:24";
    
}
-(void)creatCellUI
{
    self.avatarImgV = [UIImageView bb_imgVMakeWithSuperV:self.contentView imgName:nil];
    self.avatarImgV.layer.masksToBounds = YES;
    self.avatarImgV.layer.cornerRadius = 25;
    
    self.userNameLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:15 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    self.timeLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:13 alignment:NSTextAlignmentLeft textColor:rgb(102, 102, 102, 1)];
    
    self.settingBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.settingBT];
    self.settingBT.titleLabel.font = [UIFont systemFontOfSize:16];
    self.settingBT.fillColor = rgb(255, 155, 57, 1);
    self.settingBT.titleTextColor = [UIColor whiteColor];
    self.settingBT.cornerRadius = 6;
    [self.settingBT setTitle:@"设置" forState:UIControlStateNormal];
    [self.settingBT addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat imgX = 10;
    CGFloat imgW = 50;
    CGFloat totalH = 100;
    CGFloat imgY = (totalH-imgW)/2;
    CGFloat settingBTW = 70;
    CGFloat totalW = _k_w-10;
    CGFloat lbW = totalW-self.avatarImgV.right-8-settingBTW-imgX;
    self.avatarImgV.frame = CGRectMake(imgX, imgY, imgW, imgW);
    self.userNameLB.frame = CGRectMake(self.avatarImgV.right+8, self.avatarImgV.top+2, lbW, 24);
    self.timeLB.frame = CGRectMake(self.userNameLB.left, self.userNameLB.bottom, lbW, 22);
    
    self.settingBT.frame = CGRectMake(totalW-imgX-settingBTW, 40, settingBTW, 30);
}
-(void)settingAction
{
    if (self.setOrCancelBlock) {
        self.setOrCancelBlock();
    }
}
-(void)setFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x+5, frame.origin.y+10, frame.size.width-10, frame.size.height-10);
    [super setFrame:frame];
}
@end
