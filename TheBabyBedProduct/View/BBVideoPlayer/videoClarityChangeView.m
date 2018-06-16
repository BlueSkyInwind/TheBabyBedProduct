//
//  videoClarityChangeView.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/6/11.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "videoClarityChangeView.h"

#define ChangeView_Height 80
#define ChangeView_Width 50


@interface videoClarityChangeView()

@property (nonatomic,strong,readwrite)NSMutableArray * buttonArr;
@property (nonatomic,assign)CGRect originFrame;


@end

@implementation videoClarityChangeView

static videoClarityChangeView * changeView = nil;
+(void)showClarityChangeView:(CGRect)frame superView:(UIView *)superView dataSource:(NSArray *)dataSource complication:(ClarityChange)index{
    if (changeView == nil) {
        changeView = [[videoClarityChangeView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y , 0 , 0)];
        changeView.originFrame = frame;
        changeView.titleArr = [dataSource mutableCopy];
        changeView.clarityChange = index;
        [superView addSubview:changeView];
    }
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        changeView.frame = CGRectMake(frame.origin.x, frame.origin.y - ChangeView_Height - 10, ChangeView_Width, ChangeView_Height);
        changeView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
}

+(void)hideChangeView{
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        changeView.alpha = 0;
    } completion:^(BOOL finished) {
        changeView.frame = CGRectMake(changeView.originFrame.origin.x, changeView.originFrame.origin.y, ChangeView_Width, 0);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titleArr = [NSArray array];
    }
    return self;
}

-(void)setTitleArr:(NSArray *)titleArr{
    _titleArr = titleArr;
    [self configreView];
}


-(void)configreView{
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width - 4, self.frame.size.height - 4)];
    _backView.layer.borderColor = [UIColor whiteColor].CGColor;
    _backView.layer.borderWidth = 1;
    _backView.layer.cornerRadius = 3;
    _backView.clipsToBounds = false;
    _backView.center = self.center;
    [self addSubview:_backView];
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@(2));
        make.bottom.right.equalTo(@(-2));
    }];
    
    NSArray * array = self.titleArr;
    CGFloat buttonHeight = (ChangeView_Height - 4) / array.count;
    for (int i = 0; i < array.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.tag = 6000 + i;
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(changeEventClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backView.mas_top).with.offset(buttonHeight * i);
            make.centerX.equalTo(self.backView.mas_centerX).with.offset(0);
            make.width.equalTo(@(ChangeView_Width - 8));
            make.height.equalTo(@(buttonHeight));
        }];
        [_buttonArr addObject:button];
    }
}

-(void)changeEventClick:(UIButton *)sender{
    UIButton * eventBtn = sender;
    for (UIButton * button in _buttonArr) {
        if ([button isEqual:eventBtn]) {
            [button setTitleColor:UI_MAIN_COLOR forState:UIControlStateNormal];
        }else{
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }
    }
    if (self.clarityChange != nil) {
        self.clarityChange(eventBtn.tag - 6000,eventBtn.titleLabel.text);
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
