//
//  UIImageView+EasilyMake.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "UIImageView+EasilyMake.h"

@implementation UIImageView (EasilyMake)
+(instancetype)bb_imgVMakeWithSuperV:(UIView *)superV
{
    UIImageView *imgV = [[UIImageView alloc]init];
    if (superV) {
        [superV addSubview:imgV];
    }
    imgV.contentMode = UIViewContentModeScaleToFill;
    return imgV;
}

+(instancetype)bb_imgVMakeWithSuperV:(UIView *)superV
                             imgName:(NSString *)imgName
{
    UIImageView *imgV = [self bb_imgVMakeWithSuperV:superV];
    if (imgName.length > 0) {
        imgV.image = [UIImage imageNamed:imgName];
    }
    return imgV;
}



@end
