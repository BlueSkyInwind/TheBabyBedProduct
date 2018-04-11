//
//  CryingChartView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "CryingChartView.h"
#import "PointItem.h"
#import "PXYview.h"

@interface CryingChartView()<PXLineChartViewDelegate>{
    
    NSArray * xArr;
    NSArray * yArr;
    
}
@property (nonatomic,strong)PXLineChartView * lineChartView;
@property (nonatomic,strong)DateChooseView * dateChooseView;
@property (nonatomic, strong) NSArray *lines;//line count

@end
@implementation CryingChartView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
    }
    return self;
}

-(void)configureView{
    
    _dateChooseView = [DateChooseView initFrame:CGRectMake(0, 0, _k_w, 47) mainColor:rgb(255, 108, 140, 1) leftImage:@"cryingChooseDate_left_Icon" rightImage:@"cryingChooseDate_right_Icon"];
    [self addSubview:_dateChooseView];
    _dateChooseView.chooseDateBlock = ^(NSTimeInterval chooseInterval) {
        //选择日期的时间戳
        
    };
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 47, _k_w, 326)];
    [self addSubview:backView];
    
    //添加上下分割线
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 1)];
    topView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [backView addSubview:topView];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, backView.frame.size.height - 1, _k_w, 1)];
    bottomView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [backView addSubview:bottomView];
    
    _lineChartView = [[PXLineChartView alloc]initWithFrame:CGRectMake(-10, 1, self.frame.size.width - 10, 310)];
    [backView addSubview:_lineChartView];

    _lineChartView.delegate = self;
    xArr = [NSArray arrayWithObjects:@"1:00",@"2:00",@"3:00",@"4:00",@"5:00",@"6:00",@"7:00",@"8:00",@"9:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00",@"24:00", nil];
    yArr = [NSArray arrayWithObjects:@"0",@"5",@"10",@"15",@"20",@"25",@"30",@"35", nil];
    self.lines = [self lines:true];

}

- (NSArray *)lines:(BOOL)fill {
    
    NSArray *pointsArr = @[                           @{@"xValue" : @"1:00", @"yValue" : @"34"},
                                                      @{@"xValue" : @"2:00", @"yValue" : @"33"},
                                                      @{@"xValue" : @"3:00", @"yValue" : @"34.5"},
                                                      @{@"xValue" : @"5:00", @"yValue" : @"32"},
                                                      @{@"xValue" : @"6:00", @"yValue" : @"33"}];
    
    NSArray *pointsArr1 = @[
                            @{@"xValue" : @"12:00", @"yValue" : @"31"},
                            @{@"xValue" : @"13:00", @"yValue" : @"32"},
                            @{@"xValue" : @"14:00", @"yValue" : @"33.6"}];
    
    NSMutableArray *points = @[].mutableCopy;
    for (int i = 0; i < pointsArr.count; i++) {
        PointItem *item = [[PointItem alloc] init];
        NSDictionary *itemDic = pointsArr[i];
        item.price = itemDic[@"yValue"];
        item.time = itemDic[@"xValue"];
        item.chartLineColor = rgb(255, 108, 140, 1);
        item.chartPointColor = rgb(255, 108, 140, 1);
        item.pointValueColor = rgb(255, 108, 140, 1);;
        item.chartFillColor = rgb(255, 108, 140, 0.45);
        item.chartFill = YES;
        [points addObject:item];
    }
    
    NSMutableArray *pointss = @[].mutableCopy;
    for (int i = 0; i < pointsArr1.count; i++) {
        PointItem *item = [[PointItem alloc] init];
        NSDictionary *itemDic = pointsArr1[i];
        item.price = itemDic[@"yValue"];
        item.time = itemDic[@"xValue"];
        item.chartLineColor = rgb(255, 108, 140, 1);
        item.chartPointColor = rgb(255, 108, 140, 1);
        item.pointValueColor = rgb(255, 108, 140, 1);
        item.chartFillColor = rgb(255, 108, 140, 0.45);
        item.chartFill = YES;
        [pointss addObject:item];
    }
    //两条line
    return @[pointss,points];
}

#pragma mark PXLineChartViewDelegate
//通用设置
- (NSDictionary<NSString*, id> *)lineChartViewAxisAttributes {
    return @{yElementInterval : @"35",
             xElementInterval : @"40",
             yMargin : @"50",
             xMargin : @"25",
             yElementsUnit : @"度",
             yAxisdisplaystyle: @"1",
             xElementsUnit : @"时间",
             yElementMax: @"40",
             yElementMaxPointColor: [UIColor redColor],
             yAxisColor : [UIColor colorWithRed:178.0/255 green:178.0/255 blue:178.0/255 alpha:1],
             xAxisColor : [UIColor clearColor],
             gridColor : [UIColor colorWithRed:178.0/255 green:178.0/255 blue:178.0/255 alpha:1],
             gridHide : @0,
             pointHide : @0,
             pointFont : [UIFont systemFontOfSize:10],
             firstYAsOrigin : @1,
             scrollAnimation : @1,
             scrollAnimationDuration : @"2"};
}

//line count
- (NSUInteger)numberOfChartlines {
    return self.lines.count;
    //    return 0;
}
//x轴y轴对应的元素count
- (NSUInteger)numberOfElementsCountWithAxisType:(AxisType)axisType {
    return (axisType == AxisTypeY)? yArr.count : xArr.count;
}
//x轴y轴对应的元素view
- (UILabel *)elementWithAxisType:(AxisType)axisType index:(NSUInteger)index {
    UILabel *label = [[UILabel alloc] init];
    NSString *axisValue = @"";
    if (axisType == AxisTypeX) {
        axisValue = xArr[index];
        label.textAlignment = NSTextAlignmentCenter;//;
    }else if(axisType == AxisTypeY){
        axisValue = yArr[index];
        label.textAlignment = NSTextAlignmentRight;//;
    }
    label.text = axisValue;
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor blackColor];
    return label;
}
//每条line对应的point数组
- (NSArray<id<PointItemProtocol>> *)plotsOflineIndex:(NSUInteger)lineIndex {
    return self.lines[lineIndex];
}
//点击point回调响应
- (void)elementDidClickedWithPointSuperIndex:(NSUInteger)superidnex pointSubIndex:(NSUInteger)subindex {
    PointItem *item = self.lines[superidnex][subindex];
    NSString *xTitle = item.time;
    NSString *yTitle = item.price;
    
    NSLog(@"%@",[NSString stringWithFormat:@"x：%@ \ny：%@",xTitle,yTitle]);
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
