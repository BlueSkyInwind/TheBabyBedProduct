//
//  UILabel+EasilyMake.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "UILabel+EasilyMake.h"

@implementation UILabel (EasilyMake)
+(UILabel *)bb_lbMakeWithSuperV:(UIView *)superV
                       fontSize:(CGFloat)fontSize
                      alignment:(NSTextAlignment)alignment
                      textColor:(UIColor *)textColor
{
    return creatLB(superV, nil, fontSize, alignment, textColor);
}

static UILabel *creatLB(UIView *superV,NSString *text,CGFloat fontSize,NSTextAlignment alignment,UIColor *textColor){
    UILabel *lb = [[UILabel alloc]init];
    if (superV) {
        [superV addSubview:lb];
    }
    if (text) {
        lb.text = text;
    }
    if (fontSize > 0) {
        lb.font = [UIFont systemFontOfSize:fontSize];
    }
    lb.textAlignment = alignment;
    if (textColor) {
        lb.textColor = textColor;
    }
    return lb;
}
@end
