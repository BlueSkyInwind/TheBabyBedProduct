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


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
