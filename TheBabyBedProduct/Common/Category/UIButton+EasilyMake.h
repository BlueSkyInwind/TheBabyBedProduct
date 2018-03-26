//
//  UIButton+EasilyMake.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EasilyMake)
+(instancetype)bb_btMakeWithSuperV:(UIView *)superV
                           bgColor:(UIColor *)bgColor
                        titleColor:(UIColor *)titleColor
                     titleFontSize:(CGFloat)titleFontSize
                             title:(NSString *)title;

+(instancetype)bb_btMakeWithSuperV:(UIView *)superV
                         imageName:(NSString *)imageName;
@end
