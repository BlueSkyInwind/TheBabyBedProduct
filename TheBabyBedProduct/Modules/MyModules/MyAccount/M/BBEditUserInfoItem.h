//
//  BBEditUserInfoItem.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/11.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBEditUserInfoItem : NSObject

@property(nonatomic,copy) NSString *babyName;
@property(nonatomic,assign) BBUserGenderType gender;
/** 用户身份 */
@property(nonatomic,copy) NSString *identity;
/** 出生日期 */
@property(nonatomic,copy) NSString *bothDate;
/** 所在地 */
@property(nonatomic,copy) NSString *city;
/** 头像id */
@property(nonatomic,copy) NSString *avatar;
@end
