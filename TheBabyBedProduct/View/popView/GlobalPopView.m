//
//  GlobalPopView.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "GlobalPopView.h"

typedef void (^GlobalPopViewClick)(NSInteger index);

@interface GlobalPopView(){
    
    
}

/*标题头*/
@property (nonatomic,strong)UILabel  * titleLabel;
/**内容*/
@property (nonatomic,strong)UILabel  * contentLabel;
/**取消button*/
@property (nonatomic,strong)UIButton  * cancelBtn;
/**确定button*/
@property (nonatomic,strong)UIButton  * sureBtn;

@property (nonatomic,copy)GlobalPopViewClick  globalPopViewClick;

@end


@implementation GlobalPopView


+(void)initWithSuperVC:(UIViewController *)vc title:(NSString *)title content:(NSString *)content cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle clickcompletion:(GlobalPopViewClick)globalPopClickBlock{
    
    CGRect frame = CGRectMake(0, 0, 298, 170);
    CGSize contentSize = CGSizeMake(frame.size.width - 10, 1000);
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14.f ]};
    CGRect contentRect = [content boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    frame.size.height = contentRect.size.height + 105;
    
    UIView * backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, _k_h)];
    backView.backgroundColor = [UIColor grayColor];
    backView.alpha =  0.8;
    [[UIApplication sharedApplication].keyWindow addSubview:backView];
    
    GlobalPopView * popView = [[GlobalPopView alloc]initWithFrame:frame];
    popView.center = CGPointMake(_k_w / 2, _k_h / 2);
    globalPopClickBlock = popView.globalPopViewClick;
    [backView addSubview:popView];
    
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureView];
    }
    return  self;
}

-(void)CancelBtnClick:(id)sender{
    if (self.globalPopViewClick) {
        self.globalPopViewClick(0);
    }
}
-(void)SureBtnClick:(id)sender{
    if (self.globalPopViewClick) {
        self.globalPopViewClick(1);
    }
}

-(void)configureView{
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.right.equalTo(self);
        make.height.equalTo(@20);
    }];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancelBtn.backgroundColor = rgb(153, 153, 153, 1);
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cancelBtn.layer.cornerRadius = 3;
    _cancelBtn.clipsToBounds = true;
    [_cancelBtn addTarget:self action:@selector(CancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(-50);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
        make.width.equalTo(@88);
        make.height.equalTo(@35);
    }];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    _sureBtn.backgroundColor = rgb(153, 153, 153, 1);
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureBtn.layer.cornerRadius = 3;
    _sureBtn.clipsToBounds = true;
    [_sureBtn addTarget:self action:@selector(SureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sureBtn];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(50);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
        make.width.equalTo(@88);
        make.height.equalTo(@35);
    }];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_top).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.bottom.equalTo(self.mas_top).with.offset(-15);
    }];
    
    
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
