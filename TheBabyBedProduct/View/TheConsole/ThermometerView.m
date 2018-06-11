//
//  ThermometerView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ThermometerView.h"
@interface ThermometerView () {
    
}
/**<#Description#>*/
@property (nonatomic,strong)CAShapeLayer  * alarTemLayer;
/**<#Description#>*/
@property (nonatomic,strong)CAShapeLayer  * foreheadTemLayer;

@end
@implementation ThermometerView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self configureView];
}

-(void)configureView{
    
    _alarTemLayer = [CAShapeLayer layer];
    _alarTemLayer.name = @"alarTemProgress";
    UIBezierPath * alarTemPath = [UIBezierPath bezierPath];
    CGPoint startPoint = CGPointMake(self.alarThermometerView.bounds.size.width / 2, self.alarThermometerView.bounds.size.height);
    CGPoint endPoint = CGPointMake(self.alarThermometerView.bounds.size.width / 2, 0);
    [alarTemPath moveToPoint:startPoint];
    [alarTemPath addLineToPoint:endPoint];
    [alarTemPath stroke];
    _alarTemLayer.lineWidth = 8;
    _alarTemLayer.strokeColor = rgb(69, 207, 229, 1).CGColor;
    _alarTemLayer.fillColor =  [UIColor clearColor].CGColor;
    _alarTemLayer.lineCap = kCGLineCapButt;
    _alarTemLayer.path = alarTemPath.CGPath;
    [self.alarThermometerView.layer addSublayer:_alarTemLayer];
    
    _foreheadTemLayer = [CAShapeLayer layer];
    _foreheadTemLayer.name = @"alarTemProgress";
    UIBezierPath * foreheadTemPath = [UIBezierPath bezierPath];
    CGPoint startTwoPoint = CGPointMake(self.foreheadThermometerView.bounds.size.width / 2, self.foreheadThermometerView.bounds.size.height);
    CGPoint endTwoPoint = CGPointMake(self.foreheadThermometerView.bounds.size.width / 2, 0);
    [foreheadTemPath moveToPoint:startTwoPoint];
    [foreheadTemPath addLineToPoint:endTwoPoint];
    [foreheadTemPath stroke];
    _foreheadTemLayer.lineWidth = 8;
    _foreheadTemLayer.strokeColor = rgb(69, 207, 229, 1).CGColor;
    _foreheadTemLayer.fillColor =  [UIColor clearColor].CGColor;
    _foreheadTemLayer.lineCap = kCGLineCapButt;
    _foreheadTemLayer.path = foreheadTemPath.CGPath;
    [self.foreheadThermometerView.layer addSublayer:_foreheadTemLayer];
    
//    self.alarThermometerView.backgroundColor = [UIColor redColor];
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

-(void)updateAlarTemProgressWithNumber:(CGFloat)num{
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:0.5];
    self.alarTemLayer.strokeEnd =  num / 100;
    [CATransaction commit];
}

-(void)updateForeheadTemProgressWithNumber:(CGFloat)num{
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:0.5];
    self.foreheadTemLayer.strokeEnd =  num / 100;
    [CATransaction commit];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
