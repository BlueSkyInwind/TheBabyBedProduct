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
#import "JKCountDownButton.h"

@interface BBRegistView ()
{
    BOOL _isAgree;
}
@property(nonatomic,strong) PPTextfield *phoneTF;
@property(nonatomic,strong) JKCountDownButton *getCodeBT;
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
    CGFloat leftMargin = 20;
    CGFloat totalH = 50;
    
    CGFloat imgW = 15;
    CGFloat imgH = 18;
    CGFloat tfL = 40;
    CGFloat tfW = _k_w-leftMargin-tfL;
    
    //手机号
    UIImageView *phoneImgV = [UIImageView bb_imgVMakeWithSuperV:self imgName:@"phone"];
    phoneImgV.frame = CGRectMake(leftMargin, 28+16, imgW, imgH);
    self.phoneTF = [PPTextfield pp_tfMakeWithSuperV:self tag:401 fontSize:16 textColor:k_color_515151 attributedPlaceholderText:@"请输入手机号码" attributedPlaceholderFontSize:16 attributedPlaceholderTextColor:k_color_153153153];
    self.phoneTF.isPhoneNumber = YES;
    self.phoneTF.frame = CGRectMake(tfL, 28, tfW-82-6, totalH);
    BBWeakSelf(self)
    self.phoneTF.ppTextfieldTextChangedBlock = ^(PPTextfield *tf) {
        BBStrongSelf(self)
        [self textFieldTextDidChange:tf];
    };
    
    self.getCodeBT = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    self.getCodeBT.frame = CGRectMake(self.phoneTF.right+6, 28+10, 82, 30);
    [self addSubview:self.getCodeBT];
    self.getCodeBT.titleLabel.font = [UIFont systemFontOfSize:12];
    self.getCodeBT.layer.masksToBounds = YES;
    self.getCodeBT.layer.borderWidth = 1;
    self.getCodeBT.layer.borderColor = rgb(255, 155, 57, 1).CGColor;
    self.getCodeBT.layer.cornerRadius = 4;
    [self.getCodeBT setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getCodeBT setTitle:@"获取验证码" forState:UIControlStateHighlighted];
    [self.getCodeBT setTitleColor:rgb(255, 155, 57, 1) forState:UIControlStateNormal];
    [self.getCodeBT setTitleColor:rgb(255, 155, 57, 1) forState:UIControlStateHighlighted];
    [self.getCodeBT countDownButtonHandler:^(JKCountDownButton *countDownButton, NSInteger tag) {
        countDownButton.enabled = NO;
        [self getVerifyCodeRequest:countDownButton];
    }];
    
    UIView *phoneLine = [[UIView alloc]initWithFrame:CGRectMake(leftMargin, 28+49.2, _k_w-leftMargin*2, 0.8)];
    phoneLine.backgroundColor = K_color_line;
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
    codeLine.backgroundColor = K_color_line;
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
    passwordLine.backgroundColor = K_color_line;
    [self addSubview:passwordLine];
    
    //注册
    self.registBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.registBT];
    self.registBT.titleLabel.font = [UIFont systemFontOfSize:18];
    self.registBT.fillColor = rgb(255, 236, 183, 0.5);
    self.registBT.titleTextColor = k_color_515151;
    [self.registBT setTitle:@"注  册" forState:UIControlStateNormal];
    self.registBT.frame = CGRectMake(leftMargin, self.passwordTF.bottom+45, _k_w-leftMargin*2, 47);
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
    self.agreeProtocolBT.frame = CGRectMake(protocolMargin, self.registBT.bottom+5, btnW, btnW);
    [self.agreeProtocolBT setImageEdgeInsets:UIEdgeInsetsMake(4.5, 4.5, 4.5, 4.5)];
    [self.agreeProtocolBT addTarget:self action:@selector(agreeProtocolAction) forControlEvents:UIControlEventTouchUpInside];
    _isAgree = YES;
    
    UILabel *agreeProtocolLB = [[UILabel alloc]initWithFrame:CGRectMake(self.agreeProtocolBT.right, self.agreeProtocolBT.top, protocolIntroW, btnW)];
    [self addSubview:agreeProtocolLB];
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc]initWithString:protocolIntro];
    [mutStr pp_setFont:[UIFont systemFontOfSize:12]];
    [mutStr pp_setColor:k_color_153153153 range:[mutStr.string rangeOfString:protocolIntro1]];
    [mutStr pp_setColor:rgb(255, 155, 57, 1) range:[mutStr.string rangeOfString:protocolIntro2]];
    agreeProtocolLB.attributedText = mutStr;
    
    UIButton *tempBT = [UIButton bb_btMakeWithSuperV:self imageName:nil];
    tempBT.frame = CGRectFlatMake(agreeProtocolLB.left+protocolIntroW/2-15, agreeProtocolLB.top, protocolIntroW/2+15, btnW);
    [tempBT addTarget:self action:@selector(clickProtocolAction) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark --- "获取验证码"点击事件
-(void)getVerifyCodeRequest:(JKCountDownButton *)btn
{
    [btn countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
        NSString *title = [NSString stringWithFormat:@"%zd秒",second];
        countDownButton.enabled = NO;
        return title;
    }];
    [btn countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
        countDownButton.enabled = YES;
        return @"重新获取";
        
    }];
    
    NSString *phoneStr = [self.phoneTF.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![GlobalTool isMobileNumber:phoneStr]){
        [QMUITips showWithText:@"手机号格式不正确" inView:self.superview hideAfterDelay:2];
        [btn stopCountDown];
        btn.enabled = YES;
        return;
    }
    
    if (self.getCodeBlock) {
        self.getCodeBlock();
    }
    
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

