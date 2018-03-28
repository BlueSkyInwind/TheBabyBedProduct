//
//  HomeHeaderView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "HomeHeaderView.h"

@implementation HomeHeaderView

+(instancetype)initWithBabyStatus:(NSArray *)statusArr{
    
    CGRect frame = CGRectMake(0, 0, _k_w, _k_w * 0.61 + 47);
    HomeHeaderView * headerView = [[HomeHeaderView alloc]initWithFrame:frame];
    headerView.statusArr = statusArr;
    return headerView;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self configureView];
    }
    return self;
}

-(void)configureView{
    
    _videoView = [[UIView alloc]init];
    _videoView.backgroundColor = [UIColor redColor];
    [self addSubview:_videoView];
    [_videoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@(_k_w * 0.61));
    }];
    
    _babyStatusView = [[UIView alloc]init];
    [self addSubview:_babyStatusView];
    [_babyStatusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(_videoView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = rgb(51, 51, 51, 1);
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.text = @"宝宝状态";
    [_babyStatusView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_babyStatusView.mas_centerY);
        make.left.equalTo(self.mas_left).with.offset(15);
    }];
}

-(void)setStatusArr:(NSArray *)statusArr{
    _statusArr = statusArr;
    if (_statusArr.count != 0) {
        [self creatStatusImg:statusArr];
    }
}

-(void)creatStatusImg:(NSArray *)arr{
    
    CGFloat rightCon = 15;
    CGFloat imgWidth = 26;
    for (int i = 0; i < arr.count; i ++) {
        rightCon = (imgWidth + 5) * i + 15;
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.image = [UIImage imageNamed:arr[i]];
        [_babyStatusView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_babyStatusView.mas_right).with.offset(-rightCon);
            make.height.width.equalTo(@(imgWidth));
            make.centerY.equalTo(_babyStatusView.mas_centerY);
        }];
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
