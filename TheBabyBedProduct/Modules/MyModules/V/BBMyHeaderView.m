//
//  BBMyHeaderView.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMyHeaderView.h"
#import "BBUser.h"
#import "UIImageView+WebCache.h"

@interface BBMyHeaderView ()
@property(nonatomic,strong) BBUser *user;
@property(nonatomic,strong) UIImageView *avatarImgV;
@property(nonatomic,strong) UILabel *userNameLB;
@property(nonatomic,strong) UILabel *babyDaysLB;
@property(nonatomic,strong) UIButton*loginOrRegistBT;
/** 上半部分可点击 */
@property(nonatomic,strong) UIView *clickedTempView;
@end

@implementation BBMyHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.user = [BBUser bb_getUser];
        [self creatUI];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}
-(void)updateUserMess
{
    self.user = [BBUser bb_getUser];
    [self judgeItemShowOrHidden];
}

-(void)creatUI
{
    UIView *topBgV = [[UIView alloc]initWithFrame:CGRectFlatMake(0, 0, _k_w, 180+20)];
    topBgV.backgroundColor = UI_MAIN_COLOR;
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
    self.avatarImgV.userInteractionEnabled = YES;
   
    
    self.userNameLB = [UILabel bb_lbMakeWithSuperV:realyBgV fontSize:19 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    self.babyDaysLB = [UILabel bb_lbMakeWithSuperV:realyBgV fontSize:12 alignment:NSTextAlignmentLeft textColor:rgb(158, 158, 158, 1)];
    
    self.loginOrRegistBT = [UIButton bb_btMakeWithSuperV:realyBgV imageName:nil];
    [self.loginOrRegistBT bb_btSetTitle:@"登录/注册"];
    [self.loginOrRegistBT bb_btSetTitleColor:k_color_515151];
    [self.loginOrRegistBT setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    self.loginOrRegistBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    self.loginOrRegistBT.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.loginOrRegistBT addTarget:self action:@selector(loginOrRegistAction) forControlEvents:UIControlEventTouchUpInside];

    UIImageView *arrowImgV = [UIImageView bb_imgVMakeWithSuperV:realyBgV imgName:@"youyi"];
    
    CGFloat margin = 20;
    CGFloat arrowW = 6;
    CGFloat arrowH = 11;
    CGFloat oneH = 100;
    CGFloat arrowY = (oneH-arrowH)/2;
    CGFloat imgY = (oneH-60)/2;
    self.avatarImgV.frame = CGRectMake(margin, imgY, 60, 60);
    arrowImgV.frame = CGRectMake(realyBgV.width-margin-arrowW, arrowY,arrowW, arrowH);
    CGFloat lbW = arrowImgV.left-self.avatarImgV.right-10-8;
    self.userNameLB.frame = CGRectMake(self.avatarImgV.right+10, imgY+8, lbW, 24);
    self.babyDaysLB.frame = CGRectMake(self.userNameLB.left, imgY+8+24, lbW, 20);
    
    self.loginOrRegistBT.frame = CGRectMake(self.avatarImgV.right+10, imgY+8, realyBgV.width-self.avatarImgV.right-10, 44);
    
    NSArray *imgs = @[@"gshebei",@"gjiating",@"gwode"];
    NSArray *titles = @[@"我的账户",@"我的设备",@"家庭成员"];
    for (int i = 0; i<imgs.count; i++) {
        QMUIButton *bt = [[QMUIButton alloc]init];
        bt.imagePosition = QMUIButtonImagePositionTop;// 将图片位置改为在文字上方
        bt.spacingBetweenImageAndTitle = 6;
        [realyBgV addSubview:bt];
        bt.tag = 110+i;
        CGFloat btw = (realyBgV.width-60)/3;
        bt.frame = CGRectMake(30+btw*i, 110, btw, 60);
        [bt bb_btSetTitle:titles[i]];
        [bt bb_btSetTitleColor:k_color_515151];
        [bt bb_btSetImageWithImgName:imgs[i]];
        bt.titleLabel.font = [UIFont systemFontOfSize:12];
        [bt addTarget:self action:@selector(funcAction:) forControlEvents:UIControlEventTouchUpInside];
    }

    [self judgeItemShowOrHidden];
    
    self.clickedTempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, realyBgV.width, 100)];
    [realyBgV addSubview:self.clickedTempView];
    self.clickedTempView.backgroundColor = [UIColor clearColor];
    [self.clickedTempView pp_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self handelAvatarTapAction];
    }];
}

-(void)judgeItemShowOrHidden
{
    /*
     第一次注册登录成功后返回的数据如下：
     response json --- {
     code = 0;
     data =     {
     bindQQ = 0;
     bindWB = 0;
     bindWX = 0;
     deviceId = "";
     id = 5000809708864ed6bbe3f9500e046f93; //49a1a9a681c94a47adbc5129c12851bc
     manager = 1;
     totalScore = 0;
     username = 16602103722;
     videoAuth = 1;
     };
     msg = "请求成功";
     }
     */
    if (BBUserHelpers.hasLogined) {
        self.userNameLB.text = [self.user.nickName bb_safe];
        if ([self.user.identity bb_isSafe]) {
            self.userNameLB.text = [NSString stringWithFormat:@"%@的%@",[self.user.nickName bb_safe], [self.user.identity bb_safe]];
        }
        if (self.user.both && [self.user.both integerValue] > 0) {
            self.babyDaysLB.text = [self.user.both bb_timeIntervalFromTimestamp];
            self.babyDaysLB.hidden = NO;
        }else{
            self.babyDaysLB.text = @"";
            self.babyDaysLB.hidden = YES;
            CGFloat oneH = 100;
            CGFloat imgY = (oneH-60)/2;
            CGFloat lbW = _k_w-20-20-6-self.avatarImgV.right-10-8;
            self.userNameLB.frame = CGRectMake(self.avatarImgV.right+10, imgY+8, lbW, 24+20);
        }
        
        self.userNameLB.hidden = NO;
        self.loginOrRegistBT.hidden = YES;
        if ([self.user.avatar bb_isSafe]) {
            [self.avatarImgV sd_setImageWithURL:[NSURL URLWithString:[K_Url_GetImg stringByAppendingString:self.user.avatar]] placeholderImage:[UIImage imageNamed:@"touxianggg"]];
        }else{
            self.avatarImgV.image = [UIImage imageNamed:@"touxianggg"];
        }
        
    }else{
        self.userNameLB.hidden = YES;
        self.babyDaysLB.hidden = YES;
        self.loginOrRegistBT.hidden = NO;
        self.avatarImgV.image = [UIImage imageNamed:@"touxianggg"];
    }
    BBUserHelpers.myHeaderVHasLogined = BBUserHelpers.hasLogined;
}
-(void)handelAvatarTapAction
{
    if (self.avatarClickedBlock) {
        self.avatarClickedBlock();
    }
}

-(void)funcAction:(QMUIButton *)bt
{
    if (self.funcBlock) {
        self.funcBlock(bt.tag-110);
    }
}
-(void)loginOrRegistAction
{
    if (self.loginOrRegistBlock) {
        self.loginOrRegistBlock(self);
    }
}

@end
