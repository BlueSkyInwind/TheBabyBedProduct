//
//  ThermometerView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ThermometerView.h"

@implementation ThermometerView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self configureView];
}

-(void)configureView{
    
    //灰色环
//    CAShapeLayer * fillLayer = [CAShapeLayer layer];
//    UIBezierPath * path = [UIBezierPath bezierPath];
//    
//    fillLayer.strokeColor = [UIColor lightGrayColor].CGColor;
//    fillLayer.lineWidth = 15;
//    fillLayer.fillColor =  [UIColor clearColor].CGColor;
//    fillLayer.lineCap = kCALineCapRound;
//    fillLayer.path = path.CGPath;
//    [self.layer addSublayer:fillLayer];
    
    _alarTemImageView = [[UIImageView alloc]init];
    _alarTemImageView.image = [UIImage imageNamed:@"bobyThermometer_left_Icon"];
    [_alarThermometerView addSubview:_alarTemImageView];
    [_alarTemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_alarThermometerView);
    }];
    
    _foreheadTemImageView = [[UIImageView alloc]init];
    _foreheadTemImageView.image = [UIImage imageNamed:@"bobyThermometer_right_Icon"];
    [_foreheadThermometerView addSubview:_foreheadTemImageView];
    [_foreheadTemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_foreheadThermometerView);
    }];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushHistoryCruveClick)];
    [self.historyView addGestureRecognizer:tap];
    

}

- (IBAction)switchBtnClick:(id)sender {
    UIButton * button = sender;
    button.selected = !button.selected;
    
}
-(void)pushHistoryCruveClick{
    if (self.historyChartClick) {
        self.historyChartClick();
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
