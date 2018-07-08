//
//  UIFont+BB.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
//苹方-简 中粗体
UIKIT_EXTERN NSString * const kFontNamePingFangSCSemibold;
//苹方-简 中黑体
UIKIT_EXTERN NSString * const kFontNamePingFangSCMedium;
//苹方-简 常规体
UIKIT_EXTERN NSString * const kFontNamePingFangSCRegular;


#define kFontSemibold(fontSize)   [UIFont ppmake_fontPingFangSCSemiboldSize:(fontSize)]
#define kFontMedium(fontSize)     [UIFont ppmake_fontPingFangSCMediumSize:(fontSize)]
#define kFontRegular(fontSize)    [UIFont ppmake_fontPingFangSCRegularSize:(fontSize)]

@interface UIFont (BB)
+(instancetype)ppmake_fontPingFangSCSemiboldSize:(CGFloat)size;
+(instancetype)ppmake_fontPingFangSCMediumSize:(CGFloat)size;
+(instancetype)ppmake_fontPingFangSCRegularSize:(CGFloat)size;
@end
