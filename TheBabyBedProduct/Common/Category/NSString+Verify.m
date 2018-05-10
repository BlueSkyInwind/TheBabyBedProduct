//
//  NSString+Verify.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/7.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "NSString+Verify.h"
#import <CommonCrypto/CommonDigest.h>

// 随机字符表
//static const NSString *kRandomStrSet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
static const NSString *kRandomStrSet = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

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

/**
 随机生成一个32位的字符串
 */
+(NSString *)pp_randomStr
{
    NSMutableString *mutStr = [[NSMutableString alloc]initWithCapacity:32];
    for (int i = 0; i < 32; i++) {
        NSInteger index = arc4random_uniform((uint32_t)[kRandomStrSet length]);
        [mutStr appendString:[kRandomStrSet substringWithRange:NSMakeRange(index, 1)]];
    }
    return mutStr;
}

- (NSString*)pp_sha1
{
//    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
//    NSData *data = [NSData dataWithBytes:cstr length:self.length];
     NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    NSMutableString* output = [[self convertDataToHexStr:data] mutableCopy];
    
//    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
//    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++){
//        [output appendFormat:@"%02x", digest[i]];
//    }
    
    return output;
}

- (NSString *)convertDataToHexStr:(NSData *)data {
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *string = [[NSMutableString alloc] initWithCapacity:[data length]];
    
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange,BOOL *stop) {
        unsigned char *dataBytes = (unsigned char*)bytes;
        for (NSInteger i =0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) &0xff];
            if ([hexStr length] == 2) {
                [string appendString:hexStr];
            } else {
                [string appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return string;
}




@end
