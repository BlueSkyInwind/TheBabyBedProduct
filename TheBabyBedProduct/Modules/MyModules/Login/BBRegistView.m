//
//  BBRegistView.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBRegistView.h"
#import "PPTextfield.h"
#import "PPTextfield+EasilyMake.h"
#import "NSMutableAttributedString+PPTextField.h"
#import "UIButton+EasilyMake.h"
#import "UIImageView+EasilyMake.h"
#import "PPTextfield+EasilyMake.h"
#import "UILabel+EasilyMake.h"

@interface BBRegistView ()
{
    BOOL _isAgree;
}
@property(nonatomic,strong) PPTextfield *phoneTF;
@property(nonatomic,strong) PPTextfield *codeTF;
@property(nonatomic,strong) PPTextfield *passwordTF;
@property(nonatomic,strong) QMUIFillButton *registBT;
@property(nonatomic,strong) UIButton *agreeProtocolBT;
@property(nonatomic,strong) UIButton *protocolNameBT;
@end

@implementation BBRegistView

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
    CGFloat leftMargin = 40;
    CGFloat totalH = 50;
    
    CGFloat imgW = 15;
    CGFloat imgH = 18;
    CGFloat tfL = 67.5;
    CGFloat tfW = _k_w-leftMargin-tfL;
    
    //手机号
    UIImageView *phoneImgV = [UIImageView bb_imgVMakeWithSuperV:self imgName:@"phone"];
    phoneImgV.frame = CGRectMake(leftMargin, 28+16, imgW, imgH);
    self.phoneTF = [PPTextfield pp_tfMakeWithSuperV:self tag:401 fontSize:16 textColor:k_color_515151 attributedPlaceholderText:@"请输入手机号码" attributedPlaceholderFontSize:16 attributedPlaceholderTextColor:k_color_153153153];
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
    
    //验证码
    UIImageView *codeImgV = [UIImageView bb_imgVMakeWithSuperV:self imgName:@"verification"];
    codeImgV.frame = CGRectMake(leftMargin, 28+50+16, imgW, imgH);
    self.codeTF = [PPTextfield pp_tfMakeWithSuperV:self tag:402 fontSize:16 textColor:k_color_515151 attributedPlaceholderText:@"请输入验证码" attributedPlaceholderFontSize:16 attributedPlaceholderTextColor:k_color_153153153];
    self.codeTF.isOnlyNumber = YES;
    self.codeTF.maxNumberCount = 6;
    self.codeTF.frame = CGRectMake(tfL, 28+50, tfW, totalH);
    self.codeTF.ppTextfieldTextChangedBlock = ^(PPTextfield *tf) {
        BBStrongSelf(self)
        [self textFieldTextDidChange:tf];
    };
    UIView *codeLine = [[UIView alloc]initWithFrame:CGRectMake(leftMargin, 28+99.2, _k_w-leftMargin*2, 0.8)];
    codeLine.backgroundColor = k_color_153153153;
    [self addSubview:codeLine];
    
    //密码
    UIImageView *passwordImgV = [UIImageView bb_imgVMakeWithSuperV:self imgName:@"password"];
    passwordImgV.frame = CGRectMake(leftMargin, 28+100+16, imgW, imgH);
    self.passwordTF = [PPTextfield pp_tfMakeWithSuperV:self tag:403 fontSize:16 textColor:k_color_515151 attributedPlaceholderText:@"请输入密码" attributedPlaceholderFontSize:16 attributedPlaceholderTextColor:k_color_153153153];
    self.passwordTF.isPassword = YES;
    self.passwordTF.maxTextLength = 20;
    self.passwordTF.frame = CGRectMake(tfL, 28+100, tfW, totalH);
    self.passwordTF.ppTextfieldTextChangedBlock = ^(PPTextfield *tf) {
        BBStrongSelf(self)
        [self textFieldTextDidChange:tf];
    };
    UIView *passwordLine = [[UIView alloc]initWithFrame:CGRectMake(leftMargin, 28+149.2, _k_w-leftMargin*2, 0.8)];
    passwordLine.backgroundColor = k_color_153153153;
    [self addSubview:passwordLine];
    
    //注册
    self.registBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.registBT];
    self.registBT.titleLabel.font = [UIFont systemFontOfSize:18];
    self.registBT.fillColor = rgb(255, 236, 183, 0.5);
    self.registBT.titleTextColor = k_color_515151;
    [self.registBT setTitle:@"登录" forState:UIControlStateNormal];
    self.registBT.frame = CGRectMake(leftMargin, self.passwordTF.qmui_bottom+45, _k_w-leftMargin*2, 47);
    self.registBT.userInteractionEnabled = NO;
    [self.registBT addTarget:self action:@selector(registAction) forControlEvents:UIControlEventTouchUpInside];
    
    //协议
    NSString *protocolIntro1 = @"我已阅读并同意";
    NSString *protocolIntro2 = @"《软件注册协议》";
    NSString *protocolIntro = [protocolIntro1 stringByAppendingString:protocolIntro2];
    CGFloat protocolIntroW = [UILabel bb_calculateWidthWithFont:[UIFont systemFontOfSize:12] height:20 text:protocolIntro];
    CGFloat btnW = 20;
    CGFloat btnAndLbW = protocolIntroW+btnW;
    CGFloat protocolMargin = (_k_w-btnAndLbW)/2;
    
    self.agreeProtocolBT = [UIButton bb_btMakeWithSuperV:self imageName:@"pitchon"];
    self.agreeProtocolBT.frame = CGRectMake(protocolMargin, self.registBT.qmui_bottom+5, btnW, btnW);
    [self.agreeProtocolBT setImageEdgeInsets:UIEdgeInsetsMake(4.5, 4.5, 4.5, 4.5)];
    [self.agreeProtocolBT addTarget:self action:@selector(agreeProtocolAction) forControlEvents:UIControlEventTouchUpInside];
    _isAgree = YES;
    
    UILabel *agreeProtocolLB = [[UILabel alloc]initWithFrame:CGRectMake(self.agreeProtocolBT.qmui_right, self.agreeProtocolBT.qmui_top, protocolIntroW, btnW)];
    [self addSubview:agreeProtocolLB];
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc]initWithString:protocolIntro];
    [mutStr pp_setFont:[UIFont systemFontOfSize:12]];
    [mutStr pp_setColor:k_color_153153153 range:[mutStr.string rangeOfString:protocolIntro1]];
    [mutStr pp_setColor:rgb(255, 155, 57, 1) range:[mutStr.string rangeOfString:protocolIntro2]];
    agreeProtocolLB.attributedText = mutStr;
    
    UIButton *tempBT = [UIButton bb_btMakeWithSuperV:self imageName:nil];
    tempBT.frame = CGRectFlatMake(agreeProtocolLB.qmui_left+protocolIntroW/2-15, agreeProtocolLB.qmui_top, protocolIntroW/2+15, btnW);
    [tempBT addTarget:self action:@selector(clickProtocolAction) forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)clickProtocolAction
{
    if (self.clickProtocolBlock) {
        self.clickProtocolBlock();
    }
}

-(void)agreeProtocolAction
{
    if (_isAgree) {
        [self.agreeProtocolBT bb_btSetImageWithImgName:@"unchecked"];
    }else{
        [self.agreeProtocolBT bb_btSetImageWithImgName:@"pitchon"];
    }
    _isAgree = !_isAgree;
    
    if (self.agreeProtocolBlock) {
        self.agreeProtocolBlock(_isAgree);
    }
}

-(void)registAction
{
    if (self.registBlock) {
        self.registBlock(self.phoneTF.text, self.codeTF.text, self.passwordTF.text);
    }
}
-(void)textFieldTextDidChange:(PPTextfield *)tf
{
    NSString *toBeString = tf.text;
    if (tf.tag == 401) { //手机号
        self.phoneTF.text = toBeString;
    }else if (tf.tag == 402){
        //验证码
        self.codeTF.text = toBeString;
    }else{
        self.passwordTF.text = toBeString;
    }
    
    //设置“登录”按钮不同时刻的颜色与可点不
    if (self.phoneTF.text.length > 0 && self.codeTF.text.length > 0 && self.passwordTF.text.length > 0) {
        self.registBT.userInteractionEnabled = YES;
        self.registBT.fillColor = rgb(255, 236, 183, 1);
    }else{
        self.registBT.userInteractionEnabled = NO;
        self.registBT.fillColor = rgb(255, 236, 183, 0.5);
    }
    
}
@end

