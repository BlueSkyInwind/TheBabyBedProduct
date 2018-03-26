//
//  BBLoginAndRegistViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBLoginAndRegistViewController.h"
#import "BBLoginRegistHeaderView.h"
#import "BBLoginView.h"
#import "BBRegistView.h"

@interface BBLoginAndRegistViewController ()
{
    BOOL _currentIsLogin;
}
@property(nonatomic,strong) BBLoginRegistHeaderView *headerV;
@property(nonatomic,strong) BBLoginView *loginV;
@property(nonatomic,strong) BBRegistView *registV;
@end

@implementation BBLoginAndRegistViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _currentIsLogin = YES;
    [self creatUI];
    
    
}
-(void)creatUI
{
    [self creatHeaderVUI];
    
    self.loginV = [[BBLoginView alloc]initWithFrame:CGRectMake(0, 200, _k_w, _k_h-200)];
    [self.view addSubview:self.loginV];
    
    self.registV = [[BBRegistView alloc]initWithFrame:CGRectMake(_k_w, 200, _k_w, _k_h-200)];
    [self.view addSubview:self.registV];
    
    self.loginV.backgroundColor = [UIColor redColor];
    self.registV.backgroundColor = [UIColor purpleColor];
    
}
-(void)creatHeaderVUI
{
    self.headerV = [[BBLoginRegistHeaderView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 200)];
    [self.view addSubview:self.headerV];
    BBWeakSelf(self)
    self.headerV.closeBlock = ^{
        BBStrongSelf(self)
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    self.headerV.LoginRegistSelectedBlock = ^(BOOL isLogin) {
        BBStrongSelf(self)
        [self changLoginOrRegist:isLogin];
    };
}
-(void)changLoginOrRegist:(BOOL)isLogin
{
    if (isLogin) {
        if (_currentIsLogin) {
            return;
        }else{
            _currentIsLogin = YES;
            [UIView animateWithDuration:0.20 delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
                self.loginV.frame = CGRectMake(0, 200, _k_w, _k_h-200);
                self.registV.frame = CGRectMake(_k_w, 200, _k_w, _k_h-200);
            } completion:^(BOOL finished) {
                
            }];
        }
        
    }else{
        if (!_currentIsLogin) {
            return;
        }else{
            _currentIsLogin = NO;
            [UIView animateWithDuration:0.20 delay:0 options:(UIViewAnimationOptionCurveEaseIn) animations:^{
                self.loginV.frame = CGRectMake(-_k_w, 200, _k_w, _k_h-200);
                self.registV.frame = CGRectMake(0, 200, _k_w, _k_h-200);
            } completion:^(BOOL finished) {
                
            }];
        }
        
    }
}


@end
