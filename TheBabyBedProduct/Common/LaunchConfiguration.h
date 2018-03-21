//
//  LaunchConfiguration.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LaunchConfiguration : NSObject

+ (LaunchConfiguration *)shared;
-(void)InitializeAppConfiguration;

@end
