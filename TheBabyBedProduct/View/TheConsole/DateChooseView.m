//
//  DateChooseView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/23.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "DateChooseView.h"


static double interval = 86400;

@implementation DateChooseView


+(instancetype)initFrame:(CGRect)frame mainColor:(UIColor *)color{
    DateChooseView * dateView = [[DateChooseView alloc]initWithFrame:frame];
    dateView.dateDisplayLabel.textColor = color;
    return dateView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
        [self setDate];
    }
    return self;
}

-(void)configureView{
    
    _dateDisplayLabel = [[UILabel alloc]init];
    _dateDisplayLabel.textColor = [UIColor blackColor];
    _dateDisplayLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_dateDisplayLabel];
    [_dateDisplayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.backgroundColor = [UIColor redColor];
    [_leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_leftButton];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dateDisplayLabel.mas_left).with.offset(-5);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];
    
    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.backgroundColor = [UIColor redColor];
    [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_rightButton];
    
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateDisplayLabel.mas_right).with.offset(5);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@60);
        make.height.equalTo(@20);
    }];

}

-(void)leftButtonClick:(id)sender{
    _dispalyInterval -= interval;
    _dateDisplayLabel.text = [GlobalTool timestampToTime:_dispalyInterval];
    if (self.chooseDateBlock) {
        self.chooseDateBlock(_dispalyInterval);
    }
}
-(void)rightButtonClick:(id)sender{
    _dispalyInterval += interval;
    _dateDisplayLabel.text = [GlobalTool timestampToTime:_dispalyInterval];
    if (self.chooseDateBlock) {
        self.chooseDateBlock(_dispalyInterval);
    }
}

-(void)setDate{
    
    _dateDisplayLabel.text = [GlobalTool getNowTime];
    _dispalyInterval = [GlobalTool timeToTimestamp:[GlobalTool getNowTime]];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
