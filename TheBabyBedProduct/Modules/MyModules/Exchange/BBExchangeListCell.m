//
//  BBExchangeListCell.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBExchangeListCell.h"
#import "BBExchangeList.h"

@interface BBExchangeListCell ()
@property(nonatomic,strong) UILabel *exchangeLB;
@end

@implementation BBExchangeListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self creatCellUI];
    }
    return self;
}
-(void)creatCellUI
{
    self.exchangeLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    CGFloat leftMargin = 10;
    CGFloat totalW = _k_w-leftMargin*2;
    self.exchangeLB.frame = CGRectMake(leftMargin, 0, totalW, 47);
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(leftMargin, 46.5, _k_w-leftMargin*2, 0.5)];
    line.backgroundColor = K_color_line;
    [self addSubview:line];
}
-(void)setupWithExchange:(BBExchangeList *)exchange
{
    self.exchangeLB.text = [NSString stringWithFormat:@"用%ld积分兑换%ld分钟",(long)exchange.use_score,(long)exchange.cur_time];
}
@end
