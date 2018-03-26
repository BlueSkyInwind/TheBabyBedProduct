//
//  UILabel+EasilyMake.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (EasilyMake)
+(UILabel *)bb_lbMakeWithSuperV:(UIView *)superV
                       fontSize:(CGFloat)fontSize
                      alignment:(NSTextAlignment)alignment
                      textColor:(UIColor *)textColor;
@end
