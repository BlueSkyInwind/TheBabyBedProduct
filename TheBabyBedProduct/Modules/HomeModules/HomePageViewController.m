//
//  HomePageViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "HomePageViewController.h"
#import "HomeLeftItemView.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self configureView];
}

-(void)configureView{
    
    HomeLeftItemView * leftItemView = [[HomeLeftItemView alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    leftItemView.nameLabel.text = @"欧阳马克";
    leftItemView.homeHeaderClick = ^(UIButton *button) {
         
    };

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftItemView];
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"home_message_Icon"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonItemClick)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
}

-(void)rightButtonItemClick{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
