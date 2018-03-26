//
//  UIFont+YX_Font.m
//  fxdProduct
//
//  Created by admin on 2017/11/21.
//  Copyright © 2017年 dd. All rights reserved.
//

#import "UIFont+YX_Font.h"
#import <objc/runtime.h>

@implementation NSObject (Extension)

+ (void)swizzleClassSelector:(SEL)originalSelector withSwizzledClassSelector:(SEL)swizzledSelector
{
    Method originalMethod = class_getClassMethod(self, originalSelector);
    Method swizzledMethod = class_getClassMethod(self, swizzledSelector);
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

@end

@implementation UIFont (YX_Font)
/*
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleClassSelector:@selector(systemFontOfSize:) withSwizzledClassSelector:@selector(yx_systemFontOfSize:)];
        [self swizzleClassSelector:@selector(systemFontOfSize:weight:) withSwizzledClassSelector:@selector(yx_systemFontOfSize:weight:)];
        [self swizzleClassSelector:@selector(boldSystemFontOfSize:) withSwizzledClassSelector:@selector(yx_boldSystemFontOfSize:)];
        [self swizzleClassSelector:@selector(italicSystemFontOfSize:) withSwizzledClassSelector:@selector(yx_italicSystemFontOfSize:)];
        [self swizzleClassSelector:@selector(fontWithName:size:) withSwizzledClassSelector:@selector(yx_fontWithName:size:)];
    });
}
 */

+(CGFloat)obtainDisplayFontSize:(CGFloat)fontSize{
    CGFloat fontScale = 1.0;
    if (UI_IS_IPHONE5) {
        fontScale = 1.0;
    }else if (UI_IS_IPHONE6){
        fontScale = 1.0;
    }else if (UI_IS_IPHONE6P){
        fontScale = 1.17;
    }else if (UI_IS_IPHONEX){
        fontScale = 1.17;
    }
    return fontScale * fontSize;
}

+ (UIFont *)yx_systemFontOfSize:(CGFloat)fontSize
{
//    return [self yx_systemFontOfSize:[self obtainDisplayFontSize:fontSize]];
    return [self systemFontOfSize:[self obtainDisplayFontSize:fontSize]];

}

+ (UIFont *)yx_systemFontOfSize:(CGFloat)fontSize weight:(CGFloat)weight
{
    return [self systemFontOfSize:[self obtainDisplayFontSize:fontSize] weight:weight];
}

+ (UIFont *)yx_boldSystemFontOfSize:(CGFloat)fontSize
{
    return [self boldSystemFontOfSize:[self obtainDisplayFontSize:fontSize]];
}

+ (UIFont *)yx_italicSystemFontOfSize:(CGFloat)fontSize
{
    return [self italicSystemFontOfSize:[self obtainDisplayFontSize:fontSize]];
}

+ (nullable UIFont *)yx_fontWithName:(NSString *)fontName size:(CGFloat)fontSize
{
    return [self fontWithName:fontName size:[self obtainDisplayFontSize:fontSize]];
}

@end
