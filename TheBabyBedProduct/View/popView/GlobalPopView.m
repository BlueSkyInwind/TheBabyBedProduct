//
//  GlobalPopView.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "GlobalPopView.h"


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
/**弹窗View*/
@property (nonatomic,strong)UIView * alertView;
/**关闭的btn*/
@property (nonatomic,strong)UIButton * closeBtn;

@property (nonatomic,copy)GlobalPopViewClick  globalPopViewClick;

@end


@implementation GlobalPopView

+(instancetype)initWithTitle:(NSString *)title content:(NSString *)content cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle clickcompletion:(GlobalPopViewClick)globalPopClickBlock{

    GlobalPopView * popView = [[GlobalPopView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    popView.globalPopViewClick = globalPopClickBlock;
    popView.titleLabel.text = title;
    popView.contentLabel.text = content;
    [popView.cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
    [popView.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
    
    CGFloat minHeight = 170;
    if (title == nil) {
        minHeight  = 140;
        [popView.contentLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(popView.alertView.mas_top).with.offset(35);
            make.left.equalTo(popView.alertView.mas_left).with.offset(5);
            make.right.equalTo(popView.alertView.mas_right).with.offset(-5);
            make.bottom.equalTo(popView.sureBtn.mas_top).with.offset(-5);
        }];
    }
    
    [popView adaptationPopViewHeight:content minHeight:minHeight];

    return popView;
}

-(void)adaptationPopViewHeight:(NSString *)content minHeight:(CGFloat)height{
    
    CGSize contentSize = CGSizeMake(self.alertView.frame.size.width - 10, 1000);
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:14.f ]};
    CGRect contentRect = [content boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    CGFloat resultheight = (contentRect.size.height + 105) < height ? height : contentRect.size.height + 105;
    [self.alertView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(resultheight));
    }];
}


-(void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
    self.alertView.transform = CGAffineTransformMakeScale(1.21, 1.21);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1, 1);
        self.alertView.alpha = 1;
    } completion:nil];
}

-(void)dismiss{
    [UIView animateWithDuration:0.5 animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1, 1);
        self.alertView.alpha = 1;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = rgb(0, 0, 0, 0.8);
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

-(void)CloseBtnClick:(id)sender{
    [self dismiss];
}

-(void)configureView{
    
    _alertView = [[UIView alloc]init];
    _alertView.backgroundColor = [UIColor whiteColor];
    _alertView.layer.cornerRadius = 10;
    _alertView.clipsToBounds = true;
    _alertView.layer.borderWidth = 1;
    _alertView.layer.borderColor = rgb(255, 155, 57, 1).CGColor;
    [self addSubview:_alertView];
    [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.equalTo(@170);
        make.width.equalTo(@298);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_alertView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_alertView.mas_top).with.offset(20);
        make.left.right.equalTo(_alertView);
        make.height.equalTo(@20);
    }];
    
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setImage:[UIImage imageNamed:@"popClose_Icon"] forState:UIControlStateNormal];
    _closeBtn.layer.cornerRadius = 3;
    _closeBtn.clipsToBounds = true;
    [_closeBtn addTarget:self action:@selector(CloseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_closeBtn];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_alertView.mas_top).with.offset(12);
        make.right.equalTo(_alertView.mas_right).offset(-12);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    _cancelBtn.backgroundColor = rgb(153, 153, 153, 1);
    [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cancelBtn.layer.cornerRadius = 3;
    _cancelBtn.clipsToBounds = true;
    [_cancelBtn addTarget:self action:@selector(CancelBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_cancelBtn];
    [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_alertView.mas_centerX).with.offset(-75);
        make.bottom.equalTo(_alertView.mas_bottom).offset(-25);
        make.width.equalTo(@88);
        make.height.equalTo(@33);
    }];
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    _sureBtn.backgroundColor = rgb(255, 155, 57, 1);
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _sureBtn.layer.cornerRadius = 3;
    _sureBtn.clipsToBounds = true;
    [_sureBtn addTarget:self action:@selector(SureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_alertView addSubview:_sureBtn];
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_alertView.mas_centerX).with.offset(75);
        make.bottom.equalTo(_alertView.mas_bottom).offset(-25);
        make.width.equalTo(@88);
        make.height.equalTo(@35);
    }];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.numberOfLines = 0;
    [_alertView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(5);
        make.left.equalTo(_alertView.mas_left).with.offset(5);
        make.right.equalTo(_alertView.mas_right).with.offset(-5);
        make.bottom.equalTo(_sureBtn.mas_top).with.offset(-15);
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
