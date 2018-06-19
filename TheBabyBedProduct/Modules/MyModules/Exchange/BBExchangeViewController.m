//
//  BBExchangeViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/18.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBExchangeViewController.h"

@interface BBExchangeViewController ()

@end

@implementation BBExchangeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = k_color_vcBg;
    self.title = @"积分兑换记录";
    
    [self getExchangeListData];
}
-(void)getExchangeListData
{
    [BBRequestTool bb_requestExchangeListWithPageNo:1 successBlock:^(EnumServerStatus status, id object) {
        NSLog(@"success %@",object);
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"fail %@",object);
    }];
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
