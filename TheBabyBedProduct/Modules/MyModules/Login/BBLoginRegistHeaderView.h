//
//  BBLoginRegistHeaderView.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBLoginRegistHeaderView : UIView
@property(nonatomic,copy) void(^LoginRegistSelectedBlock)(BOOL isLogin);
@property(nonatomic,copy) void(^closeBlock)(void);
-(void)loginAction;
-(void)configureCloseBTWithNeedHidden:(BOOL)needHidden;
@end




