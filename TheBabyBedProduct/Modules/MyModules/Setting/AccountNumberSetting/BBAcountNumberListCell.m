//
//  BBAcountNumberListCell.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBAcountNumberListCell.h"

@interface BBAcountNumberListCell ()
@property(nonatomic,strong) UILabel *textLB;
@property(nonatomic,strong) UIImageView *arrowImgV;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) UILabel *subTextLB;
@end
@implementation BBAcountNumberListCell

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
-(void)setupCellWithTitle:(NSString *)title
{
    BBUser *user = [BBUser bb_getUser];
    CGFloat totalH = 47;
    CGFloat leftMargin = 20;
    if ([title isEqualToString:@"手机号码"]) {
        self.arrowImgV.hidden = YES;
        self.subTextLB.frame = CGRectMake(self.textLB.right, 0, _k_w-leftMargin*2-100, totalH);
        self.subTextLB.text = [self setupPhoneNumWithUser:user];
    }else{
        self.arrowImgV.hidden = NO;
        CGFloat arrowW = 6;
        CGFloat subTextLBW = _k_w-leftMargin*2-100-arrowW-5;
        self.subTextLB.frame = CGRectMake(self.textLB.right, 0, subTextLBW, totalH);
        if (user.hasLogined) {
            self.subTextLB.text = @"已设置";
        }
    }
    self.textLB.text = title;
    
#warning todo 根据本地用户登录信息判断
    if ([title isEqualToString:@"微信账号"]) {
        self.subTextLB.text = (BBUserHelpers.hasWeiXinBinding?@"已绑定":@"去绑定");
    }else if ([title isEqualToString:@"QQ账号"]) {
        self.subTextLB.text = (BBUserHelpers.hasQQBinding?@"已绑定":@"去绑定");
    }else if ([title isEqualToString:@"微博账号"]) {
        self.subTextLB.text = (BBUserHelpers.hasWeiBoBinding?@"已绑定":@"去绑定");
    }
    
}
-(NSString *)setupPhoneNumWithUser:(BBUser *)user
{
    NSString *phoneNum = @"";
    if ([user.username bb_isPhoneNumber]) {
        phoneNum = [user.username substringToIndex:3];
    }
    if (phoneNum.length == 3) {
        phoneNum = [phoneNum stringByAppendingString:@"********"];
    }
    return phoneNum;
}
-(void)creatCellUI
{
    self.textLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    self.subTextLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:14 alignment:NSTextAlignmentRight textColor:k_color_153153153];
    self.arrowImgV = [UIImageView bb_imgVMakeWithSuperV:self.contentView imgName:@"youyi"];
    
    CGFloat totalH = 47;
    CGFloat leftMargin = 20;
    
    CGFloat arrowW = 6;
    CGFloat arrowH = 11;
    CGFloat arrowY = (totalH-arrowH)/2;
    CGFloat arrowX = _k_w-leftMargin-arrowW;
    
    CGFloat textLBW = 100;
    CGFloat subTextLBW = _k_w-leftMargin*2-100-arrowW-5;
    self.textLB.frame = CGRectMake(leftMargin, 0, textLBW, totalH);
    self.subTextLB.frame = CGRectMake(self.textLB.right, 0, subTextLBW, totalH);
    self.arrowImgV.frame = CGRectMake(arrowX, arrowY, arrowW, arrowH);
    
    self.line = [[UIView alloc]initWithFrame:CGRectFlatMake(leftMargin, 47, _k_w-leftMargin, 0.5)];
    [self.contentView addSubview:self.line];
    self.line.backgroundColor = K_color_line;
}

@end
