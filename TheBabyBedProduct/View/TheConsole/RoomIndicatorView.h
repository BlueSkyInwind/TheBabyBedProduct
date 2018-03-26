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


@property (nonatomic,copy)RoomTemperatureCurveClick roomTemperatureCurveClick;
@property (nonatomic,copy)OutdoorTemperatureCurveClick outdoorTemperatureCurveClick;

@end
