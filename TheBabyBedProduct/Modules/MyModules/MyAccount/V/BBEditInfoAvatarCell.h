//
//  BBEditInfoAvatarCell.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/30.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBEditInfoAvatarCell : UITableViewCell
@property(nonatomic,strong) UIImageView *avatarImgV;

-(void)setupCellAvatar:(NSString *)avatarUrl;
@end


