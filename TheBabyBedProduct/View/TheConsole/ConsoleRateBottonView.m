//
//  ConsoleRateBottonView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/24.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ConsoleRateBottonView.h"

@implementation ConsoleRateBottonView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
    }
    return  self;
}

-(void)configureView{
    
    _historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _historyButton.backgroundColor = [UIColor whiteColor];
    [_historyButton addTarget:self action:@selector(hisStoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_historyButton];
    [_historyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _explainLabel = [[UILabel alloc]init];
    _explainLabel.text = @"历史曲线";
    _explainLabel.textColor = [UIColor blackColor];
    _explainLabel.font = [UIFont systemFontOfSize:16];
    [_historyButton addSubview:_explainLabel];
    [_explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_historyButton.mas_centerY);
        make.left.equalTo(_historyButton.mas_left).offset(2);
    }];
    
    _displayIcon = [[UIImageView alloc]init];
//    _displayIcon.image =
    _displayIcon.backgroundColor = [UIColor redColor];
    [_historyButton addSubview:_displayIcon];
    [_displayIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_historyButton.mas_centerY);
        make.right.equalTo(_historyButton.mas_right).with.offset(0);
        make.height.width.equalTo(@23);
    }];
    
}

-(void)hisStoryButtonClick:(id)sender{
    
    if (self.historyBtnClick) {
        self.historyBtnClick(sender);
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
