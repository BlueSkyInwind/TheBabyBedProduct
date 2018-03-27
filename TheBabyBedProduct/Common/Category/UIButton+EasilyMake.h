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


@interface UIButton (EasilyConfigure)
/**
 设置btn Normal和Highlighted下的image 【相同】
 */
-(void)bb_btSetImageWithImgName:(NSString *)imgName;
/**
 设置btn Normal和Highlighted下的TitleColor 【相同】
 */
-(void)bb_btSetTitleColor:(UIColor *)titleColor;
/**
 设置btn Normal和Highlighted下的Title 【相同】
 */
-(void)bb_btSetTitle:(NSString *)title;
@end
