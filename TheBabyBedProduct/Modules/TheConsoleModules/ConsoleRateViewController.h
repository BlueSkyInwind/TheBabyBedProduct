//
//  ConsoleRateViewController.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/24.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ConsoleRateType) {
    
    BabyCryType,
    BabyKickType,
    BabyWetType,

};


@interface ConsoleRateViewController : BaseViewController


@property (nonatomic,assign)ConsoleRateType rateType;



@end
