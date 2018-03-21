//
//  TemperatureChartView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "TemperatureChartView.h"


@interface TemperatureChartView()<ChartViewDelegate>

@end

@implementation TemperatureChartView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
    }
    return self;
}

-(void)configureView{
    
    _lineChartView = [[LineChartView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    _lineChartView.delegate = self;
    
    _lineChartView.chartDescription.enabled = NO;
    _lineChartView.dragEnabled = YES;
    [_lineChartView setScaleEnabled:YES];
    _lineChartView.pinchZoomEnabled = YES;
    _lineChartView.drawGridBackgroundEnabled = NO;
    
    _lineChartView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_lineChartView];

    ChartLegend *l = _lineChartView.legend;
    l.form = ChartLegendFormLine;
    l.font = [UIFont systemFontOfSize:12];
    l.textColor = kUIColorFromRGB(0xff9b39);
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    
    //X轴
    ChartXAxis *xAxis = _lineChartView.xAxis;
    xAxis.labelFont = [UIFont systemFontOfSize:11.f];
    xAxis.labelTextColor = kUIColorFromRGB(0xff9b39);
    xAxis.drawGridLinesEnabled = NO;
    xAxis.drawAxisLineEnabled = NO;
    //y轴
    ChartYAxis *leftAxis = _lineChartView.leftAxis;
    leftAxis.labelTextColor = [UIColor blackColor];
    leftAxis.axisMaximum = 40;
    leftAxis.axisMinimum = 0;
    leftAxis.
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.drawZeroLineEnabled = NO;
    leftAxis.granularityEnabled = YES;
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
