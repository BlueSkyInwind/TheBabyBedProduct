//
//  DateValueFormatter.m
//  ChartsDemo
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/Charts
//


#import "DateValueFormatter.h"

@interface DateValueFormatter ()
{
    NSDateFormatter *_dateFormatter;
}
@end

@implementation DateValueFormatter

- (id)init
{
    self = [super init];
    if (self)
    {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"HH:mm";
    }
    return self;
}

- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis
{
//    return [_dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:value]];
    NSInteger count = self.xAxisDatas.count;
    double factor = axis.axisMaximum / count;
    int index = value / factor;
    if (index >= 0 && index < count) {
        return self.xAxisDatas[index];
    }
    return @"";
}

@end




