//
//  HomeHeaderView.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeHeaderView : UIView

/* 视频*/
@property(nonatomic,strong)UIView * videoView;

/* 宝宝状态*/
@property(nonatomic,strong)UIView * babyStatusView;

/* 标题*/
@property(nonatomic,strong)UILabel  * titleLabel;

/* 状态数组*/
@property(nonatomic,strong)NSArray * statusArr;

+(instancetype)initWithBabyStatus:(NSArray *)statusArr;


@end
