//
//  BBMyHeaderView.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBUser;

@interface BBMyHeaderView : UIView
/** 登录or注册 */
@property(nonatomic,copy) void(^loginOrRegistBlock)(void);

-(instancetype)initWithFrame:(CGRect)frame
                        user:(BBUser *)user;
@end
