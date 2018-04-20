//
//  AddDeviceView.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/4/3.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "AddDeviceView.h"

@implementation AddDeviceView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
    }
    return self;
}

-(void)addBtnClick:(id)sender{
    
    if (self.addDeviceClick) {
        self.addDeviceClick();
    }
}

-(void)configureView{
    self.backgroundColor = rgb(247, 249, 251, 1);
    
    CGFloat addViewHeight = 60;
    if (UI_IS_IPHONE6P) {
        addViewHeight = 80;
    }
    UIView * addview =  [[UIView alloc]init];
    addview.backgroundColor = [UIColor clearColor];
    [self addSubview:addview];
    [addview mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_top).with.offset(130);
        make.width.height.equalTo(@(addViewHeight));
    }];
    
    _addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addbutton setBackgroundImage:[UIImage imageNamed:@"addDevice_Icon"] forState:UIControlStateNormal];
    [_addbutton addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [addview addSubview:_addbutton];
    [_addbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(addview.mas_centerX);
        make.top.equalTo(addview.mas_top).offset(5);
        make.width.equalTo(@(addViewHeight / 2));
        make.height.equalTo(@(addViewHeight / 2));
    }];
    
    UILabel * displayLabel = [[UILabel alloc]init];
    displayLabel.text = @"添加设备";
    displayLabel.textAlignment = NSTextAlignmentCenter;
    displayLabel.font = [UIFont systemFontOfSize:16];
    [addview addSubview:displayLabel];
    [displayLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(addview.mas_bottom).with.offset(3);
        make.centerX.equalTo(addview.mas_centerX);
    }];
    
    UILabel * explainLabel = [[UILabel alloc]init];
    explainLabel.text = @"链接设备见覅额就覅偶金额将发尾佛安慰放假";
    explainLabel.textAlignment = NSTextAlignmentCenter;
    explainLabel.font = [UIFont systemFontOfSize:15];
    explainLabel.numberOfLines = 0;
    [self addSubview:explainLabel];
    [explainLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(addview.mas_bottom).with.offset(92);
        make.left.equalTo(self.mas_left).with.offset(20);
        make.right.equalTo(self.mas_right).with.offset(-20);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
