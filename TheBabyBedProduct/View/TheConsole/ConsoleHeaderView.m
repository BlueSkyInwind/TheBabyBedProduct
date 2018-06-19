//
//  ConsoleHeaderView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/23.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ConsoleHeaderView.h"

@implementation ConsoleHeaderView

-(void)resetConsoleSettingBtn:(CGFloat)constant{
    self.settingBtnConstraint.constant = constant;
}

- (IBAction)consoleHeaderClick:(id)sender {
    
    
    
}

- (IBAction)settingBtnClick:(id)sender {
    if (self.settingButtonClick) {
        self.settingButtonClick(sender);
    }
}

- (IBAction)backBtnClick:(id)sender {
    if (self.backButtonClick) {
        self.backButtonClick(sender);
    }
}

-(void)awakeFromNib{
    [super awakeFromNib];
    BBUser *user = [BBUser bb_getUser];
    if (user.both && [user.both integerValue] > 0) {
        self.consoleHeaderLabel.text = [user.both bb_timeIntervalFromTimestamp];
        self.consoleHeaderLabel.hidden = NO;
    }else{
        self.consoleHeaderLabel.hidden = YES;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
