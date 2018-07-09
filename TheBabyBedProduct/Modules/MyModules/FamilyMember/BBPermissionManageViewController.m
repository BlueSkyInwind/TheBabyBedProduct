//
//  BBPermissionManageViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/30.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBPermissionManageViewController.h"

@interface BBPermissionManageViewController ()
@property(nonatomic,strong) NSArray<NSString *> *imgNames;
@property(nonatomic,strong) NSArray<NSString *> *titles;
@end

@implementation BBPermissionManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_color_vcBg;
    self.title = @"权限分配";
    [self creatUI];
}

-(void)creatUI
{
    UIView *userMesBgV = [[UIView alloc]initWithFrame:CGRectFlatMake(0, 64+10, _k_w, 100)];
    [self.view addSubview:userMesBgV];
    userMesBgV.backgroundColor = [UIColor whiteColor];
    UIImageView *avatarImgV = [UIImageView bb_imgVMakeWithSuperV:userMesBgV imgName:@"grandma"];
    avatarImgV.frame = CGRectMake(10, 25, 50, 50);
    avatarImgV.layer.masksToBounds = YES;
    avatarImgV.layer.cornerRadius = 25;
    UILabel *userNameLB = [UILabel bb_lbMakeWithSuperV:userMesBgV fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    userNameLB.frame = CGRectMake(avatarImgV.right+8, 30, _k_w-avatarImgV.right-10, 40);
    userNameLB.text = @"爷爷";
    
    UIView *switchBgV = [[UIView alloc]initWithFrame:CGRectFlatMake(0, userMesBgV.bottom+10, _k_w, 94)];
    [self.view addSubview:switchBgV];
    switchBgV.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i<self.imgNames.count; i++) {
        UIView *v = [self oneItemView:self.imgNames[i] title:self.titles[i] tag:106+i];
        [switchBgV addSubview:v];
        v.frame = CGRectMake(0, 47*i, _k_w, 47);
    }
    
    
    QMUIFillButton *deleteBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:deleteBT];
    deleteBT.titleLabel.font = [UIFont systemFontOfSize:16];
    deleteBT.fillColor = rgb(255, 155, 57, 1);
    deleteBT.titleTextColor = [UIColor whiteColor];
    [deleteBT setTitle:@"删  除" forState:UIControlStateNormal];
    [deleteBT addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    deleteBT.frame = CGRectMake(40, _k_h-100, _k_w-80, 47);
    
}

-(UIView *)oneItemView:(NSString *)imgName title:(NSString *)title tag:(NSInteger)tag
{
    UIView *v = [[UIView alloc]init];
    v.backgroundColor = [UIColor clearColor];
    
    UIImageView *leftImgV = [UIImageView bb_imgVMakeWithSuperV:v imgName:imgName];
    UILabel *textLb = [UILabel bb_lbMakeWithSuperV:v fontSize:15 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    textLb.text = title;
    
    UISwitch *s = [[UISwitch alloc]init];
    [v addSubview:s];
    v.tag = tag;
    s.transform = CGAffineTransformMakeScale(0.75,0.75);
    [s addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    leftImgV.frame = CGRectMake(10, 13.5, 20, 20);
    textLb.frame = CGRectMake(leftImgV.right+8, 0, _k_w-leftImgV.right-8-40, 47);
    s.frame = CGRectFlatMake(_k_w-20-26,13, 26, 21);
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 47, _k_w-10, 0.5)];
    [v addSubview:line];
    line.backgroundColor = K_color_line;
    
    return v;

}
-(void)switchAction:(UISwitch *)st
{
    switch (st.tag) {
        case 106:
        {
            
        }
            break;
            
        case 107:
        {
            
        }
            break;
            
        default:
            break;
    }
}
-(void)deleteAction
{
#warning todo 删除该管理员
    
}
-(NSArray<NSString *> *)imgNames
{
    if (!_imgNames) {
        _imgNames = @[@"manager",@"frequency"];
    }
    return _imgNames;
}
-(NSArray<NSString *> *)titles
{
    if (!_titles) {
        _titles = @[@"提升为管理员",@"允许观看视频"];
    }
    return _titles;
}
@end
