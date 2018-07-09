//
//  BaseViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BaseViewController.h"
#import "BBLoginAndRegistViewController.h"
#import "BaseNavigationViewController.h"

@interface BaseViewController ()
/** 用UIView对象创建的导航栏,如果觉得不合适，可以隐藏掉，设置自己需要的 */
@property(nonatomic,strong) UIView *p_navigationView;
/** 导航栏下面的线（宽：屏宽，高：1） */
@property(nonatomic,strong) UIView *p_navigationLine;
/** 返回按钮 */
@property(nonatomic,strong) UIButton *p_backBT;
/** 标题LB */
@property(nonatomic,strong) UILabel *p_titleLB;
@end

@implementation BaseViewController

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    NSString * vcStr = NSStringFromClass(self.class);
//    AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    if ([delegate.tabBar.vcNameArr containsObject:vcStr]) {
//        self.tabBarController.tabBar.hidden = false;
//    }else{
//        self.tabBarController.tabBar.hidden = true;
//    }
//}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.hidesBottomBarWhenPushed = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = k_color_vcBg;
    
    CGFloat backBT_W = PPWidth(50);
    CGFloat backBT_H = 44;
    
    self.p_navigationView = [PPMAKE(PPMakeTypeView) pp_make:^(PPMake *make) {
        make.intoView(self.view);
        make.bgColor(UI_MAIN_COLOR);
        make.frame(CGRectMake(0, 0, _k_w, PPDevice_navBarHeight));
    }];
    
    //13*22
    self.p_backBT = [PPMAKE(PPMakeTypeBT) pp_make:^(PPMake *make) {
        make.intoView(self.p_navigationView);
        make.frame(CGRectMake(0, PPDevice_statusBarHeight, PPWidth(50), backBT_H));
        make.normalImageName(@"return");
        make.addTargetTouchUpInside(self, @selector(backAction));
        make.setImageEdgeInsets(11, 10, 11, PPWidth(50)-10-13);
    }];
    
    self.p_titleLB = [PPMAKE(PPMakeTypeLB) pp_make:^(PPMake *make) {
        make.intoView(self.p_navigationView);
        make.frame(CGRectMake(self.p_backBT.right, self.p_backBT.top,_k_w-backBT_W*2, backBT_H));
        make.font(kFontRegular(18));
        make.textColor(kUIColorFromRGB(0x000000));
        make.textAlignment(NSTextAlignmentCenter);
        if (self.titleStr && self.titleStr.length > 0) {
            make.text(self.titleStr);
        }
    }];
    
//    self.p_navigationLine = [PPMAKE(PPMakeTypeView) pp_make:^(PPMake *make) {
//        make.intoView(self.p_navigationView);
//        make.frame(CGRectMake(0, self.p_navigationView.height-1, self.p_navigationView.width, 1));
//        make.bgColor(kUIColorFromRGB(0xf2f2f2));
//    }];
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --- titleStr
-(NSString *)titleStr
{
    return self.p_titleLB.text;
}
-(void)setTitleStr:(NSString *)titleStr
{
    if (titleStr && titleStr.length > 0) {
        self.p_titleLB.text = titleStr;
    }
}

#pragma mark --- 获取只读属性的对象
-(UIView *)navigationView
{
    return self.p_navigationView;
}
-(UIView *)navigationLine
{
    return self.p_navigationLine;
}
-(UIButton *)backBT
{
    return self.p_backBT;
}
-(UILabel *)titleLB
{
    return self.p_titleLB;
}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
//    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blackColor]};
////    [self.navigationController.navigationBar setBackgroundColor:UI_MAIN_COLOR];
//    [self.navigationController.navigationBar setBackgroundImage:[[GlobalTool share] imageWithColor:UI_MAIN_COLOR] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.translucent = true;
//    self.view.backgroundColor = [UIColor whiteColor];
//    
//}
//- (void)addBackItem
//{
//    if (@available(iOS 11.0, *)) {
//        UIBarButtonItem *aBarbi = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
//        self.navigationItem.leftBarButtonItem = aBarbi;
//        return;
//    }
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    UIImage *img = [[UIImage imageNamed:@"return"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [btn setImage:img forState:UIControlStateNormal];
//    btn.frame = CGRectMake(0, 0, 45, 44);
//    [btn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    //    修改距离,距离边缘的
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceItem.width = -15;
//    self.navigationItem.leftBarButtonItems = @[spaceItem,item];
//}
//
//- (void)popBack
//{
//    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    NSString * vcStr = NSStringFromClass(self.class);
//    AppDelegate * delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
//    if ([delegate.tabBar.vcNameArr containsObject:vcStr]) {
//        self.tabBarController.tabBar.hidden = false;
//    }else{
//        self.tabBarController.tabBar.hidden = true;
//    }
//}


-(void)goLoginRegistVc
{
    BBLoginAndRegistViewController *loginRegistVC = [[BBLoginAndRegistViewController alloc]init];
    BaseNavigationViewController *navVC = [[BaseNavigationViewController alloc]initWithRootViewController:loginRegistVC];
    [self presentViewController:navVC animated:YES completion:nil];
}
-(void)bb_goLoginRegistVC:(BBLoginRegistResultBlock)resultBlock
{
    BBLoginAndRegistViewController *loginRegistVC = [[BBLoginAndRegistViewController alloc]init];
    BaseNavigationViewController *navVC = [[BaseNavigationViewController alloc]initWithRootViewController:loginRegistVC];
    loginRegistVC.BBLoginOrRegistResultBlock = ^(BOOL isSuccess) {
        resultBlock(isSuccess);
    };
    [self presentViewController:navVC animated:YES completion:nil];
}




@end
