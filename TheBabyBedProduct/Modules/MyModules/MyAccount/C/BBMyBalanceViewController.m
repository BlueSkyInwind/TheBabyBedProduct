//
//  BBMyBalanceViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/13.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMyBalanceViewController.h"
#import "BBRechargeMoney.h"

@interface BBMyBalanceViewController ()
@property(nonatomic,strong) NSMutableArray<BBRechargeMoney *> *moneyLists;
/** 分钟余额 */
@property(nonatomic,strong) UILabel *minuteBlance;
@end

@implementation BBMyBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_color_vcBg;
    [self addBackItem];
    self.title = @"我的余额";
    
    [self getMoneyListData];
    [self creatUI];
    
}
-(void)creatUI
{
//   UIView *topV = [UIView alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
}
-(void)getMoneyListData
{
    [BBRequestTool bb_requestMoneyListWithSuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"MoneyList success %@",object);
        BBRechargeMoneyListResult *result = [BBRechargeMoneyListResult mj_objectWithKeyValues:object];
        if (result.code == 0) {
            [self.moneyLists addObjectsFromArray:result.data];
        }else{
            [QMUITips showWithText:[result.msg bb_safe] inView:self.view hideAfterDelay:2];
            return ;
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"MoneyList error %@",object);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray<BBRechargeMoney *> *)moneyLists
{
    if (!_moneyLists) {
        _moneyLists = [NSMutableArray array];
    }
    return _moneyLists;
}

@end
