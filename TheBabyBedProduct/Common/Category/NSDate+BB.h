//
//  NSDate+BB.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/22.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BB)
+(NSString *)bb_strFromTimestamp;
+(NSString *)bb_todayStr;
@end


@interface NSNumber (Timestamp)
-(NSDate *)bb_dateFromTimestamp;
-(NSString *)bb_dateFromTimestampForyyyyMMdd;
-(NSString *)bb_dateFromTimestampForyyyyMMddHHmmss;
-(NSString *)bb_timeIntervalFromTimestamp;
@end


@interface NSString (Timestamp)
-(NSNumber *)bb_strForTimestamp;
@end
