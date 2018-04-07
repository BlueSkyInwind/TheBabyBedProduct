//
//  BBEditInformationViewController.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/30.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger,BBEditInformationVCComesFrom) {
    BBEditInformationVCComesFromRegistSuccess = 0,   //注册成功
    BBEditInformationViewControllerMyVC
};

@interface BBEditInformationViewController : BaseViewController
@property(nonatomic,assign) BBEditInformationVCComesFrom comesFrom;
@property(nonatomic,copy) void(^skipBlock)(void);

@end
