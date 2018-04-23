//
//  NSString+Verify.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/7.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "NSString+Verify.h"

@implementation NSString (Verify)
#pragma mark --- 手机号验证
-(BOOL)bb_isPhoneNumber
{
    NSString *phoneNum = self;
    NSString *regexStr = @"^1[3,4,5,6,7,8,9]\\d{9}$";
    NSError *error;
    NSRegularExpression *regular = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    if (error) return NO;
    NSInteger count = [regular numberOfMatchesInString:phoneNum options:NSMatchingReportCompletion range:NSMakeRange(0, phoneNum.length)];
    return count > 0;
}
#pragma mark --- 对字符串安全处理
-(NSString *)bb_safe
{
    NSString *str = self;
    if (isSafeStr(str)) {
        return str;
    }else{
        return @"";
    }
}
#pragma mark --- 判断字符串是不是安全的
-(BOOL)bb_isSafe
{
    NSString *str = self;
    return isSafeStr(str);
}

static BOOL isSafeStr(NSString *str){
    if ([str isKindOfClass:[NSNull class]] || str == nil || str.length == 0 || [str isEqualToString:@"(null)"]  || [str isEqualToString:@"null"] || [str isEqualToString:@"NULL"] || [str isEqualToString:@"（null）"] || [str isEqualToString:@"<null>"] || [str isEqualToString:@"<NULL>"]) {
        return NO;
    }else{
        return YES;
    }
}
@end
