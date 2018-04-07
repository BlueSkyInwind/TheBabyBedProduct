//
//  deviceListTableViewCell.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/6.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface deviceListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *deviceImageView;
@property (weak, nonatomic) IBOutlet UILabel *deviceNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *statusLabel;



@end
