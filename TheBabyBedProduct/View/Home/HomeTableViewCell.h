//
//  HomeTableViewCell.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell


/* 图片image*/
@property(nonatomic,strong)UIImageView * iconImageView;

/* 标题*/
@property(nonatomic,strong)UILabel * titleLabel;

/* 内容*/
@property(nonatomic,strong)UILabel  * contentLabel;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setIcon:(NSString *)imageName title:(NSString *)title content:(NSString *)content;

@end
