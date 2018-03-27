//
//  PXXview.m
//  PXLineChart
//
//  Created by Xin Peng on 17/4/13.
//  Copyright © 2017年 EB. All rights reserved.
//

#import "PXXview.h"

@interface PXXview ()

@property (nonatomic, strong) UIView *xlineView;
@property (nonatomic, strong) NSMutableArray *xElements;
@property (nonatomic, assign) CGFloat xElementInterval;
@property (nonatomic, assign) CGFloat xCon;
@property (nonatomic, strong) NSString * xElementUnit;

@end

@implementation PXXview

#pragma mark - 

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self == [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)initialize {
    _xElementInterval = 40;
    _xlineView = UIView.new;
    _xlineView.backgroundColor = [UIColor grayColor];
    _xElements = @[].mutableCopy;
}

- (void)reset {
    [_xElements removeAllObjects];
}

- (void)setDelegate:(id<PXLineChartViewDelegate>)delegate {
    _delegate = delegate;
}

- (void)reloadXaxis {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self reset];
    
    //单位
    UILabel * unitLabel = [[UILabel alloc]init];
    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:12]};
    unitLabel.textColor = rgb(255, 155, 57, 1);
    unitLabel.text = self.xElementUnit;
    unitLabel.font = [UIFont systemFontOfSize:12];
    unitLabel.backgroundColor = [UIColor whiteColor];
    CGSize elementSize = [unitLabel.text sizeWithAttributes:attr];
    UIView * view = self.superview.superview;   //获取曲线的第二层view
    CGFloat labelWidth = elementSize.width;
    CGFloat labelHeight = elementSize.height;
    unitLabel.frame = CGRectMake(CGRectGetWidth(view.frame) - labelWidth + 5,CGRectGetHeight(view.frame) - labelHeight ,labelWidth,labelHeight);
    [view addSubview:unitLabel];
    
    if (self.axisAttributes[yAxisColor]) {
        self.xlineView.backgroundColor = self.axisAttributes[yAxisColor];
    }
    self.xlineView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 1);
    [self addSubview:self.xlineView];
    NSUInteger elementCons = 0;
    if (_delegate && [_delegate respondsToSelector:@selector(numberOfElementsCountWithAxisType:)]) {
        elementCons = [_delegate numberOfElementsCountWithAxisType:AxisTypeX];
    }
    if (_axisAttributes[xElementInterval]) {
        self.xElementInterval = [_axisAttributes[xElementInterval] floatValue];
    };
    for (int i = 0; i < elementCons; i++) {
        UILabel *elementView = [[UILabel alloc] init];
        if (_delegate && [_delegate respondsToSelector:@selector(elementWithAxisType:index:)]) {
            elementView = (UILabel *)[_delegate elementWithAxisType:AxisTypeX index:i];
        }
        NSDictionary *attr = @{NSFontAttributeName : elementView.font};
        elementView.textColor = rgb(255, 155, 57, 1);
        CGSize elementSize = [elementView.text sizeWithAttributes:attr];
        elementView.frame = CGRectMake(0,
                                    CGRectGetHeight(self.frame)-elementSize.height,
                                       elementSize.width,
                                       elementSize.height);
        elementView.center = CGPointMake(_xElementInterval*(i), elementView.center.y);
        [self addSubview:elementView];
        NSString *xTitle = @"";
        if ([elementView.text length]) {
            xTitle = elementView.text;
        }
        [self.xElements addObject:xTitle];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self reloadXaxis];
}

- (void)setAxisAttributes:(NSDictionary *)axisAttributes {
    _axisAttributes = axisAttributes;
    if (axisAttributes[xElementInterval]) {
        self.xElementInterval = [axisAttributes[xElementInterval] floatValue];
    }
    if (axisAttributes[xElementsUnit]) {
        self.xElementUnit = axisAttributes[xElementsUnit];
    }
}

- (CGFloat)pointOfXcoordinate:(NSString *)xAxisValue {
    NSUInteger xIndex = [self.xElements indexOfObject:xAxisValue];
    return (xIndex)*_xElementInterval;
}

- (void)refresh {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
@end
