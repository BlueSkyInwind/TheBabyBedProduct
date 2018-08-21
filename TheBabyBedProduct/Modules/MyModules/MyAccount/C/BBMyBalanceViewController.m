//
//  BBMyBalanceViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/13.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMyBalanceViewController.h"
#import "BBRechargeMoney.h"
#import "PPTextfield.h"
#import "PPTextfield+EasilyMake.h"

@interface BBMyBalanceViewController ()
@property(nonatomic,strong) NSMutableArray<BBRechargeMoney *> *moneyLists;
/** 分钟余额 */
@property(nonatomic,strong) UILabel *minuteBlance;
/** bts */
@property(nonatomic,strong) NSMutableArray<UIButton *> *bts;
/** 选中的button */
@property(nonatomic,strong) UIButton *selectedBT;
/** 可输入金额的TF */
@property(nonatomic,strong) PPTextfield *inputMoneyTF;
@end

@implementation BBMyBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_color_vcBg;
    self.titleStr = @"我的余额";
    
    [self creatUI];
    [self getMoneyListData];
    
}
-(void)creatUI
{
    UIView *topView = [PPMAKE(PPMakeTypeView) pp_make:^(PPMake *make) {
        make.intoView(self.view);
        make.frame(CGRectMake(0, PPDevice_navBarHeight, _k_w, PPHeight(65)));
        make.bgColor([UIColor whiteColor]);
    }];
    BBUser *user = [BBUser bb_getUser];
    
    [PPMAKE(PPMakeTypeLB) pp_make:^(PPMake *make) {
        make.intoView(topView);
        make.frame(CGRectMake(PPWidth(20), PPHeight(8), _k_w-PPWidth(20*2), PPHeight(22)));
        NSString *userNickNameMessStr = [NSString stringWithFormat:@"账户：%@",user.username];
        make.text(userNickNameMessStr);
        make.font(kFontRegular(16));
        make.textColor(k_color_515151);
    }];
    
    [PPMAKE(PPMakeTypeLB) pp_make:^(PPMake *make) {
        make.intoView(topView);
        make.frame(CGRectMake(PPWidth(20), PPHeight(35), _k_w-PPWidth(20*2), PPHeight(22)));
        NSString *curTimeStr = [NSString stringWithFormat:@"%ld",(long)user.curTime];
        NSString *userNickNameMessStr = [NSString stringWithFormat:@"余额：%@ 分钟",curTimeStr];
        NSMutableAttributedString *mutStr = [NSMutableAttributedString pp_attributedStringMake:^(PPMutAttributedStringMaker *maker) {
            maker.font(kFontRegular(16));
            maker.textColor(k_color_515151);
            maker.textColorRange(k_color_appOrange, [userNickNameMessStr rangeOfString:curTimeStr]);
        } str:userNickNameMessStr];
        make.attributedText(mutStr);
    }];
    
}
#pragma mark --- 获取预选值数据
-(void)getMoneyListData
{
    [BBRequestTool bb_requestMoneyListWithSuccessBlock:^(EnumServerStatus status, id object) {
        NSLog(@"MoneyList success %@",object);
        BBRechargeMoneyListResult *result = [BBRechargeMoneyListResult mj_objectWithKeyValues:object];
        if (result.code == 0) {
            [self.moneyLists addObjectsFromArray:result.data];
            [self creatMoneyUI];
        }else{
            [QMUITips showWithText:[result.msg bb_safe] inView:self.view hideAfterDelay:2];
            return ;
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"MoneyList error %@",object);
    }];
}

#pragma mark --- 获取到预选值后再创UI
-(void)creatMoneyUI
{
    if (self.moneyLists.count == 0) {
        return;
    }
    CGFloat scrollY = PPDevice_navBarHeight+PPHeight(10)+PPHeight(65);
  
    CGFloat scrollStartH = PPHeight(300);
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, scrollY, _k_w, scrollStartH)];
    [self.view addSubview:scrollView];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.contentSize = CGSizeMake(_k_w, _k_h-scrollY);
    
    CGFloat leftMargin = PPWidth(35.5);
    CGFloat btMargin = PPWidth(24);
    NSInteger column = 2;
    CGFloat btW = (_k_w-leftMargin*2-btMargin*(column-1))/column;
    CGFloat btH = PPHeight(47);
    
    CGFloat scrollMaxH = 0;
    for (int i = 0; i < self.moneyLists.count; i++) {
        UIButton *bt = [PPMAKE(PPMakeTypeBT) pp_make:^(PPMake *make) {
            make.intoView(scrollView);
            NSInteger currentRow = i/column;
            NSInteger currentColumn = i%column;
            CGFloat btY = PPHeight(20)*(currentRow+1)+btH*currentRow;
            CGFloat btX = leftMargin+(btW+btMargin)*currentColumn;
            make.frame(CGRectMake(btX, btY, btW, btH));
            make.tag(130+i);
            make.cornerRadius(8);
            make.bgColor(rgbR(236));
            make.addTargetTouchUpInside(self, @selector(btAction:));
            BBRechargeMoney *rechargeMoney = self.moneyLists[i];
            NSString *showStr = [NSString stringWithFormat:@"%ld分钟/¥%.2f",(long)rechargeMoney.rechargeTime,[rechargeMoney.rechargeMoney floatValue]];
            make.normalAttributedFontColorTitle(kFontRegular(14), k_color_515151, showStr);
        }];
        if (i == 0) {
            //默认选中第一个
            [self btAction:bt];
        }
        [self.bts addObject:bt];
        if (i == self.moneyLists.count -1) {
            scrollMaxH = bt.bottom+PPHeight(20);
        }
    }
    
 
    self.inputMoneyTF = [PPTextfield pp_tfMakeWithSuperV:scrollView tag:1220 fontSize:14 textColor:k_color_515151 attributedPlaceholderText:@"其他金额请点击这里输入" attributedPlaceholderFontSize:14 attributedPlaceholderTextColor:k_color_153153153];
    self.inputMoneyTF.isOnlyNumber = YES;
    BBWeakSelf(self)
    self.inputMoneyTF.ppTextFieldEndEditBlock = ^(PPTextfield *tf) {
        if ([tf.text integerValue] < 5) {
            BBStrongSelf(self)
            [QMUITips showWithText:@"最低充值5元哦" inView:self.view hideAfterDelay:1.2];
        }
    };
    self.inputMoneyTF.frame = CGRectMake(leftMargin, scrollMaxH, _k_w-leftMargin*2, PPHeight(47));
    [self.inputMoneyTF pp_make:^(PPMake *make) {
        make.cornerRadius(4);
    }];
    scrollMaxH += PPHeight(47+5);
    
    [PPMAKE(PPMakeTypeLB) pp_make:^(PPMake *make) {
        make.intoView(scrollView);
        make.frame(CGRectMake(leftMargin, scrollMaxH, _k_w-leftMargin-5, PPHeight(20)));
        make.font(kFontRegular(13));
        make.textColor(k_color_153153153);
        make.text(@"比率：10分钟一元，最低充值5元");
    }];
    scrollMaxH += PPHeight(20);
    
    [PPMAKE(PPMakeTypeBT) pp_make:^(PPMake *make) {
        make.intoView(scrollView);
        make.frame(CGRectMake(PPWidth(50), scrollMaxH, _k_w-PPWidth(100), PPHeight(47)));
        make.bgColor(UI_MAIN_COLOR);
        make.normalAttributedFontColorTitle(kFontRegular(18), k_color_515151, @"支付");
        make.cornerRadius(PPHeight(23.5));
        make.addTargetTouchUpInside(self, @selector(payAction));
    }];
    
    scrollMaxH += PPHeight(47+40);
    
    
    CGFloat scrollH = scrollStartH;
    if (scrollMaxH >= _k_h-scrollY) {
        scrollH = _k_h-scrollY;
    }else{
        scrollH = scrollMaxH;
    }
    scrollView.height = scrollH;
    scrollView.contentSize = CGSizeMake(_k_w, scrollMaxH);

    
}
#pragma mark --- 内购支付
-(void)payAction
{
    NSString *moneyStr = @"";
    if (self.inputMoneyTF.text.length > 0 && [self.inputMoneyTF.text integerValue] >= 5) {
        moneyStr = self.inputMoneyTF.text;
    }else{
        NSInteger selectedBTTag = self.selectedBT.tag;
        BBRechargeMoney *rechargeMoney = self.moneyLists[selectedBTTag-130];
        moneyStr = [NSString stringWithFormat:@"%@",rechargeMoney.rechargeMoney];
    }
    
    [QMUITips showWithText:[NSString stringWithFormat:@"%@充值金额为：%@",@"内购开发中",moneyStr]];

}
-(void)btAction:(UIButton *)bt
{
    if (self.selectedBT && self.selectedBT.tag == bt.tag) {
        return;
    }
    bt.backgroundColor = UI_MAIN_COLOR;
    if (self.selectedBT) {
        self.selectedBT.backgroundColor = rgbR(236);
    }
    self.selectedBT = bt;
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
-(NSMutableArray<UIButton *> *)bts
{
    if (!_bts) {
        _bts = [NSMutableArray array];
    }
    return _bts;
}
@end
