//
//  MessageTableViewCell.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/29.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *selelctBtn;

@property (weak, nonatomic) IBOutlet UIView *unreadStatusView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftContentConstraint;

-(void)isEidtMode:(BOOL)isEidt;
@end
