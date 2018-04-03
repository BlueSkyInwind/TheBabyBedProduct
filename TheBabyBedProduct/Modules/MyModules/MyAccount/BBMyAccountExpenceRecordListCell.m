//
//  BBMyAccountExpenceRecordListCell.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/3.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMyAccountExpenceRecordListCell.h"

@interface BBMyAccountExpenceRecordListCell ()
@property(nonatomic,strong) UILabel *leftRecordTextLB;
@property(nonatomic,strong) UILabel *rightGoldLB;
@end

@implementation BBMyAccountExpenceRecordListCell
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
    self.leftRecordTextLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    self.rightGoldLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:16 alignment:NSTextAlignmentRight textColor:k_color_appOrange];
    
    CGFloat leftMargin = 10;
    CGFloat totalW = _k_w-leftMargin*2;
    CGFloat leftW = totalW*2/3;
    CGFloat rightW = totalW/3;
    
    self.leftRecordTextLB.frame = CGRectMake(leftMargin, 0, leftW, 47);
    self.rightGoldLB.frame = CGRectMake(self.leftRecordTextLB.right, 0, rightW, 47);
    
#warning todo
    self.leftRecordTextLB.text = @"微信充值10元";
    self.rightGoldLB.text = @"+100金币";
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(leftMargin, 46.5, _k_w-leftMargin*2, 0.5)];
    line.backgroundColor = K_color_line;
    [self addSubview:line];
}

@end
