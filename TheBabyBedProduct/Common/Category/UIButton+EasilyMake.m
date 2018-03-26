//
//  UIButton+EasilyMake.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "UIButton+EasilyMake.h"

@implementation UIButton (EasilyMake)

+(instancetype)bb_btMakeWithSuperV:(UIView *)superV
                           bgColor:(UIColor *)bgColor
                        titleColor:(UIColor *)titleColor
                     titleFontSize:(CGFloat)titleFontSize
                             title:(NSString *)title
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    if (superV) {
        [superV addSubview:bt];
    }
    if (bgColor) {
        bt.backgroundColor = bgColor;
    }
    if (titleColor) {
        [bt setTitleColor:titleColor forState:UIControlStateNormal];
        [bt setTitleColor:titleColor forState:UIControlStateHighlighted];
    }
    if (titleFontSize > 0) {
        bt.titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
    }
    if (title && title.length > 0) {
        [bt setTitle:title forState:UIControlStateNormal];
        [bt setTitle:title forState:UIControlStateHighlighted];
    }    
    return bt;
}
+(instancetype)bb_btMakeWithSuperV:(UIView *)superV
                         imageName:(NSString *)imageName
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    if (superV) {
        [superV addSubview:bt];
    }
    if (imageName && imageName.length > 0) {
        [bt setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [bt setImage:[UIImage imageNamed:imageName] forState:UIControlStateHighlighted];
    }
    return bt;
}
@end
