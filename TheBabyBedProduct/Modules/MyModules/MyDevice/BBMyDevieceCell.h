//
//  BBMyDevieceCell.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/3.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBMyDevieceCell : UITableViewCell
@property(nonatomic,copy) void(^deleteSensorBlock)(void);
-(void)setupCellWithIndexPath:(NSIndexPath *)indexPath leftTitle:(NSString *)leftTitle;
@end
