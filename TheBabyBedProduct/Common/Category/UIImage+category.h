//
//  UIImage+category.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (category)

-(UIImage *)TransformtoSize:(CGSize)Newsize;

+(UIImage *)bb_imageWithColor:(UIColor *)color;
+(UIImage *)bb_imageWithColor:(UIColor *)color size:(CGSize)size;
@end
