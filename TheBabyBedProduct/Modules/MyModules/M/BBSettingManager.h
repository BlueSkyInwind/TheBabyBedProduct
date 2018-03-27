//
//  BBSettingManager.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBSettingManager : NSObject<NSCoding>
/** 保存警报铃声选择的是哪个 */
@property(nonatomic,strong) NSNumber *selectedRingIndex;


+(void)bb_saveSettingManager:(BBSettingManager *)manager;
+(BBSettingManager *)bb_getSettingManager;
@end

