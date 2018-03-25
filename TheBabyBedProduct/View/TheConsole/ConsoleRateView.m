//
//  ConsoleRateView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/24.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ConsoleRateView.h"

#define circleWidth 8.0

@interface ConsoleRateView(){
    
    
}

@property (nonatomic,strong)UIImageView * imageView;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)CAShapeLayer * circleLayer;
@property (nonatomic,strong)CAShapeLayer * progressLayer;

@end

@implementation ConsoleRateView

+(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image circleColor:(UIColor *)color title:(NSString *)title{
    ConsoleRateView * rateView = [[ConsoleRateView alloc]initWithFrame:frame];
    rateView.imageView.image = image;
    rateView.titleLabel.text = title;
    rateView.titleLabel.backgroundColor = color;
    rateView.progressLayer.strokeColor = color.CGColor;

    return rateView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
    }
    return self;
}

-(void)configureView{
    
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width * 0.58, self.frame.size.width * 0.58)];
    _imageView.center = self.center;
    _imageView.layer.cornerRadius = _imageView.frame.size.width / 2;
    _imageView.clipsToBounds = true;
    _imageView.image = _centerImage;
    [self addSubview:_imageView];
    
    
    CGFloat radius = self.frame.size.width * 0.83 / 2;

    //灰色环
    _circleLayer = [CAShapeLayer layer];
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.center.x - radius, self.center.y - radius, radius * 2, radius * 2)];
    _circleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    _circleLayer.lineWidth = circleWidth;
    _circleLayer.fillColor =  [UIColor clearColor].CGColor;
    _circleLayer.lineCap = kCALineCapRound;
    _circleLayer.path = path.CGPath;
    [self.layer addSublayer:self.circleLayer];
    
    //进度环
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.fillColor = [UIColor clearColor].CGColor;
    _progressLayer.strokeColor = [UIColor blueColor].CGColor;
    _progressLayer.lineWidth = circleWidth;
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.path = path.CGPath;
    [self.layer addSublayer:self.progressLayer];
    
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    _titleLabel.center = CGPointMake(self.center.x + radius , self.center.y);
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.layer.cornerRadius = _titleLabel.frame.size.height / 2;
    _titleLabel.clipsToBounds = true;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    
    self.transform = CGAffineTransformMakeRotation(M_PI_2);
    self.imageView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.titleLabel.transform = CGAffineTransformMakeRotation(-M_PI_2);
}

-(void)updateProgressWithNumber:(CGFloat)num{
    [CATransaction begin];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:0.5];
    self.progressLayer.strokeEnd =  num / 100;
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
