//
//  BBLoginRegistHeaderView.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBLoginRegistHeaderView.h"

@interface BBLoginRegistHeaderView ()
@property(nonatomic,strong) UIImageView *bgImgV;
@property(nonatomic,strong) UIButton *closeBT;
@property(nonatomic,strong) UIButton *loginBT;
@property(nonatomic,strong) UIButton *registBT;
@end

@implementation BBLoginRegistHeaderView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI
{
    self.bgImgV = [UIImageView bb_imgVMakeWithSuperV:self imgName:@"mybackground"];
    self.bgImgV.frame = self.bounds;
    
    self.closeBT = [UIButton bb_btMakeWithSuperV:self imageName:@"close"];
    self.closeBT.frame = CGRectMake(0, 20, 54, 54);
    [self.closeBT setImageEdgeInsets:UIEdgeInsetsMake(4, 16, 28, 16)];
    [self.closeBT addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.loginBT = [UIButton bb_btMakeWithSuperV:self bgColor:[UIColor clearColor] titleColor:[UIColor whiteColor] titleFontSize:16 title:@"登录"];
    self.registBT = [UIButton bb_btMakeWithSuperV:self bgColor:[UIColor clearColor] titleColor:[UIColor whiteColor] titleFontSize:16 title:@"注册"];
    self.loginBT.frame = CGRectMake(0, 200-56, _k_w/2, 56);
    self.registBT.frame = CGRectMake(_k_w/2, 200-56, _k_w/2, 56);
    
    [self.loginBT addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [self.registBT addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];

    self.loginBT.alpha = 1.0;
    self.registBT.alpha = 0.5;
    
}
-(void)configureCloseBTWithNeedHidden:(BOOL)needHidden
{
    self.closeBT.hidden = needHidden;
}
-(void)closeAction
{
    [self endEditing:YES];
    
    if (self.closeBlock) {
        self.closeBlock();
    }
}
-(void)loginAction
{
    self.bgImgV.image = [UIImage imageNamed:@"mybackground"];
    self.loginBT.alpha = 1.0;
    self.registBT.alpha = 0.5;
    if (self.LoginRegistSelectedBlock) {
        self.LoginRegistSelectedBlock(YES);
    }
}
-(void)registAction
{
    self.bgImgV.image = [UIImage imageNamed:@"mebackground"];
    self.loginBT.alpha = 0.5;
    self.registBT.alpha = 1.0;
    
    if (self.LoginRegistSelectedBlock) {
        self.LoginRegistSelectedBlock(NO);
    }
}
@end



