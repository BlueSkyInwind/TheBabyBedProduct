//
//  BBNotificationSettingListCell.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BBNotificationSettingListCellStyle) {
    BBNotificationSettingListCellStyleSwitch = 0,
    BBNotificationSettingListCellStyleArrow
};

@interface BBNotificationSettingListCell : UITableViewCell
-(void)setupCellStyle:(BBNotificationSettingListCellStyle)cellStyle title:(NSString *)title;
@end
