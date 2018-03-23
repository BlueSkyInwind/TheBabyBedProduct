//
//  ConsoleBodyView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/23.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ConsoleBodyView.h"

@implementation ConsoleBodyView

- (IBAction)bobyTemperatureClick:(id)sender {
    if (_bobyTemperatureBtnClick) {
        _bobyTemperatureBtnClick(sender);
    }
}

- (IBAction)roomTemperatureClick:(id)sender {
    if (_roomTemperatureBtnClick) {
        _roomTemperatureBtnClick(sender);
    }
}


- (IBAction)cryingClick:(id)sender {
    if (_cryingBtnClick) {
        _cryingBtnClick(sender);
    }
}

- (IBAction)wettingCilck:(id)sender {
    if (_wettingBtnClick) {
        _wettingBtnClick(sender);
    }
}
- (IBAction)qulitClick:(id)sender {
    if (_qulitBtnClick) {
        _qulitBtnClick(sender);
    }
}
- (IBAction)videoClick:(id)sender {
    if (_videoBtnClick) {
        _videoBtnClick(sender);
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
