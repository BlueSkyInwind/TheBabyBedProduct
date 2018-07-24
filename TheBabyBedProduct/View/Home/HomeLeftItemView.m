//
//  HomeLeftItemView.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "HomeLeftItemView.h"

@implementation HomeLeftItemView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
    }
    return self;
}
-(void)configureView{
    
    _headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerBtn.frame = CGRectMake(0, 0, 32, 32);
    _headerBtn.center = CGPointMake(16, 16);
    [_headerBtn setBackgroundImage:[UIImage imageNamed:@"home_baby_header_Icon"] forState:UIControlStateNormal];
    _headerBtn.layer.cornerRadius = 16;
    _headerBtn.layer.borderColor = rgb(255, 206, 0, 1).CGColor;
    _headerBtn.layer.borderWidth = 1;
    _headerBtn.clipsToBounds = true;
    [_headerBtn addTarget:self action:@selector(HeaderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_headerBtn];

    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(37, 0, 80, 30)];
    _nameLabel.font = [UIFont systemFontOfSize:15];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    _nameLabel.textColor = [UIColor blackColor];
    [self addSubview:_nameLabel];

}
-(void)HeaderBtnClick:(id)sender{
    if (self.homeHeaderClick) {
        self.homeHeaderClick(sender);
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
