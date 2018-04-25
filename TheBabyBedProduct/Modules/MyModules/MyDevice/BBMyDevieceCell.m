//
//  BBMyDevieceCell.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/3.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMyDevieceCell.h"
#import "BBUserDevice.h"

@interface BBMyDevieceCell ()
@property(nonatomic,strong) UILabel *leftTextLB;
@property(nonatomic,strong) UILabel *rightLB;
@property(nonatomic,strong) QMUIFillButton *deleteBT;
@end

@implementation BBMyDevieceCell
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
-(void)setupCellWithIndexPath:(NSIndexPath *)indexPath leftTitle:(NSString *)leftTitle
{
    if (indexPath.section == 0) {
        self.deleteBT.hidden = YES;
        self.rightLB.hidden = NO;
        CGFloat leftMargin = 10;
        CGFloat totalW = _k_w-leftMargin*2;
        CGFloat rightW = totalW/3;
        self.rightLB.frame = CGRectMake(self.leftTextLB.right, 0, rightW, 47);

        BBUserDevice *device = [BBUserDevice bb_getUserDevice];
        if ([leftTitle isEqualToString:@"设备状态"]) {
            self.rightLB.text = [device.deviceStatus bb_safe];
        }else if ([leftTitle isEqualToString:@"设备型号"]){
            self.rightLB.text = [device.deviceType bb_safe];
        }else if ([leftTitle isEqualToString:@"硬件版本"]){
            self.rightLB.text = [device.deviceVersion bb_safe];
        }else if ([leftTitle isEqualToString:@"设备ID"]){
            self.rightLB.text = [device.deviceId bb_safe];
        }
    }else{
        self.deleteBT.hidden = NO;
        self.rightLB.hidden = YES;
        self.deleteBT.frame = CGRectMake(_k_w-90, 7, 80, 33);
    }
    self.leftTextLB.text = leftTitle;
}
-(void)creatCellUI
{
    self.leftTextLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    self.rightLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:16 alignment:NSTextAlignmentRight textColor:k_color_515151];
    self.deleteBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.deleteBT];
    self.deleteBT.titleLabel.font = [UIFont systemFontOfSize:16];
    self.deleteBT.fillColor = k_color_appOrange;
    self.deleteBT.titleTextColor = [UIColor whiteColor];
    [self.deleteBT setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBT addTarget:self action:@selector(deleteSenorAction) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat leftMargin = 10;
    CGFloat totalW = _k_w-leftMargin*2;
    CGFloat leftW = totalW*2/3;
    
    self.leftTextLB.frame = CGRectMake(leftMargin, 0, leftW, 47);
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(leftMargin, 46.5, _k_w-leftMargin*2, 0.5)];
    line.backgroundColor = K_color_line;
    [self addSubview:line];
}
-(void)deleteSenorAction
{
    if (self.deleteSensorBlock) {
        if ([self.leftTextLB.text isEqualToString:@"踢被传感器"]) {
            self.deleteSensorBlock(BBMyDevieceCellBindingTypeTB);
        }
        if ([self.leftTextLB.text isEqualToString:@"体温传感器"]) {
            self.deleteSensorBlock(BBMyDevieceCellBindingTypeTW);
        }
        if ([self.leftTextLB.text isEqualToString:@"温度传感器"]) {
            self.deleteSensorBlock(BBMyDevieceCellBindingTypeWD);
        }
    }
}


@end
