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

@implementation UIButton (EasilyConfigure)
#pragma mark --- 设置btn Normal和Highlighted下的image 【相同】
-(void)bb_btSetImageWithImgName:(NSString *)imgName
{
    if (imgName.length == 0 ) {
        return;
    }
    [self setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:imgName] forState:UIControlStateHighlighted];
}

#pragma mark --- 设置btn Normal和Highlighted下的titleColor 【相同】
-(void)bb_btSetTitleColor:(UIColor *)titleColor
{
    if (!titleColor) {
        return;
    }
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self setTitleColor:titleColor forState:UIControlStateHighlighted];
}

#pragma mark --- 设置btn Normal和Highlighted下的title 【相同】
-(void)bb_btSetTitle:(NSString *)title
{
    if (!title || title.length == 0) {
        return;
    }
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitle:title forState:UIControlStateHighlighted];
}
@end
