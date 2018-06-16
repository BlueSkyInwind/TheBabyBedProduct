//
//  videoClarityChangeView.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/6/11.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "videoClarityChangeView.h"
@interface videoClarityChangeView()

@property (nonatomic,strong,readwrite)NSMutableArray * buttonArr;


@end

@implementation videoClarityChangeView


-(void)showClarityChangeView{
    
    
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _titleArr = [NSArray array];
    }
    return self;
}

-(void)configreView{
    
    
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width - 4, self.frame.size.height - 4)];
    _backView.layer.borderColor = [UIColor whiteColor].CGColor;
    _backView.layer.borderWidth = 1;
    _backView.layer.cornerRadius = 3;
    _backView.clipsToBounds = true;
    _backView.center = self.center;
    [self addSubview:_backView];
    
    NSArray * array = self.titleArr;
    CGFloat buttonHeight = _backView.frame.size.height / array.count;
    for (int i = 0; i < array.count; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 6000 + i;
        button.frame = CGRectMake(0, _backView.frame.size.height - buttonHeight * i, _backView.frame.size.width, buttonHeight);
        [button setTitle:array[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(changeEventClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:button];
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
        self.clarityChange(eventBtn.tag - 6000);
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
