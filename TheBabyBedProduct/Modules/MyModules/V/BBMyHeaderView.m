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
#import "PPLabel.h"

@interface BBMyHeaderView ()
@property(nonatomic,strong) BBUser *user;
@property(nonatomic,strong) UIImageView *avatarImgV;
@property(nonatomic,strong) PPLabel *userNameLB;
@property(nonatomic,strong) PPLabel *babyDaysLB;
@property(nonatomic,strong) UIButton*loginOrRegistBT;
@end

@implementation BBMyHeaderView

-(instancetype)initWithFrame:(CGRect)frame user:(BBUser *)user
{
    self = [super initWithFrame:frame];
    if (self) {
        if (user) {
            self.user = user;
            [self creatUI];
        }
    }
    return self;
}

-(void)creatUI
{
    self.avatarImgV = [UIImageView bb_imgVMakeWithSuperV:self imgName:nil];
    
//    self.userNameLB = [PPLabel alloc]initWithFrame:<#(CGRect)#>
    
}

@end
