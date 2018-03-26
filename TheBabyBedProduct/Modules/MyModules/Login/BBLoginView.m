//
//  BBLoginView.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBLoginView.h"
#import "PPTextfield.h"
#import <QMUIKit/QMUIButton.h>
#import "NSMutableAttributedString+PPTextField.h"
#import "UIImageView+EasilyMake.h"
#import "UIButton+EasilyMake.h"
#import "UILabel+EasilyMake.h"

@interface BBLoginView ()
@property(nonatomic,strong) PPTextfield *phoneTF;
@property(nonatomic,strong) PPTextfield *passwordTF;
@property(nonatomic,strong) QMUIFillButton *loginBT;
@end

@implementation BBLoginView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}
-(void)creatUI
{
    CGFloat leftMargin = 40;
    CGFloat totalH = 50;
    
    CGFloat imgW = 15;
    CGFloat imgH = 18;
    CGFloat tfL = 67.5;
    CGFloat tfW = _k_w-leftMargin-tfL;
    
    //手机号
    UIImageView *phoneImgV = [UIImageView bb_imgVMakeWithSuperV:self imgName:@"phone"];
    phoneImgV.frame = CGRectMake(leftMargin, 28+16, imgW, imgH);
    self.phoneTF = [self makeTFWithTag:301 fontSize:16 textColor:k_color_515151 attributedPlaceholderText:@"请输入手机号" attributedPlaceholderFontSize:16 attributedPlaceholderTextColor:k_color_153153153 superV:self];
    self.phoneTF.isPhoneNumber = YES;
    self.phoneTF.frame = CGRectMake(tfL, 28, tfW, totalH);
    BBWeakSelf(self)
    self.phoneTF.ppTextfieldTextChangedBlock = ^(PPTextfield *tf) {
        BBStrongSelf(self)
        [self textFieldTextDidChange:tf];
    };
    UIView *phoneLine = [[UIView alloc]initWithFrame:CGRectMake(leftMargin, 28+49.2, _k_w-leftMargin*2, 0.8)];
    phoneLine.backgroundColor = k_color_153153153;
    [self addSubview:phoneLine];
    
    //密码
    UIImageView *passwordImgV = [UIImageView bb_imgVMakeWithSuperV:self imgName:@"password"];
    passwordImgV.frame = CGRectMake(leftMargin, 28+50+16, imgW, imgH);
    self.passwordTF = [self makeTFWithTag:302 fontSize:16 textColor:k_color_515151 attributedPlaceholderText:@"请输入密码" attributedPlaceholderFontSize:16 attributedPlaceholderTextColor:k_color_153153153 superV:self];
    self.passwordTF.isPassword = YES;
    self.passwordTF.maxTextLength = 20;
    self.passwordTF.frame = CGRectMake(tfL, 28+50, tfW, totalH);
    self.passwordTF.ppTextfieldTextChangedBlock = ^(PPTextfield *tf) {
        BBStrongSelf(self)
        [self textFieldTextDidChange:tf];
    };
    UIView *passwordLine = [[UIView alloc]initWithFrame:CGRectMake(leftMargin, 28+99.2, _k_w-leftMargin*2, 0.8)];
    passwordLine.backgroundColor = k_color_153153153;
    [self addSubview:passwordLine];
    
    //忘记密码
    UIButton *forgetPasswordBT = [UIButton bb_btMakeWithSuperV:self bgColor:nil titleColor:k_color_153153153 titleFontSize:12 title:@"忘记密码?"];
    forgetPasswordBT.frame = CGRectMake(_k_w-leftMargin-60, 28+100, 60, 32);
    forgetPasswordBT.titleLabel.textAlignment = NSTextAlignmentRight;
    [forgetPasswordBT addTarget:self action:@selector(forgetPasswordAction) forControlEvents:UIControlEventTouchUpInside];
    
    //登录
    self.loginBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.loginBT];
    self.loginBT.titleLabel.font = [UIFont systemFontOfSize:18];
    self.loginBT.fillColor = rgb(255, 236, 183, 0.5);
    self.loginBT.titleTextColor = k_color_515151;
    [self.loginBT setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBT.frame = CGRectMake(leftMargin, CGRectGetMaxY(forgetPasswordBT.frame), _k_w-leftMargin*2, 47);
    self.loginBT.userInteractionEnabled = NO;
    [self.loginBT addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    
    //提示
    UILabel *recommenderLB = [UILabel bb_lbMakeWithSuperV:self fontSize:8 alignment:NSTextAlignmentCenter textColor:k_color_153153153];
    recommenderLB.frame = CGRectMake(0, CGRectGetMaxY(self.loginBT.frame), _k_w, 26);
    recommenderLB.text = @"为了更方便的接收告警消息,建议使用微信登录绑定";
    
    //第三方登录
    CGFloat thirdLoginLBW = 80;
    CGFloat margin2 = 50;
    CGFloat lineW = _k_w-margin2*2-thirdLoginLBW*2;
    
    CGFloat lineY = CGRectGetMaxY(recommenderLB.frame)+50;
    UIView *leftLine = [[UIView alloc]initWithFrame:CGRectMake(margin2, lineY, lineW, 1)];
    leftLine.backgroundColor = k_color_153153153;
    [self addSubview:leftLine];
    
    UILabel *thirdLoginLB = [UILabel bb_lbMakeWithSuperV:self fontSize:12 alignment:NSTextAlignmentCenter textColor:k_color_153153153];
    thirdLoginLB.frame = CGRectMake(leftLine.qmui_right, leftLine.qmui_top-9.5, thirdLoginLBW, 20);
    thirdLoginLB.text = @"第三方登录";
    
    UIView *rightLine = [[UIView alloc]initWithFrame:CGRectMake(thirdLoginLB.qmui_right, lineY, lineW, 1)];
    rightLine.backgroundColor = k_color_153153153;
    [self addSubview:rightLine];
    
    
    CGFloat margin3 = 64;
    CGFloat oneItemW = (_k_w-margin3*2)/3;
    NSArray *imgNames = @[
                        @"qq",
                        @"weixin",
                        @"weibo"
                           ];
    for (int i = 0; i<imgNames.count; i++) {
        UIButton *bt = [UIButton bb_btMakeWithSuperV:self imageName:imgNames[i]];
        bt.tag = 1000+i;
        bt.frame = CGRectMake(margin3+oneItemW*i, thirdLoginLB.qmui_bottom+5, oneItemW, oneItemW);
        CGFloat margin4 = (oneItemW-40)/2;
        [bt setImageEdgeInsets:UIEdgeInsetsMake(margin4, margin4, margin4, margin4)];
        [bt addTarget:self action:@selector(thirdLoginAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)thirdLoginAction:(UIButton *)bt
{
    if (self.thirdLoginBlock) {
        self.thirdLoginBlock(bt.tag-1000);
    }
}

-(void)textFieldTextDidChange:(PPTextfield *)tf
{
    NSString *toBeString = tf.text;
    if (tf.tag == 301) { //手机号
        self.phoneTF.text = toBeString;
    }else{
        self.passwordTF.text = toBeString;
    }
    
    //设置“登录”按钮不同时刻的颜色与可点不
    if (self.phoneTF.text.length > 0 && self.passwordTF.text.length > 0) {
        self.loginBT.userInteractionEnabled = YES;
        self.loginBT.fillColor = rgb(255, 236, 183, 1);
    }else{
        self.loginBT.userInteractionEnabled = NO;
        self.loginBT.fillColor = rgb(255, 236, 183, 0.5);

    }
    
}

-(void)forgetPasswordAction
{
    if (self.forgetPasswordBlock) {
        self.forgetPasswordBlock();
    }
}
-(void)loginAction
{
    if (self.loginBlock) {
        self.loginBlock(self.phoneTF.text, self.passwordTF.text);
    }
}

/**创建TF tag值 字体大小 字体颜色  attributed占位符 attributed占位符字体 attributed占位符颜色 父视图*/
-(PPTextfield *)makeTFWithTag:(NSInteger)tag fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor attributedPlaceholderText:(NSString *)attributedPlaceholderText attributedPlaceholderFontSize:(CGFloat)attributedPlaceholderFontSize attributedPlaceholderTextColor:(UIColor *)attributedPlaceholderTextColor superV:(UIView *)superV
{
    
    PPTextfield *tf = [[PPTextfield alloc]init];
    [superV addSubview:tf];
    tf.tag = tag;
    tf.font = [UIFont systemFontOfSize:fontSize];
    tf.textColor = textColor;
    NSMutableAttributedString *placeholderStr = [[NSMutableAttributedString alloc]initWithString:attributedPlaceholderText];
    [placeholderStr pp_setColor:attributedPlaceholderTextColor];
    [placeholderStr pp_setFont:[UIFont systemFontOfSize:attributedPlaceholderFontSize]];
    tf.attributedPlaceholder = placeholderStr;
    
    return tf;
}

@end
