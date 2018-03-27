//
//  BBMyHeaderView.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMyHeaderView.h"
#import "BBUser.h"
#import "BAButton.h"
#import "UIImageView+EasilyMake.h"
#import "UILabel+EasilyMake.h"
#import "UIButton+EasilyMake.h"

@interface BBMyHeaderView ()
@property(nonatomic,strong) BBUser *user;
@property(nonatomic,strong) UIImageView *avatarImgV;
@property(nonatomic,strong) UILabel *userNameLB;
@property(nonatomic,strong) UILabel *babyDaysLB;
@property(nonatomic,strong) UIButton*loginOrRegistBT;
@end

@implementation BBMyHeaderView

-(instancetype)initWithFrame:(CGRect)frame user:(BBUser *)user
{
    self = [super initWithFrame:frame];
    if (self) {
        if (user) {
            self.user = user;
        }
        [self creatUI];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

-(void)creatUI
{
    UIView *topBgV = [[UIView alloc]initWithFrame:CGRectFlatMake(0, 0, _k_w, 180+20)];
    topBgV.backgroundColor = rgb(252, 226, 122, 1);
    [self addSubview:topBgV];
    
    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectFlatMake(0, 200, _k_w, 72)];
    bottomV.backgroundColor = rgb(253, 249, 241, 1);
    [self addSubview:bottomV];
    
    UIView *otherV = [[UIView alloc]initWithFrame:CGRectMake(0, 272, _k_w, 12)];
    [self addSubview:otherV];
    otherV.backgroundColor = [UIColor whiteColor];
    
    UIView *realyBgV = [[UIView alloc]initWithFrame:CGRectMake(10, 20+64, _k_w-20, 180)];
    realyBgV.backgroundColor = [UIColor whiteColor];
    realyBgV.layer.masksToBounds = YES;
    realyBgV.layer.cornerRadius = 4;
    [self addSubview:realyBgV];
    
    self.avatarImgV = [UIImageView bb_imgVMakeWithSuperV:realyBgV imgName:@"touxianggg"];
    self.avatarImgV.layer.masksToBounds = YES;
    self.avatarImgV.layer.cornerRadius = 30;
    
    self.userNameLB = [UILabel bb_lbMakeWithSuperV:realyBgV fontSize:19 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    self.babyDaysLB = [UILabel bb_lbMakeWithSuperV:realyBgV fontSize:12 alignment:NSTextAlignmentLeft textColor:rgb(158, 158, 158, 1)];
    UIImageView *arrowImgV = [UIImageView bb_imgVMakeWithSuperV:realyBgV imgName:@"youyi"];
    
    CGFloat margin = 20;
    CGFloat arrowW = 6;
    CGFloat arrowH = 11;
    CGFloat oneH = 100;
    CGFloat arrowY = (oneH-arrowH)/2;
    CGFloat imgY = (oneH-60)/2;
    self.avatarImgV.frame = CGRectMake(margin, imgY, 60, 60);
    arrowImgV.frame = CGRectMake(realyBgV.qmui_width-margin-arrowW, arrowY,arrowW, arrowH);
    CGFloat lbW = arrowImgV.qmui_left-self.avatarImgV.qmui_right-10-8;
    self.userNameLB.frame = CGRectMake(self.avatarImgV.qmui_right+10, imgY+8, lbW, 24);
    self.babyDaysLB.frame = CGRectMake(self.userNameLB.qmui_left, imgY+8+24, lbW, 20);
    
    self.userNameLB.text = @"跳跳的爸爸";
    self.babyDaysLB.text = @"您的宝贝493天了";
    
    NSArray *imgs = @[@"gshebei",@"gjiating",@"gwode"];
    NSArray *titles = @[@"我的账户",@"我的设备",@"家庭成员"];
    for (int i = 0; i<imgs.count; i++) {
        QMUIButton *bt = [[QMUIButton alloc]init];
        bt.imagePosition = QMUIButtonImagePositionTop;// 将图片位置改为在文字上方
        bt.spacingBetweenImageAndTitle = 3;
        [realyBgV addSubview:bt];
        bt.tag = 110+i;
        CGFloat btw = (realyBgV.qmui_width-60)/3;
        bt.frame = CGRectMake(30+btw*i, 110, btw, 60);
        [bt bb_btSetTitle:titles[i]];
        [bt bb_btSetTitleColor:k_color_515151];
        [bt bb_btSetImageWithImgName:imgs[i]];
        bt.titleLabel.font = [UIFont systemFontOfSize:12];
    }
}

@end
