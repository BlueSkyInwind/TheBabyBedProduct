//
//  TemperatureChartView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "TemperatureChartView.h"
#import "DateValueFormatter.h"

@interface TemperatureChartView()<ChartViewDelegate,IChartAxisValueFormatter>{
    NSArray * xArr;
    NSArray * yArr;
}

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
    
    xArr = [NSArray arrayWithObjects:@"1:00",@"2:00",@"3:00",@"4:00",@"5:00",@"6:00",@"7:00",@"8:00",@"9:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00", nil];
    yArr = [NSArray arrayWithObjects:@"35",@"37",@"39.8",@"37.6",@"37.9",@"38.9",@"38.5",@"38.6",@"38.9",@"37",@"38.6",@"39",@"40",@"38.9",@"34", nil];
    
    _lineChartView = [[LineChartView alloc]initWithFrame:CGRectMake(0, 15, self.bounds.size.width, self.bounds.size.height - 20)];
    _lineChartView.delegate = self;
    _lineChartView.chartDescription.enabled = NO;
    _lineChartView.dragEnabled = YES;
    [_lineChartView setScaleEnabled:YES];
    _lineChartView.pinchZoomEnabled = YES;
    _lineChartView.drawGridBackgroundEnabled = NO;
    _lineChartView.backgroundColor = [UIColor whiteColor];
    _lineChartView.scaleYEnabled = false;
    //设置x,y轴的最小缩放值
    [_lineChartView setScaleMinima:2 scaleY:1];
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
    DateValueFormatter * formatter = [[DateValueFormatter alloc] init];
    formatter.xAxisDatas = xArr;
    xAxis.valueFormatter = formatter;
    xAxis.granularity = xAxis.axisMaximum / xArr.count;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:11.f];
    xAxis.labelTextColor = kUIColorFromRGB(0xff9b39);
    xAxis.drawGridLinesEnabled = NO;
    xAxis.drawAxisLineEnabled = NO;

    //y轴
    ChartYAxis *leftAxis = _lineChartView.leftAxis;
    leftAxis.labelTextColor = [UIColor blackColor];
//    leftAxis.axisLineColor = [UIColor clearColor];
    leftAxis.axisLineDashPhase = 10.0;
    leftAxis.labelCount = 5;
    leftAxis.forceLabelsEnabled = true;
    leftAxis.axisMaximum = 40;
    leftAxis.axisMinimum = 34;
    leftAxis.drawGridLinesEnabled = YES;
    leftAxis.drawZeroLineEnabled = NO;
    leftAxis.granularityEnabled = NO;
    leftAxis.drawBottomYLabelEntryEnabled = false;
    _lineChartView.rightAxis.enabled = NO;
    [self setChartData:xArr values:yArr];
}

-(void)setChartData:(NSArray *)dataPoints values:(NSArray *)arr{
    
    NSMutableArray * dataArr  = [NSMutableArray array];
    for (int i = 0;i< dataPoints.count;i++) {
        ChartDataEntry * dataEntry = [[ChartDataEntry alloc]initWithX:i y:[arr[i] doubleValue]];
        [dataArr addObject:dataEntry];
    }
    LineChartDataSet * set = [[LineChartDataSet alloc]initWithValues:dataArr label:@"温度曲线"];
    set.drawIconsEnabled = NO;
    [set setColor:UIColor.blackColor];
    [set setCircleColor:UIColor.blackColor];
    set.lineWidth = 1.0;
    set.circleRadius = 3.0;
    
    //曲线填充色
    NSArray *gradientColors = @[
                                (id)kUIColorFromRGB(0xFF9B39).CGColor,
                                (id)kUIColorFromRGB(0xFF9B39).CGColor
                                ];
    CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
    
    set.fillAlpha = .45f;
    set.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
    set.drawFilledEnabled = YES;
    CGGradientRelease(gradient);
    LineChartData *data = [[LineChartData alloc] initWithDataSet:set];
    _lineChartView.data = data;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
//    [@"度" drawInRect:CGRectMake(0, 2, 10, 10) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10.0],NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName, nil]];
//    [@"时间" drawInRect:CGRectMake(rect.size.width - 20, rect.size.height - 10, 20, 10) withAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10.0],NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName, nil]];
}

@end
