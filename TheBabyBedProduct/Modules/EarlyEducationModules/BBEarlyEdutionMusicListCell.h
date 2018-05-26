//
//  BBEarlyEdutionMusicListCell.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/5/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBMusic.h"

@interface BBEarlyEdutionMusicListCell : UITableViewCell
@property(nonatomic,copy) void(^playBlock)(void);
-(void)setupCell:(BBMusic *)music;
@end
