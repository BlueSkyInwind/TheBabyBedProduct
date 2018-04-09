//
//  BBModifyPasswordViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/8.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBModifyPasswordViewController.h"
#import "PPTextfield.h"
#import "PPTextfield+EasilyMake.h"

@interface BBModifyPasswordViewController ()
@property(nonatomic,strong) PPTextfield *oldPasswordTF;

@property(nonatomic,strong) PPTextfield *latestPasswordTF;

@property(nonatomic,strong) PPTextfield *okNewPasswordTF;

@end

@implementation BBModifyPasswordViewController
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = k_color_vcBg;
    
    [self creatNavViewUI];
    
    [self creatTFUI];
    
}
-(void)creatNavViewUI
{
    UIView *topBgV = [[UIView alloc]initWithFrame:CGRectFlatMake(0, 0, _k_w, 64)];
    [self.view addSubview:topBgV];
    topBgV.backgroundColor = rgb(255, 236, 183, 1);
    
    UIButton *cancelBT = [UIButton bb_btMakeWithSuperV:topBgV bgColor:nil titleColor:k_color_appOrange titleFontSize:16 title:@"取消"];
    cancelBT.frame = CGRectFlatMake(0, 20, 50, 44);
    [cancelBT addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *titleLB = [UILabel bb_lbMakeWithSuperV:topBgV fontSize:18 alignment:NSTextAlignmentCenter textColor:k_color_515151];
    titleLB.text = @"修改密码";
    titleLB.frame = CGRectFlatMake(50, 20, _k_w-100, 44);
    
    UIButton *saveBT = [UIButton bb_btMakeWithSuperV:topBgV bgColor:nil titleColor:k_color_appOrange titleFontSize:16 title:@"保存"];
    saveBT.frame = CGRectFlatMake(_k_w-50, 20, 50, 44);
    [saveBT addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)creatTFUI
{
    UIView *tfBgV = [[UIView alloc]initWithFrame:CGRectFlatMake(0, 64+20, _k_w, 150)];
    tfBgV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tfBgV];
    
    NSArray *leftTitles = @[@"当前密码",@"新密码",@"确认密码"];
    NSArray *placeholders = @[@"请输入当前密码",@"请输入新密码（至少6位）",@"请再次输入新密码"];
    for (int i = 0; i < leftTitles.count-1; i++) {
        [self creatUIOnTFBgV:tfBgV leftTitle:leftTitles[i] placeholder:placeholders[i] index:i];
    }
}
-(void)creatUIOnTFBgV:(UIView *)tfBgV leftTitle:(NSString *)leftTitle placeholder:(NSString *)placeholder index:(int)index
{
    UILabel *leftLB = [UILabel bb_lbMakeWithSuperV:tfBgV fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    leftLB.text = leftTitle;
    leftLB.frame = CGRectMake(15, 50*index, 80, 50);
    
    PPTextfield *tf = [PPTextfield pp_tfMakeWithSuperV:tfBgV tag:index fontSize:16 textColor:k_color_515151 attributedPlaceholderText:placeholder attributedPlaceholderFontSize:16 attributedPlaceholderTextColor:k_color_153153153];
    tf.isPassword = YES;
    tf.maxTextLength = 20;
    if (index == 0) {
        self.oldPasswordTF = tf;
    }else if (index == 1){
        self.latestPasswordTF = tf;
    }else{
        self.okNewPasswordTF = tf;
    }

}

-(void)cancelAction
{
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)saveAction
{
    [self.view endEditing:YES];
    
    NSString *oldPasswordStr = BBUserHelpers.password;
    if (![self.oldPasswordTF.text isEqualToString:oldPasswordStr]) {
        [QMUITips showError:@"当前密码不正确"];
        return;
    }
    if (self.latestPasswordTF.text.length < 6 || self.okNewPasswordTF.text.length < 6) {
        [QMUITips showError:@"新密码不能少于6位字符"];
        return;
    }
    if (![self.latestPasswordTF.text isEqualToString:self.okNewPasswordTF.text]) {
        [QMUITips showError:@"新密码前后不一样哦"];
        return;
    }
    
}




@end
