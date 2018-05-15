//
//  NSString+Verify.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/7.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Verify)

/**
 手机号验证 (不要出来太多，处理以后各种大王卡之类的卡)
 */
-(BOOL)bb_isPhoneNumber;

/** 对字符串安全处理 */
-(NSString *)bb_safe;
/** 判断字符串是不是安全的 */
-(BOOL)bb_isSafe;


/**
 随机生成一个32位的字符串
 */
+(NSString *)pp_randomStr;

/**
 sha1加密
 */
+ (NSString*)pp_sha1:(NSString *)str;
@end
