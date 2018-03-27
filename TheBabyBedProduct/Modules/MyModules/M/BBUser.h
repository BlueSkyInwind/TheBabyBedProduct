//
//  BBUser.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BBUserHelpers [BBUserHelper shareInstance]

@interface BBUser : NSObject<NSCoding>
/** 是否登录 */
@property(nonatomic,assign) BOOL hasLogined;

+(BBUser *)bb_getUser;
+(void)bb_saveUser:(BBUser *)user;
@end


@interface BBUserHelper : NSObject
+(instancetype)shareInstance;
/** 是否登录 */
@property(nonatomic,assign,readonly) BOOL hasLogined;
@end
