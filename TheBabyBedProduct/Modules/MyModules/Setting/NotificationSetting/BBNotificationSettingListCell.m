//
//  BBNotificationSettingListCell.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBNotificationSettingListCell.h"

@interface BBNotificationSettingListCell ()
@property(nonatomic,strong) UILabel *textLB;
@property(nonatomic,strong) UIImageView *arrowImgV;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UISwitch *settingSwitch;
@end

@implementation BBNotificationSettingListCell

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
-(void)setupCellStyle:(BBNotificationSettingListCellStyle)cellStyle title:(NSString *)title
{
    self.textLB.text = title;
    if (cellStyle == BBNotificationSettingListCellStyleSwitch) {
        self.settingSwitch.hidden = NO;
        self.arrowImgV.hidden = YES;
        self.settingSwitch.frame = CGRectFlatMake(_k_w-20-26,13, 26, 21);
    }else{
        self.settingSwitch.hidden = YES;
        self.arrowImgV.hidden = NO;
        self.arrowImgV.frame = CGRectMake(_k_w-20-6, 18, 6, 11);
    }
}
-(void)creatCellUI
{
    self.textLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    self.arrowImgV = [UIImageView bb_imgVMakeWithSuperV:self.contentView imgName:@"youyi"];
    
    UISwitch *s = [[UISwitch alloc]init];
    self.settingSwitch = s;
    [self.contentView addSubview:s];
    s.transform = CGAffineTransformMakeScale(0.75,0.75);
    s.onTintColor = [UIColor colorWithRed:76/255.0 green:217/255.0 blue:100/255.0 alpha:1];
    s.thumbTintColor = [UIColor whiteColor];
    s.tintColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    [s addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    
    CGFloat totalH = 47;
    CGFloat leftMargin = 20;

    
    CGFloat textLBX = leftMargin;
    CGFloat textLBW = _k_w-leftMargin*2-80;
    
    self.textLB.frame = CGRectMake(textLBX, 0, textLBW, totalH);
    
    self.line = [[UIView alloc]initWithFrame:CGRectFlatMake(leftMargin, 47, _k_w-leftMargin, 0.5)];
    [self.contentView addSubview:self.line];
    self.line.backgroundColor = K_color_line;
}

-(void)switchAction:(UISwitch *)s
{
    NSLog(@"%@",s.on?@"开":@"关");
}

@end
