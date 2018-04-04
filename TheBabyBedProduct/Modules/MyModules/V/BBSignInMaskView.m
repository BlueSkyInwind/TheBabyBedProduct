//
//  BBSignInMaskView.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/30.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBSignInMaskView.h"
@interface BBSignInMaskView ()
/** 弹窗展示内容view */
@property(nonatomic,strong)UIView *maskV;
@end

@implementation BBSignInMaskView
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
    self.frame = [UIScreen mainScreen].bounds;
    self.backgroundColor = [UIColor blackColor];
    self.alpha = 0.9;
    
    self.maskV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    self.maskV.backgroundColor = [UIColor clearColor];
    [self addSubview:self.maskV];
    
#warning todo 每日签到
    
}

-(void)bb_show
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    
    self.maskV.alpha = 0;
    [UIView animateWithDuration:1.2 delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.maskV.top -= _k_h;
        self.maskV.alpha = 1.0;
    } completion:nil];
}
-(void)bb_hidden
{
    [UIView animateWithDuration:0.3f animations:^{
        self.maskV.top += _k_h;
        self.maskV.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
