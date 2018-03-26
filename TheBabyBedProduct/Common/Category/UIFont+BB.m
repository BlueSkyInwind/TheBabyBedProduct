//
//  UIFont+BB.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "UIFont+BB.h"

@implementation UIFont (BB)
+(instancetype)bb_fontWithSize:(CGFloat)fontSize
{
   // 1.iOS9.0以后系统自带了平方字体PingFangSC，但是在iOS9.0以前，是没有平方字体PingFangSC的，如果我们想用平方字体，在iOS9.0以上是好的，但是在低于9.0的系统上是找不到这个字体的，例如：
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular"size:fontSize];
    //2.我们得到的font为nil，这样就需要我们手动导入第三方字体，这样我在工程里面判断一下；
//    if(font == nil){
//        //这个是我手动导入的第三方平方字体
//        font = [UIFont fontWithName:@"PingFang-SC-Regular"size:fontSize];
//    }
    //3.如果导入的字体有误，就用系统的。
    if (font == nil) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}
@end
