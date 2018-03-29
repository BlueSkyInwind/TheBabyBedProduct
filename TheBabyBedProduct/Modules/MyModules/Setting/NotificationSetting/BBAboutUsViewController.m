//
//  BBAboutUsViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBAboutUsViewController.h"

@interface BBAboutUsViewController ()

@end

@implementation BBAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于我们";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *introLB = [UILabel bb_lbMakeWithSuperV:self.view fontSize:14 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    [self.view addSubview:introLB];
    introLB.numberOfLines = 0;
    introLB.text = @"我们是给是否进来是是否乐山大佛就开始了放假酸辣粉睡觉了福建省立方进水阀放松了弗拉放假拉风加";
    introLB.frame = CGRectFlatMake(20, 20, _k_w-40, _k_h-40);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
