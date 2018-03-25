//
//  ConsoleHeaderView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/23.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ConsoleHeaderView.h"

@implementation ConsoleHeaderView

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
