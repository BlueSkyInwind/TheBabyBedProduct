//
//  UIImageView+EasilyMake.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (EasilyMake)
+(instancetype)bb_imgVMakeWithSuperV:(UIView *)superV;

+(instancetype)bb_imgVMakeWithSuperV:(UIView *)superV
                             imgName:(NSString *)imgName;
@end
