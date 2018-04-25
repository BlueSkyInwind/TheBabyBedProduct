//
//  BBDeviceHeaderBottomView.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBDeviceHeaderBottomView.h"
#import "BBUserDevice.h"

@interface BBDeviceHeaderBottomView ()
@property(nonatomic,strong) UILabel *leftLB;
@property(nonatomic,strong) QMUIFillButton *rightBT;
@end

@implementation BBDeviceHeaderBottomView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}
-(void)creatUI
{
    UILabel *leftLB = [UILabel bb_lbMakeWithSuperV:self fontSize:16 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    leftLB.frame = CGRectMake(10, 9, _k_w-10-10-80, 40);
    self.leftLB = leftLB;
    
    QMUIFillButton *rightBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:rightBT];
    rightBT.titleLabel.font = [UIFont systemFontOfSize:16];
    rightBT.fillColor = k_color_appOrange;
    rightBT.titleTextColor = [UIColor whiteColor];
    [rightBT addTarget:self action:@selector(bindingAction) forControlEvents:UIControlEventTouchUpInside];
    self.rightBT = rightBT;
    [self updateDeviceHBView];
}
-(void)bindingAction
{
    if (self.bingingOrCancelBlock) {
        BBUserDevice *device = [BBUserDevice bb_getUserDevice];
        if ([device.deviceId bb_isSafe]) {
            self.bingingOrCancelBlock(device.deviceId);
        }else{
            self.bingingOrCancelBlock(nil);
        }
    }
}
-(void)updateDeviceHBView
{
    BBUserDevice *device = [BBUserDevice bb_getUserDevice];
    if ([device.deviceId bb_isSafe]) {
        //已经绑定
        self.leftLB.text = [[device.deviceName bb_safe] stringByAppendingString:@"小雅智能"];
        [self.rightBT setTitle:@"解除绑定" forState:UIControlStateNormal];
        self.rightBT.frame = CGRectMake(_k_w-90-10, 16, 84, 26);
    }else{
        self.leftLB.text = @"您还尚未绑定婴儿床";
        [self.rightBT setTitle:@"去绑定" forState:UIControlStateNormal];
        self.rightBT.frame = CGRectMake(_k_w-80-10, 16, 74, 26);

    }
}
@end
