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
-(void)setupCellWithConsumeRecord:(BBConsumeRecord *)consumeRecord
{
    //充值1元等于10分钟
    NSString *monetyTenStr = [NSString stringWithFormat:@"%f",[consumeRecord.rechargeMoney floatValue] * 10];
    NSString *moneyedStr = [self moneyTominutes:monetyTenStr];
    if (consumeRecord.consumptioType == BBConsumeTypeRecharge) {
        if (consumeRecord.rechargeType == BBPayTypeZhiFuBao) {
            self.leftRecordTextLB.text = [NSString stringWithFormat:@"支付宝充值%@元",consumeRecord.rechargeMoney];
        }else if (consumeRecord.rechargeType == BBPayTypeWeiXin){
            self.leftRecordTextLB.text = [NSString stringWithFormat:@"微信充值%@元",consumeRecord.rechargeMoney];
        }
        self.rightGoldLB.textColor = k_color_appOrange;
        self.rightGoldLB.text = [NSString stringWithFormat:@"+%@分钟",moneyedStr];
    }else{
        self.leftRecordTextLB.text = [NSString stringWithFormat:@"看视频消费了%ld元",(long)consumeRecord.rechargeMoney];
        self.rightGoldLB.textColor = k_color_515151;
        self.rightGoldLB.text = [NSString stringWithFormat:@"-%@分钟",moneyedStr];
    }
    
}
-(NSString *)moneyTominutes:(NSString *)moneyStr
{
    NSDecimalNumber * valueNum = [NSDecimalNumber decimalNumberWithString:moneyStr];
    NSDecimalNumberHandler * handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    NSNumberFormatter * formatter = [[NSNumberFormatter alloc]init];
    formatter.zeroSymbol = @"0";
    formatter.maximumFractionDigits = 2;
    NSString *str = [formatter stringFromNumber:[valueNum decimalNumberByRoundingAccordingToBehavior:handler]];
    if ([str hasPrefix:@"."]) {
        return [NSString stringWithFormat:@"0%@",str];
    }
    return str;
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

    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(leftMargin, 46.5, _k_w-leftMargin*2, 0.5)];
    line.backgroundColor = K_color_line;
    [self addSubview:line];
}

@end
