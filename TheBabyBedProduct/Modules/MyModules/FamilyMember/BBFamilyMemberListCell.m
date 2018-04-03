//
//  BBFamilyMemberListCell.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/29.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBFamilyMemberListCell.h"

@interface BBFamilyMemberListCell ()
{
    BOOL _isLeft;
}
@property(nonatomic,strong) UIImageView *avatarImgV;
@property(nonatomic,strong) UILabel *userNameLB;
@property(nonatomic,strong) UILabel *timeLB;
@property(nonatomic,strong) QMUIFillButton *setOrAgreeBT;
@property(nonatomic,strong) QMUIFillButton *refuseBT;
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
-(void)setupCellWithUser:(BBUser *)user isleft:(BOOL)isLeft
{
    
    if (user) {
#warning todo
    }
    _isLeft = isLeft;
    //假数据
    self.avatarImgV.image = [UIImage imageNamed:@"grandma"];
    self.userNameLB.text = @"跳跳爷爷";
    self.timeLB.text = @"2018-03-29 21:34:24";
    
    CGFloat imgX = 10;
    CGFloat setOrAgreeBTW = 70;
    CGFloat totalW = _k_w-10;
    
    if (isLeft) {
        self.refuseBT.hidden = YES;
        self.setOrAgreeBT.frame = CGRectMake(totalW-imgX-setOrAgreeBTW, 35, setOrAgreeBTW, 30);
        [self.setOrAgreeBT setTitle:@"设置" forState:UIControlStateNormal];

    }else{
        self.refuseBT.hidden = NO;
        self.setOrAgreeBT.frame = CGRectMake(totalW-imgX-setOrAgreeBTW, 15, setOrAgreeBTW, 30);
        self.refuseBT.frame = CGRectMake(totalW-imgX-setOrAgreeBTW, 15+30+10, setOrAgreeBTW, 30);
        [self.setOrAgreeBT setTitle:@"同意" forState:UIControlStateNormal];

    }
    
}
-(void)creatCellUI
{
    self.avatarImgV = [UIImageView bb_imgVMakeWithSuperV:self.contentView imgName:nil];
    self.avatarImgV.layer.masksToBounds = YES;
    self.avatarImgV.layer.cornerRadius = 25;
    
    self.userNameLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:15 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    self.timeLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:13 alignment:NSTextAlignmentLeft textColor:rgb(102, 102, 102, 1)];
    
    self.setOrAgreeBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.setOrAgreeBT];
    self.setOrAgreeBT.titleLabel.font = [UIFont systemFontOfSize:16];
    self.setOrAgreeBT.fillColor = rgb(255, 155, 57, 1);
    self.setOrAgreeBT.titleTextColor = [UIColor whiteColor];
    self.setOrAgreeBT.cornerRadius = 6;
    [self.setOrAgreeBT addTarget:self action:@selector(settingAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.refuseBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.refuseBT];
    self.refuseBT.titleLabel.font = [UIFont systemFontOfSize:16];
    self.refuseBT.titleTextColor = [UIColor whiteColor];
    self.refuseBT.fillColor = k_color_153153153;
    self.refuseBT.cornerRadius = 6;
    [self.refuseBT setTitle:@"拒绝" forState:UIControlStateNormal];
    [self.refuseBT addTarget:self action:@selector(refuseAction) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat imgX = 10;
    CGFloat imgW = 50;
    CGFloat totalH = 100;
    CGFloat imgY = (totalH-imgW)/2;
    CGFloat setOrAgreeBTW = 70;
    CGFloat totalW = _k_w-10;
    CGFloat lbW = totalW-self.avatarImgV.right-8-setOrAgreeBTW-imgX;
    self.avatarImgV.frame = CGRectMake(imgX, imgY, imgW, imgW);
    self.userNameLB.frame = CGRectMake(self.avatarImgV.right+8, self.avatarImgV.top+2, lbW, 24);
    self.timeLB.frame = CGRectMake(self.userNameLB.left, self.userNameLB.bottom, lbW, 22);
    
}
-(void)settingAction
{
    if (self.setOrCancelBlock) {
        self.setOrCancelBlock();
    }
}
-(void)refuseAction
{
    if (self.refuseBlock) {
        self.refuseBlock();
    }
}
-(void)setFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x+5, frame.origin.y+10, frame.size.width-10, frame.size.height-10);
    [super setFrame:frame];
}
@end
