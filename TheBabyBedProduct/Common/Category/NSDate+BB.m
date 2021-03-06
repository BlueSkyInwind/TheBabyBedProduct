//
//  NSDate+BB.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/22.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "NSDate+BB.h"

@implementation NSDate (BB)
+(NSString *)bb_strFromTimestamp
{
    //13位是毫秒，10位是秒，ios生成的是10位的。
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeSp =[date timeIntervalSince1970]*1000;
    return [NSString stringWithFormat:@"%ld",(NSInteger)timeSp];
}
+(NSString *)bb_todayStr
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    df.locale = [NSLocale currentLocale];
    df.timeZone = [NSTimeZone localTimeZone];
    df.dateFormat = @"yyyy-MM-dd";
    return [df stringFromDate:[NSDate date]];
}
@end


@implementation NSNumber (Timestamp)
-(NSDate *)bb_dateFromTimestamp
{
    NSTimeInterval timeInteral = 0;
    NSString *timestampStr = [NSString stringWithFormat:@"%@",self];
    if (timestampStr.length == 13) {
        timeInteral = [timestampStr doubleValue]/1000;
    }else if (timestampStr.length == 10){
        timeInteral = [timestampStr doubleValue];
    }else{
        //不是10位or13位的默认不是时间戳
        return nil;
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInteral];
    return date;
}
-(NSString *)bb_dateFromTimestampForyyyyMMdd
{
    NSDate *birthdayDate = [self bb_dateFromTimestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *birthdayStr = [formatter stringFromDate:birthdayDate];

    return birthdayStr;
}
-(NSString *)bb_dateFromTimestampForyyyyMMddHHmmss
{
    NSDate *birthdayDate = [self bb_dateFromTimestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *birthdayStr = [formatter stringFromDate:birthdayDate];
    return birthdayStr;
}

-(NSString *)bb_timeIntervalFromTimestamp
{
    NSDate *birthdayDate = [self bb_dateFromTimestamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *birthdayStr = [formatter stringFromDate:birthdayDate];
    NSString *todayStr = [formatter stringFromDate:[NSDate date]];
    NSDate *birthdayJustDate = [formatter dateFromString:birthdayStr];
    NSDate *todayJustDate = [formatter dateFromString:todayStr];
    
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay
                                             fromDate:birthdayJustDate
                                               toDate:todayJustDate
                                              options:0];
    if (comps.year > 0) {
        return [NSString stringWithFormat:@"您的宝宝已经%ld年%ld月%ld天了",(long)comps.year,(long)comps.month,(long)comps.day];
    }else{
        if (comps.month > 0) {
            return [NSString stringWithFormat:@"您的宝宝已经%ld月%ld天了",(long)comps.month,(long)comps.day];
        }
       return [NSString stringWithFormat:@"您的宝宝已经%ld天了",(long)comps.day];
    }
    
}
@end

@implementation NSString (Timestamp)
-(NSNumber *)bb_strForTimestamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *bitrhdayDate = [formatter dateFromString:self];
    double timeInterval = [bitrhdayDate timeIntervalSince1970];
    return [NSNumber numberWithDouble:timeInterval];
}
@end
