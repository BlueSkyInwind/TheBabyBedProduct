//
//  BBLoginAndRegistViewController.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BaseViewController.h"

@interface BBLoginAndRegistViewController : BaseViewController
/** 是否左上角的关闭按钮隐藏 */
@property(nonatomic,assign) BOOL isHiddenCloseBT;
/** 登录or注册结果block */
@property(nonatomic,copy) void(^BBLoginOrRegistResultBlock)(BOOL isSuccess);
@end
