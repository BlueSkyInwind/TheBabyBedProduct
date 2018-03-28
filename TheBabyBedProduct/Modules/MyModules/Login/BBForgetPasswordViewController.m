//
//  BBForgetPasswordViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBForgetPasswordViewController.h"
#import "PPTextfield.h"
#import "PPTextfield+EasilyMake.h"
#import "UIImageView+EasilyMake.h"
#import "JKCountDownButton.h"
#import "UIButton+EasilyMake.h"

@interface BBForgetPasswordViewController ()
@property(nonatomic,strong) PPTextfield *phoneTF;
@property(nonatomic,strong) PPTextfield *codeTF;
@property(nonatomic,strong) PPTextfield *passwordTF;
@property(nonatomic,strong) QMUIFillButton *submitBT;
@property(nonatomic,strong) JKCountDownButton *getCodeBT;
@end

@implementation BBForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatUI];
}
-(void)creatUI
{
    UIImageView *topImgV = [UIImageView bb_imgVMakeWithSuperV:self.view imgName:nil];
    topImgV.backgroundColor = [UIColor purpleColor];
    topImgV.frame = CGRectMake(0, 0, _k_w, 180);
    topImgV.userInteractionEnabled = YES;
    
    UIButton *closeBT = [UIButton bb_btMakeWithSuperV:topImgV imageName:@"close"];
    closeBT.frame = CGRectMake(0, 20, 54, 54);
    [closeBT setImageEdgeInsets:UIEdgeInsetsMake(4, 16, 28, 16)];
    [closeBT addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self creatTFUI];
}
-(void)closeAction
{
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)creatTFUI
{
    CGFloat leftMargin = 20;
    CGFloat totalH = 50;
    
    CGFloat imgW = 15;
    CGFloat imgH = 18;
    CGFloat tfL = 40;
    CGFloat tfW = _k_w-leftMargin-tfL;
    
    CGFloat tfY = 210;
    CGFloat codeW = 82;
    
    //手机号
    UIImageView *phoneImgV = [UIImageView bb_imgVMakeWithSuperV:self.view imgName:@"phone"];
    phoneImgV.frame = CGRectMake(leftMargin, tfY+16, imgW, imgH);
    self.phoneTF = [PPTextfield pp_tfMakeWithSuperV:self.view tag:401 fontSize:16 textColor:k_color_515151 attributedPlaceholderText:@"请输入手机号码" attributedPlaceholderFontSize:16 attributedPlaceholderTextColor:k_color_153153153];
    self.phoneTF.isPhoneNumber = YES;
    self.phoneTF.frame = CGRectMake(tfL, tfY, tfW-codeW-6, totalH);
    BBWeakSelf(self)
    self.phoneTF.ppTextfieldTextChangedBlock = ^(PPTextfield *tf) {
        BBStrongSelf(self)
        [self textFieldTextDidChange:tf];
    };
    
    self.getCodeBT = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    self.getCodeBT.frame = CGRectMake(self.phoneTF.right+6, tfY+10, codeW, 30);
    [self.view addSubview:self.getCodeBT];
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
    
    UIView *phoneLine = [[UIView alloc]initWithFrame:CGRectMake(leftMargin, tfY+50, _k_w-leftMargin*2, 0.5)];
    phoneLine.backgroundColor = K_color_line;
    [self.view addSubview:phoneLine];
    
    //验证码
    UIImageView *codeImgV = [UIImageView bb_imgVMakeWithSuperV:self.view imgName:@"verification"];
    codeImgV.frame = CGRectMake(leftMargin, tfY+50+16, imgW, imgH);
    self.codeTF = [PPTextfield pp_tfMakeWithSuperV:self.view tag:402 fontSize:16 textColor:k_color_515151 attributedPlaceholderText:@"请输入验证码" attributedPlaceholderFontSize:16 attributedPlaceholderTextColor:k_color_153153153];
    self.codeTF.isOnlyNumber = YES;
    self.codeTF.maxNumberCount = 6;
    self.codeTF.frame = CGRectMake(tfL, tfY+50, tfW, totalH);
    self.codeTF.ppTextfieldTextChangedBlock = ^(PPTextfield *tf) {
        BBStrongSelf(self)
        [self textFieldTextDidChange:tf];
    };
    UIView *codeLine = [[UIView alloc]initWithFrame:CGRectMake(leftMargin, tfY+100, _k_w-leftMargin*2, 0.5)];
    codeLine.backgroundColor = K_color_line;
    [self.view addSubview:codeLine];
    
    //密码
    UIImageView *passwordImgV = [UIImageView bb_imgVMakeWithSuperV:self.view imgName:@"password"];
    passwordImgV.frame = CGRectMake(leftMargin, tfY+100+16, imgW, imgH);
    self.passwordTF = [PPTextfield pp_tfMakeWithSuperV:self.view tag:403 fontSize:16 textColor:k_color_515151 attributedPlaceholderText:@"请输入密码" attributedPlaceholderFontSize:16 attributedPlaceholderTextColor:k_color_153153153];
    self.passwordTF.isPassword = YES;
    self.passwordTF.maxTextLength = 20;
    self.passwordTF.frame = CGRectMake(tfL, tfY+100, tfW, totalH);
    self.passwordTF.ppTextfieldTextChangedBlock = ^(PPTextfield *tf) {
        BBStrongSelf(self)
        [self textFieldTextDidChange:tf];
    };
    UIView *passwordLine = [[UIView alloc]initWithFrame:CGRectMake(leftMargin, tfY+150, _k_w-leftMargin*2, 0.5)];
    passwordLine.backgroundColor = K_color_line;
    [self.view addSubview:passwordLine];
    
    //注册
    self.submitBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.submitBT];
    self.submitBT.titleLabel.font = [UIFont systemFontOfSize:18];
    self.submitBT.fillColor = rgb(255, 236, 183, 0.5);
    self.submitBT.titleTextColor = k_color_515151;
    [self.submitBT setTitle:@"登录" forState:UIControlStateNormal];
    self.submitBT.frame = CGRectMake(leftMargin, self.passwordTF.bottom+45, _k_w-leftMargin*2, 47);
    self.submitBT.userInteractionEnabled = NO;
    [self.submitBT addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark --- "获取验证码"点击事件
-(void)getVerifyCodeRequest:(JKCountDownButton *)btn
{
    [self.view endEditing:YES];
    
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
        [QMUITips showWithText:@"手机号格式不正确" inView:self.view hideAfterDelay:2];
        [btn stopCountDown];
        btn.enabled = YES;
        return;
    }
    
#warning todo
    
}
#pragma mark --- 提交点击事件
-(void)submitAction
{
#warning to
    DLog(@"提交点击");
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
        self.submitBT.userInteractionEnabled = YES;
        self.submitBT.fillColor = rgb(255, 236, 183, 1);
    }else{
        self.submitBT.userInteractionEnabled = NO;
        self.submitBT.fillColor = rgb(255, 236, 183, 0.5);
    }
    
}
@end
