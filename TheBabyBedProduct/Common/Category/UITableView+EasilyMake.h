//
//  UITableView+EasilyMake.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EasilyMake)
/** 创建tableView 【父视图 frame 代理 背景色 TableViewStyle】*/
+(instancetype)bb_tableVMakeWithSuperV:(UIView *)superV
                                 frame:(CGRect)frame
                              delegate:(id)delegate
                               bgColor:(UIColor *)bgColor
                                 style:(UITableViewStyle)style;
@end
