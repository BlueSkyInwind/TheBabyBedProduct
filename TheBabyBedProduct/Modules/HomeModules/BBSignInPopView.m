//
//  BBSignInPopView.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/16.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBSignInPopView.h"
typedef void(^signInB)(BBSignInPopView *popV);

@interface BBSignInPopView ()
/**弹窗View*/
@property (nonatomic,strong)UIView * alertView;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UIButton *closeBtn;
@property(nonatomic,strong) UIButton *signInBtn;
@property(nonatomic,strong) UIView *goldBgV;
@property(nonatomic,strong) UIView *signInSuccessBgV;
@end

@implementation BBSignInPopView
+(instancetype)signInPopView
{
    BBSignInPopView *popV = [[BBSignInPopView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    return popV;
}


-(void)show
{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    self.alertView.transform = CGAffineTransformMakeScale(1.21, 1.21);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1, 1);
        self.alertView.alpha = 1;
    } completion:nil];
}

-(void)hidden
{
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1, 1);
        self.alertView.alpha = 1;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = rgb(0, 0, 0, 0.8);
        [self configureView];
    }
    return  self;
}


-(void)CloseBtnClick:(id)sender{
    [self hidden];
}

-(void)configureView{
    
    _alertView = [[UIView alloc]init];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = 10;
    _alertView.clipsToBounds = true;
    _alertView.layer.borderWidth = 1;
    _alertView.layer.borderColor = rgb(255, 155, 57, 1).CGColor;
    [self addSubview:_alertView];
    [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.equalTo(@220);
        make.width.equalTo(@245);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    _titleLabel.text = @"每日签到\n坚持每日签到领取金币";
    [_alertView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_alertView.mas_top).with.offset(15);
        make.left.right.equalTo(_alertView);
        make.height.equalTo(@40);
    }];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setImage:[UIImage imageNamed:@"popClose_Icon"] forState:UIControlStateNormal];
    _closeBtn.layer.cornerRadius = 3;
    _closeBtn.clipsToBounds = true;
    [_closeBtn addTarget:self action:@selector(CloseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_closeBtn];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_alertView.mas_top).with.offset(12);
        make.right.equalTo(_alertView.mas_right).offset(-12);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    _goldBgV = [[UIView alloc]init];
    [_alertView addSubview:_goldBgV];
    [_goldBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(_alertView);
        make.width.equalTo(_alertView.mas_width);
        make.height.equalTo(@90);
    }];
    for (int i = 0; i < 7; i++) {
        UIImageView *imgV = [UIImageView bb_imgVMakeWithSuperV:_goldBgV imgName:@"gold"];
        if (i < 4) {
            [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_goldBgV.mas_top);
                make.width.height.equalTo(@40);
                make.left.equalTo(_goldBgV.mas_left).offset(20+55*i);
            }];
        }else{
            [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(_goldBgV.mas_bottom);
                make.width.height.equalTo(@40);
                make.left.equalTo(_goldBgV.mas_left).offset(47.5+55*(i-4));
            }];
        }
    }
    
    
    _signInBtn = [UIButton bb_btMakeWithSuperV:_alertView bgColor:k_color_appOrange titleColor:[UIColor whiteColor] titleFontSize:14 title:@"签到"];
    _signInBtn.layer.cornerRadius = 15;
    _signInBtn.clipsToBounds = true;
    _signInBtn.layer.borderWidth = 1;
    _signInBtn.layer.borderColor = rgb(255, 155, 57, 1).CGColor;
    [_signInBtn addTarget:self action:@selector(signInAction) forControlEvents:UIControlEventTouchUpInside];
    [_signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_alertView.mas_bottom).offset(-15);
        make.centerX.equalTo(_alertView);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    _signInSuccessBgV = [[UIView alloc]init];
    [_alertView addSubview:_signInSuccessBgV];
    [_signInSuccessBgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_alertView.mas_top).offset(30);
        make.centerX.equalTo(_alertView);
        make.width.equalTo(_alertView.mas_width);
        make.height.equalTo(@70);
    }];
    
    UIImageView *signInSuccessImgV = [UIImageView bb_imgVMakeWithSuperV:_signInSuccessBgV imgName:@"signinOrange"];
    [signInSuccessImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(_signInSuccessBgV);
        make.height.equalTo(@40);
        make.width.equalTo(@38);
    }];
    
    UILabel *signInSuccessLb = [UILabel bb_lbMakeWithSuperV:_signInSuccessBgV fontSize:14 alignment:NSTextAlignmentCenter textColor:k_color_appOrange];
    signInSuccessLb.text = @"已获得两个金币";
    [signInSuccessLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.width.equalTo(_signInSuccessBgV);
        make.height.equalTo(@20);
    }];
    _signInSuccessBgV.hidden = YES;

}
-(void)signInAction
{
    if (self.signInBlock) {
        self.signInBlock();
    }
}
-(void)signInSuccess
{
    _signInSuccessBgV.hidden = NO;
    _signInSuccessBgV.alpha = 0;
    _titleLabel.alpha = 0.3;
    _goldBgV.alpha = 0.3;
    _signInBtn.alpha = 0.3;
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.alertView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@130);
        }];
        _signInSuccessBgV.alpha = 1;
        _titleLabel.alpha = 0;
        _goldBgV.alpha = 0;
        _signInBtn.alpha = 0;
    } completion:^(BOOL finished) {
        _titleLabel.hidden = YES;
        _goldBgV.hidden = YES;
        _signInBtn.hidden = YES;
    }];
}
@end
