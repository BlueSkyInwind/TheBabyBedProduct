//
//  PPTextfield+EasilyMake.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "PPTextfield.h"

@interface PPTextfield (EasilyMake)

/**
 创建TF

 @param superV 父视图
 @param tag tag值
 @param fontSize 字体大小
 @param textColor 字体颜色
 @param attributedPlaceholderText attributed占位符
 @param attributedPlaceholderFontSize attributed占位符字体
 @param attributedPlaceholderTextColor attributed占位符颜色
 */
+(PPTextfield *)pp_tfMakeWithSuperV:(UIView *)superV
                                tag:(NSInteger)tag
                           fontSize:(CGFloat)fontSize
                          textColor:(UIColor *)textColor
          attributedPlaceholderText:(NSString *)attributedPlaceholderText
      attributedPlaceholderFontSize:(CGFloat)attributedPlaceholderFontSize
     attributedPlaceholderTextColor:(UIColor *)attributedPlaceholderTextColor;
@end
