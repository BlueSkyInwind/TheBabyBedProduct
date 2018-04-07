//
//  DeviceConnectAnimationView.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "DeviceConnectAnimationView.h"

static const CGFloat kAnimationDuration = 0.9;
static const CGFloat kCircleContainerSize = 200;
static const NSInteger kCircleCount = 8;
static const CGFloat kCircleSize = 48;


@implementation DeviceConnectAnimationView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configurevView];
    }
    return self;
}


-(void)configurevView{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    _containerLayer2 = [CAReplicatorLayer layer];
    _containerLayer2.frame = CGRectMake(CGFloatGetCenter(CGRectGetWidth(self.bounds), kCircleContainerSize), 117, kCircleContainerSize, kCircleContainerSize);
    
    _containerLayer2.masksToBounds = YES;
    _containerLayer2.instanceCount = kCircleCount;
    _containerLayer2.instanceDelay = kAnimationDuration / _containerLayer2.instanceCount;
    _containerLayer2.instanceTransform = CATransform3DMakeRotation(AngleWithDegrees(360 / _containerLayer2.instanceCount), 0, 0, 1);
    [self.layer addSublayer:_containerLayer2];
    
    UILabel * connectStatus = [[UILabel alloc]initWithFrame:CGRectMake(0, 337, _k_w, 20)];
    connectStatus.text = @"设备连接中";
    connectStatus.font = [UIFont systemFontOfSize:16];
    connectStatus.textAlignment = NSTextAlignmentCenter;
    [self addSubview:connectStatus];
  
    UILabel * explainStatus = [[UILabel alloc]initWithFrame:CGRectMake(0, 367, _k_w, 30)];
    explainStatus.text = @"绑定设置可能需要几分钟，请耐心等待";
    explainStatus.textColor = rgb(102, 102, 102, 1);
    explainStatus.font = [UIFont systemFontOfSize:14];
    explainStatus.textAlignment = NSTextAlignmentCenter;
    [self addSubview:explainStatus];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]  removeObserver:self];
}

- (void)handleWillEnterForeground:(NSNotification *)notification {
    [self beginAnimation];
}

- (void)beginAnimation {
    
    
    CALayer *subLayer2 = [CALayer layer];
    subLayer2.backgroundColor = rgb(255, 155, 57, 1).CGColor;
    subLayer2.frame = CGRectMake((kCircleContainerSize - kCircleSize) / 2, 0, kCircleSize, kCircleSize);
    subLayer2.cornerRadius = kCircleSize / 2;
    subLayer2.transform = CATransform3DMakeScale(0, 0, 0);
    [_containerLayer2 addSublayer:subLayer2];
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation2.fromValue = @(1);
    animation2.toValue = @(0.1);
    animation2.repeatCount = HUGE;
    animation2.duration = kAnimationDuration;
    [subLayer2 addAnimation:animation2 forKey:nil];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
