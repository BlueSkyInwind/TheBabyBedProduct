//
//  BBMusicRequestModel.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/5/11.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBMusicRequestModel : NSObject
@property(nonatomic,copy) NSString *app_id;
@property(nonatomic,copy) NSString *device_id;
@property(nonatomic,copy) NSString *nonce;
@property(nonatomic,copy) NSString *signature;
@property(nonatomic,assign) int timestamp;
@end
