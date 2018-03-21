//
//  BaseTabBarViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "BaseNavigationViewController.h"
#import "HomePageViewController.h"
#import "TheConsoleViewController.h"
#import "EarlyEducationViewController.h"
#import "MyViewController.h"

@interface BaseTabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTabbarCon];
    self.delegate = self;
}

- (void)setTabbarCon
{
    
    NSArray *vcNameArr = @[@"HomePageViewController",@"TheConsoleViewController",@"EarlyEducationViewController",@"MyViewController"];
    NSArray *titleArr = @[@"首页",@"控制台",@"早教",@"我的"];
    NSArray *imageArr = @[@"home_unselect",@"console_unselect",@"earlyEdu_unselect",@"my_unselect"];
    NSArray *seleteimageArr = @[@"home_select",@"console_select",@"earlyEdu_select",@"my_select"];
    
    NSMutableArray *ncArr = [NSMutableArray array];
    
    for (int i = 0; i < vcNameArr.count; i++) {
        //将字符串转化成类
        Class vc = NSClassFromString([vcNameArr objectAtIndex:i]);
        //父类指针指向子类对象
        UIViewController *viewController = [[vc alloc]init];
        BaseNavigationViewController *nc = [[BaseNavigationViewController alloc]initWithRootViewController:viewController];
        viewController.navigationItem.title = [titleArr objectAtIndex:i];
        nc.tabBarItem = [self tabBarItemWithName:[titleArr objectAtIndex:i] image:[imageArr objectAtIndex:i] selectedImage:[seleteimageArr objectAtIndex:i]];
        [ncArr addObject:nc];
    }
    self.viewControllers = ncArr;
}

//设置tabbar的图标
- (UITabBarItem *)tabBarItemWithName:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImageName
{
    UIImage *image = [[UIImage imageNamed:imageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [[UIImage imageNamed:selectedImageName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:title image:image selectedImage:selectedImage];
//    [item setImageInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:rgb(153, 153, 153,1)} forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName:UI_MAIN_COLOR} forState:UIControlStateSelected];
    [item setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    return item;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

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
