//
//  PPTextfield+EasilyMake.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "PPTextfield+EasilyMake.h"
#import "NSMutableAttributedString+PPTextField.h"

@implementation PPTextfield (EasilyMake)
/**创建TF tag值 字体大小 字体颜色  attributed占位符 attributed占位符字体 attributed占位符颜色 父视图*/
+(PPTextfield *)pp_tfMakeWithSuperV:(UIView *)superV tag:(NSInteger)tag fontSize:(CGFloat)fontSize textColor:(UIColor *)textColor attributedPlaceholderText:(NSString *)attributedPlaceholderText attributedPlaceholderFontSize:(CGFloat)attributedPlaceholderFontSize attributedPlaceholderTextColor:(UIColor *)attributedPlaceholderTextColor
{
    
    PPTextfield *tf = [[PPTextfield alloc]init];
    if (superV) {
        [superV addSubview:tf];
    }
    if (tag > 0) {
        tf.tag = tag;
    }
    if (fontSize > 0) {
        tf.font = [UIFont systemFontOfSize:fontSize];
    }
    if (textColor) {
        tf.textColor = textColor;
    }
    if (attributedPlaceholderText.length > 0) {
        NSMutableAttributedString *placeholderStr = [[NSMutableAttributedString alloc]initWithString:attributedPlaceholderText];
        if (attributedPlaceholderTextColor) {
            [placeholderStr pp_setColor:attributedPlaceholderTextColor];
        }
        if (attributedPlaceholderFontSize > 0) {
            [placeholderStr pp_setFont:[UIFont systemFontOfSize:attributedPlaceholderFontSize]];
        }
        tf.attributedPlaceholder = placeholderStr;
    }
    
    return tf;
}
@end
