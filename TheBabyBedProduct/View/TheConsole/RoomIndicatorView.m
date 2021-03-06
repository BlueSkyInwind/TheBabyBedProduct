//
//  RoomIndicatorView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "RoomIndicatorView.h"

@implementation RoomIndicatorView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    UITapGestureRecognizer * roomTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(roomTemperatureCurveViewTap)];
    [self.roomTemperatureCurveView addGestureRecognizer:roomTap];
    
    UITapGestureRecognizer * outdoorTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(outdoorTemperatureCurveViewTap)];
    [self.outdoorTemperatureCurveView addGestureRecognizer:outdoorTap];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self layoutIfNeeded];
    [self configureView];
}

-(void)roomTemperatureCurveViewTap{
    if (self.roomTemperatureCurveClick) {
        self.roomTemperatureCurveClick();
    }
}

-(void)outdoorTemperatureCurveViewTap{
    if (self.outdoorTemperatureCurveClick) {
        self.outdoorTemperatureCurveClick();
    }
}

-(void)configureView{
    

    
    CAShapeLayer * inDoorLayer = [CAShapeLayer layer];
    inDoorLayer.name = @"inDoorradius";
    UIBezierPath * inDoorPath = [UIBezierPath bezierPath];
    CGPoint center = CGPointMake(self.indoorImageView.bounds.size.width / 2, self.indoorImageView.bounds.size.height / 2);
    CGFloat radius = self.indoorImageView.bounds.size.width / 2 * 0.68;
    CGFloat startAngle = M_PI_4 * 3; //
    CGFloat endAngle = M_PI_4;
    [inDoorPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:true];
    [inDoorPath stroke];
    inDoorLayer.lineWidth = 8;
    inDoorLayer.strokeColor = rgb(173, 229, 69, 1).CGColor;
    inDoorLayer.fillColor =  [UIColor clearColor].CGColor;
    inDoorLayer.lineCap = kCGLineCapButt;
    inDoorLayer.path = inDoorPath.CGPath;
    [self.indoorImageView.layer addSublayer:inDoorLayer];
    
    CAShapeLayer * outDoorLayer = [CAShapeLayer layer];
    outDoorLayer.name = @"outDoorradius";
    UIBezierPath * outDoorPath = [UIBezierPath bezierPath];
    CGPoint center2 = CGPointMake(self.outDoorImageView.bounds.size.width / 2, self.outDoorImageView.bounds.size.height / 2);
    CGFloat radius2 = self.outDoorImageView.bounds.size.width / 2 * 0.68;
    CGFloat startAngle2 = M_PI_4 * 3; //
    CGFloat endAngle2 = M_PI_4;
    [outDoorPath addArcWithCenter:center2 radius:radius2 startAngle:startAngle2 endAngle:endAngle2 clockwise:true];
    [outDoorPath stroke];
    outDoorLayer.lineWidth = 8;
    outDoorLayer.strokeColor = rgb(69, 207, 229, 1).CGColor;
    outDoorLayer.fillColor =  [UIColor clearColor].CGColor;
    outDoorLayer.lineCap = kCGLineCapButt;
    outDoorLayer.path = outDoorPath.CGPath;
    [self.outDoorImageView.layer addSublayer:outDoorLayer];
    
    _inDoorIndcatorLayer = [CAShapeLayer layer];
    _inDoorIndcatorLayer.name = @"indicator";
    CGPoint startPoint = CGPointMake(self.indoorImageView.bounds.size.width / 2, self.indoorImageView.bounds.size.height / 2);
    CGFloat indcatorRadius = self.indoorImageView.bounds.size.width / 2 * 0.66;
    _inDoorIndcatorLayer.frame = CGRectMake(startPoint.x - indcatorRadius, startPoint.y - 1.5, indcatorRadius, 3);
    
    CAShapeLayer * layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(0, 0, indcatorRadius / 3, 3);
    layer.backgroundColor = rgb(109, 109, 109, 1).CGColor;
    [_inDoorIndcatorLayer addSublayer:layer];
    
    _inDoorIndcatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    _inDoorIndcatorLayer.transform = CATransform3DMakeRotation(-M_PI_4 , 0, 0, 1);
    _inDoorIndcatorLayer.lineCap = kCGLineCapButt;
    [self.indoorImageView.layer addSublayer:_inDoorIndcatorLayer];
    _inDoorIndcatorLayer.anchorPoint = CGPointMake(1, 1);
    _inDoorIndcatorLayer.position = CGPointMake(self.indoorImageView.bounds.size.width / 2, self.indoorImageView.bounds.size.height / 2);
    
    _outDoorIndcatorLayer = [CAShapeLayer layer];
    _outDoorIndcatorLayer.name = @"indicator";
    CGPoint startPoint1 = CGPointMake(self.outDoorImageView.bounds.size.width / 2, self.outDoorImageView.bounds.size.height / 2);
    CGFloat indcatorRadius1 = self.outDoorImageView.bounds.size.width / 2 * 0.66;
    _outDoorIndcatorLayer.frame = CGRectMake(startPoint1.x - indcatorRadius1, startPoint1.y - 1.5, indcatorRadius, 3);
    
    CAShapeLayer * layer1 = [CAShapeLayer layer];
    layer1.frame = CGRectMake(0, 0, indcatorRadius1 / 3, 3);
    layer1.backgroundColor = rgb(109, 109, 109, 1).CGColor;
    [_outDoorIndcatorLayer addSublayer:layer1];
    
    _outDoorIndcatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    _outDoorIndcatorLayer.transform = CATransform3DMakeRotation(-M_PI_4 , 0, 0, 1);
    _outDoorIndcatorLayer.lineCap = kCGLineCapButt;
    [self.outDoorImageView.layer addSublayer:_outDoorIndcatorLayer];
    _outDoorIndcatorLayer.anchorPoint = CGPointMake(1, 1);
    _outDoorIndcatorLayer.position = CGPointMake(self.outDoorImageView.bounds.size.width / 2, self.outDoorImageView.bounds.size.height / 2);
    
    _inDoorLabel = [[UILabel alloc]init];
    _inDoorLabel.text = @"0.0°";
    _inDoorLabel.font = [UIFont systemFontOfSize:12];
    _inDoorLabel.textAlignment = NSTextAlignmentCenter;
//    _inDoorLabel.center = CGPointMake(self.indoorImageView.bounds.size.width / 2, self.indoorImageView.bounds.size.height / 2);
    [self.indoorImageView addSubview:_inDoorLabel];
    [_inDoorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.indoorImageView.mas_centerX);
        make.centerY.equalTo(self.indoorImageView.mas_centerY);
    }];
    
    _outDoorLabel = [[UILabel alloc]init];
    _outDoorLabel.text = @"0.0°";
    _outDoorLabel.font = [UIFont systemFontOfSize:12];
    _outDoorLabel.textAlignment = NSTextAlignmentCenter;
//    _outDoorLabel.center = CGPointMake(self.outDoorImageView.bounds.size.width / 2, self.outDoorImageView.bounds.size.height / 2);
    [self.outDoorImageView addSubview:_outDoorLabel];
    [_outDoorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.outDoorImageView.mas_centerX);
        make.centerY.equalTo(self.outDoorImageView.mas_centerY);
    }];
}

-(void)setInDoorIndcatorScale:(CGFloat)value{
    
    CGFloat number = value >= 35 ?  35 : value;
    self.roomTemperatureNumLabel.text = [NSString stringWithFormat:@"%.0f°C",number];
    self.inDoorLabel.text = [NSString stringWithFormat:@"%.0f°",number];
    CGFloat scale = number / 50;
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 0.25;
    animation.toValue = @(scale * 6 * M_PI_4);
    animation.removedOnCompletion = false;
    animation.fillMode = kCAFillModeForwards;
    [_inDoorIndcatorLayer addAnimation:animation forKey:@"transform.rotation.z"];
    
}

-(void)setOutDoorIndcatorScale:(CGFloat)value{
    
    CGFloat number = value >= 35 ?  35 : value;
    self.outdoortemperatureNumLabel.text = [NSString stringWithFormat:@"%.0f°C",number];
    self.outDoorLabel.text = [NSString stringWithFormat:@"%.0f°",number];
    CGFloat scale = number / 50;
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.duration = 0.25;
    animation.toValue = @(scale * 6 * M_PI_4);
    animation.removedOnCompletion = false;
    animation.fillMode = kCAFillModeForwards;
    [_outDoorIndcatorLayer addAnimation:animation forKey:@"transform.rotation.z"];
    
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    


}


@end
