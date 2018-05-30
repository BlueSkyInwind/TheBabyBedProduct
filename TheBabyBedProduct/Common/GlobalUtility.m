//
//  GlobalUtility.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "GlobalUtility.h"

@implementation GlobalUtility

+ (GlobalUtility *)sharedUtility
{
    static GlobalUtility *sharedUtilityInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedUtilityInstance = [[self alloc] init];
    });
    return sharedUtilityInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _airkissCount = 0;
        _BLEOpen = false;
    }
    return self;
}

+ (void)EmptyData
{
    

    
}

@end
