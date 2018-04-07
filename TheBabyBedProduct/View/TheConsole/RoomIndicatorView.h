//
//  RoomIndicatorView.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^RoomTemperatureCurveClick)();
typedef void (^OutdoorTemperatureCurveClick)();

@interface RoomIndicatorView : UIView

@property (weak, nonatomic) IBOutlet UILabel *roomTemperatureNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *outdoortemperatureNumLabel;

@property (weak, nonatomic) IBOutlet UIView *roomIndicatorView;

@property (weak, nonatomic) IBOutlet UIView *outdoorIndicatorView;

@property (weak, nonatomic) IBOutlet UIView *roomTemperatureCurveView;
@property (weak, nonatomic) IBOutlet UIView *outdoorTemperatureCurveView;
@property (weak, nonatomic) IBOutlet UIImageView *indoorImageView;

@property (weak, nonatomic) IBOutlet UIImageView *outDoorImageView;

/* 室内温度显示*/
@property(nonatomic,strong)UILabel * inDoorLabel;

/* 室内温度显示*/
@property(nonatomic,strong)UILabel * outDoorLabel;

/* <#Description#>*/
@property(nonatomic,strong)CAShapeLayer * inDoorIndcatorLayer;

/* <#Description#>*/
@property(nonatomic,strong)CAShapeLayer * outDoorIndcatorLayer;

@property (nonatomic,copy)RoomTemperatureCurveClick roomTemperatureCurveClick;
@property (nonatomic,copy)OutdoorTemperatureCurveClick outdoorTemperatureCurveClick;


-(void)setInDoorIndcatorScale:(CGFloat)value;
-(void)setOutDoorIndcatorScale:(CGFloat)value;


@end

