//
//  UIFont+YX_Font.h
//  fxdProduct
// 
//  Created by admin on 2017/11/21.
//  Copyright © 2017年 dd. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
  适配不同的机型的字体大小
 */
@interface UIFont (YX_Font)

+ (UIFont * _Nullable )yx_systemFontOfSize:(CGFloat)fontSize;

+ (UIFont *_Nullable)yx_systemFontOfSize:(CGFloat)fontSize weight:(CGFloat)weight;

+ (UIFont *_Nullable)yx_boldSystemFontOfSize:(CGFloat)fontSize;

+ (UIFont *_Nullable)yx_italicSystemFontOfSize:(CGFloat)fontSize;

+ (nullable UIFont *)yx_fontWithName:(NSString * _Nullable )fontName size:(CGFloat)fontSize;

@end
