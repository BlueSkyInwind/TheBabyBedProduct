//
//  WettingChartView.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "WettingChartView.h"
#import "PointItem.h"

@interface WettingChartView()<PXLineChartViewDelegate>{
    NSArray * xArr;
    NSArray * yArr;
    
    UIView * lineBackView;
}
@property (nonatomic,strong)PXLineChartView * lineChartView;
@property (nonatomic,strong)DateChooseView * dateChooseView;
@property (nonatomic, strong) NSArray *lines;//line count

@property (nonatomic,strong)UIButton * minutesButton;
@property (nonatomic,strong)UIButton * hourButton;

@end

@implementation WettingChartView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
    }
    return self;
}

-(void)configureView{
    
    _dateChooseView = [DateChooseView initFrame:CGRectMake(0, 0, _k_w, 47) mainColor:rgb(72, 189, 255, 1)];
    [self addSubview:_dateChooseView];
    _dateChooseView.chooseDateBlock = ^(NSTimeInterval chooseInterval) {
        //选择日期的时间戳
        
    };
    
    lineBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 47, _k_w, 326)];
    [self addSubview:lineBackView];
    
    //添加上下分割线
    UIView * topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 1)];
    topView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [lineBackView addSubview:topView];
    
    UIView * bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, lineBackView.frame.size.height - 1, _k_w, 1)];
    bottomView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [lineBackView addSubview:bottomView];
    
    //注释
    UILabel * explainLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 1, _k_w, 30)];
    explainLabel.text = @"0代表:正常  1代表:轻微  2代表:中度  3代表:严重";
    explainLabel.textColor = [UIColor blackColor];
    explainLabel.font = [UIFont yx_systemFontOfSize:13];
    explainLabel.textAlignment = NSTextAlignmentCenter;
    [lineBackView addSubview:explainLabel];
    
    
    _lineChartView = [[PXLineChartView alloc]initWithFrame:CGRectMake(-10, 40, self.frame.size.width - 10, 260)];
    [lineBackView addSubview:_lineChartView];
    _lineChartView.delegate = self;
    xArr = [NSArray arrayWithObjects:@"1:00",@"2:00",@"3:00",@"4:00",@"5:00",@"6:00",@"7:00",@"8:00",@"9:00",@"10:00",@"11:00",@"12:00",@"13:00",@"14:00",@"15:00",@"16:00",@"17:00",@"18:00",@"19:00",@"20:00",@"21:00",@"22:00",@"23:00",@"24:00", nil];
    yArr = [NSArray arrayWithObjects:@"0",@"1",@"2",@"3", nil];
    self.lines = [self lines:true];
    
    //增加模式选择
    [self addChooseModelView];
}

- (NSArray *)lines:(BOOL)fill {
    NSArray *pointsArr = @[                           @{@"xValue" : @"1:00", @"yValue" : @"0"},
                                                      @{@"xValue" : @"2:00", @"yValue" : @"0"},
                                                      @{@"xValue" : @"3:00", @"yValue" : @"2"},
                                                      @{@"xValue" : @"5:00", @"yValue" : @"3"},
                                                      @{@"xValue" : @"6:00", @"yValue" : @"0"}];
    
    NSArray *pointsArr1 = @[
                            @{@"xValue" : @"12:00", @"yValue" : @"0"},
                            @{@"xValue" : @"13:00", @"yValue" : @"0"},
                            @{@"xValue" : @"14:00", @"yValue" : @"3"}];
    
    NSMutableArray *points = @[].mutableCopy;
    for (int i = 0; i < pointsArr.count; i++) {
        PointItem *item = [[PointItem alloc] init];
        NSDictionary *itemDic = pointsArr[i];
        item.price = itemDic[@"yValue"];
        item.time = itemDic[@"xValue"];
        item.chartLineColor = rgb(72, 189, 255, 1);
        item.chartPointColor = rgb(72, 189, 255, 1);
        item.pointValueColor = rgb(72, 189, 255, 1);
        item.chartFillColor = rgb(72, 189, 255, 0.45);
        item.chartFill = YES;
        
        [points addObject:item];
    }
    
    NSMutableArray *pointss = @[].mutableCopy;
    for (int i = 0; i < pointsArr1.count; i++) {
        PointItem *item = [[PointItem alloc] init];
        NSDictionary *itemDic = pointsArr1[i];
        item.price = itemDic[@"yValue"];
        item.time = itemDic[@"xValue"];
        item.chartLineColor = rgb(72, 189, 255, 1);
        item.chartPointColor = rgb(72, 189, 255, 1);
        item.pointValueColor = rgb(72, 189, 255, 1);
        item.chartFillColor = rgb(72, 189, 255, 0.45);
        item.chartFill = YES;
        [pointss addObject:item];
    }
    //两条line
    return @[pointss,points];
}

#pragma mark PXLineChartViewDelegate
//通用设置
- (NSDictionary<NSString*, id> *)lineChartViewAxisAttributes {
    return @{yElementInterval : @"68",
             xElementInterval : @"40",
             yMargin : @"50",
             xMargin : @"25",
             xElementsUnit : @"时间",
             yElementMax: @"3",
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

#pragma mark - 选择模式的view

-(void)addChooseModelView{
    
    UIView * chooseView = [[UIView alloc]init];
    [self addSubview:chooseView];
    [chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(lineBackView.mas_bottom).with.offset(0);
        make.height.equalTo(@60);
    }];
    
    UIView * verLine = [[UIView alloc]init];
    verLine.backgroundColor = rgb(178, 178, 178, 1);
    [chooseView addSubview:verLine];
    [verLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(chooseView.mas_centerX);
        make.bottom.equalTo(chooseView.mas_bottom).with.offset(0);
        make.height.equalTo(@32);
        make.width.equalTo(@1);
    }];
    
    _minutesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_minutesButton setTitle:@"分钟间隔" forState:UIControlStateNormal];
    [_minutesButton setTitleColor:rgb(153, 153, 153, 1) forState:UIControlStateNormal];
    [_minutesButton setTitleColor:rgb(72, 189, 255, 1) forState:UIControlStateSelected];
    _minutesButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_minutesButton addTarget:self action:@selector(minutesButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [chooseView addSubview:_minutesButton];
    [_minutesButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chooseView.mas_left).with.offset(0);
        make.right.equalTo(verLine.mas_left).with.offset(0);
        make.bottom.equalTo(chooseView.mas_bottom).with.offset(0);
        make.height.equalTo(@35);
    }];
    
    _hourButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_hourButton setTitle:@"小时间隔" forState:UIControlStateNormal];
    [_hourButton setTitleColor:rgb(153, 153, 153, 1) forState:UIControlStateNormal];
    [_hourButton setTitleColor:rgb(72, 189, 255, 1) forState:UIControlStateSelected];
    _hourButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _hourButton.selected = true;
    [_hourButton addTarget:self action:@selector(hourButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [chooseView addSubview:_hourButton];
    [_hourButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(chooseView.mas_right).with.offset(0);
        make.left.equalTo(verLine.mas_right).with.offset(0);
        make.bottom.equalTo(chooseView.mas_bottom).with.offset(0);
        make.height.equalTo(@35);
    }];
}

-(void)minutesButtonClick:(id)sender{
    UIButton * button = sender;
    button.selected = !button.selected;
    
    
    
}
-(void)hourButtonClick:(id)sender{
    UIButton * button = sender;
    button.selected = !button.selected;
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
