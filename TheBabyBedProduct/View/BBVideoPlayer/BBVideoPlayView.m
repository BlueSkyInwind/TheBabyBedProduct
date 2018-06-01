//
//  BBVideoPlayView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/5/31.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBVideoPlayView.h"

@interface BBVideoPlayView(){
    
    BOOL _forcePortrait;
    
    
}
/* <#Description#>*/
@property(nonatomic,strong) UIView * vedioSuperView;
@property(atomic, retain) id<IJKMediaPlayback> player;
//竖屏控件
@property(nonatomic, strong) UIView * verticalCtrlView;
@property(nonatomic, strong) UIButton * verticalPlayerBtn;
@property(nonatomic, strong) UIButton * fullcreenBtn;

//横屏控件
@property(nonatomic, strong) UIView * landscapeCtrlView;
@property(nonatomic, strong) UIView * bottomView;
@property(nonatomic, strong) UIButton * landscapePlayerBtn;
@property(nonatomic, strong) UIButton * landscapeBackBtn;
@property(nonatomic, strong) UIButton * nextBtn;
@property(nonatomic, strong) UILabel * currentTimeLabel;
@property(nonatomic, strong) UILabel * durationLabel;
@property(nonatomic, strong) UIButton * screenshotsBtn;
@property(nonatomic, strong) UIButton * clarityBtn;



@end


@implementation BBVideoPlayView

+(id)initBBVideoPlayView:(UIView *)superView videoUrl:(NSString *)videoUrl{
    BBVideoPlayView * playView = [[BBVideoPlayView alloc]initWithFrame:CGRectZero];
    [playView createPlayer:videoUrl];
    playView.vedioSuperView = superView;
    [superView addSubview:playView];
    [playView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(superView);
    }];
    return playView;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //监听横竖屏切换
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    }
    return self;
}

-(void)createPlayer:(NSString *)videoUrl{
    
    if (self.player != nil){
        return;
    }
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:videoUrl] withOptions:options];
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
    self.player.shouldAutoplay = NO;
    self.autoresizesSubviews = YES;
    [self addSubview:self.player.view];
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.player prepareToPlay];
    [self addVerticalUI];
}

#pragma mrak -------- 监听横竖屏切换 --------------------

-(void)orientChange:(NSNotification *)notification{
    
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
        
        
    }
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        
        
    }
    
}

#pragma mrak -------- 响应事件 --------------------
-(void)verticalPlayerBtnClick:(id)sender{
    UIButton * button = (UIButton *)sender;
    BOOL isPlaying = [self.player isPlaying];
    if (isPlaying) {
        button.alpha = 1;
        [self.player pause];

    }else{
        button.alpha = 0.1;
        [self.player play];

    }
}
-(void)fullcreenBtnBtnClick:(id)sender{
    
    _forcePortrait = NO;
    [self setOrientationLandscapeConstraint:UIInterfaceOrientationLandscapeRight];
}

-(void)landscapeBackBtnClick:(id)sender{
    
    
}
#pragma mrak -------- 屏幕旋转 --------------------

/**
 *  设置横屏的约束
 */
- (void)setOrientationLandscapeConstraint:(UIInterfaceOrientation)orientation {
    [self toOrientation:orientation];
}
/**
 *  player添加到fatherView上
 */
- (void)addPlayerToFatherView:(UIView *)view {
    // 这里应该添加判断，因为view有可能为空，当view为空时[view addSubview:self]会crash
    if (_vedioSuperView) {
        [self removeFromSuperview];
        [_vedioSuperView addSubview:self];
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsZero);
        }];
    }
}
- (void)toOrientation:(UIInterfaceOrientation)orientation {
    // 获取到当前状态条的方向
    UIInterfaceOrientation currentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    // 判断如果当前方向和要旋转的方向一致,那么不做任何操作
    if (currentOrientation == orientation) { return; }
    
    // 根据要旋转的方向,使用Masonry重新修改限制
    if (orientation != UIInterfaceOrientationPortrait) {//
        // 这个地方加判断是为了从全屏的一侧,直接到全屏的另一侧不用修改限制,否则会出错;
        if (currentOrientation == UIInterfaceOrientationPortrait) {
            [self removeFromSuperview];
            [[UIApplication sharedApplication].keyWindow addSubview:self];
            [[UIApplication sharedApplication].keyWindow bringSubviewToFront:self];
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                if (_forcePortrait) {
                    make.width.equalTo(@(_k_w));
                    make.center.equalTo([UIApplication sharedApplication].keyWindow);
                    make.top.equalTo(@([self.class getNavBarTopHeight]));
                    make.bottom.equalTo(@0);
                } else {
                    make.width.equalTo(@(_k_h));
                    make.height.equalTo(@(_k_w));
                    make.center.equalTo([UIApplication sharedApplication].keyWindow);
                }
            }];
        }
    }
    // iOS6.0之后,设置状态条的方法能使用的前提是shouldAutorotate为NO,也就是说这个视图控制器内,旋转要关掉;
    // 也就是说在实现这个方法的时候-(BOOL)shouldAutorotate返回值要为NO
    if (_forcePortrait) {
//        [self changeStatusBackgroundColor:self.backgroundColor];
    }
    else {
        [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
    }
    
    // 获取旋转状态条需要的时间:
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    // 更改了状态条的方向,但是设备方向UIInterfaceOrientation还是正方向的,这就要设置给你播放视频的视图的方向设置旋转
    // 给你的播放视频的view视图设置旋转
    self.transform = CGAffineTransformIdentity;
    if (!_forcePortrait) {
        self.transform = [self getTransformRotationAngle];
    }
    // 开始旋转
    [UIView commitAnimations];
}

/**
 * 获取变换的旋转角度
 *
 * @return 角度
 */
- (CGAffineTransform)getTransformRotationAngle {
    // 状态条的方向已经设置过,所以这个就是你想要旋转的方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    // 根据要进行旋转的方向来计算旋转的角度
    if (orientation == UIInterfaceOrientationPortrait) {
        return CGAffineTransformIdentity;
    } else if (orientation == UIInterfaceOrientationLandscapeLeft){
        return CGAffineTransformMakeRotation(-M_PI_2);
    } else if(orientation == UIInterfaceOrientationLandscapeRight){
        return CGAffineTransformMakeRotation(M_PI_2);
    }
    return CGAffineTransformIdentity;
}
/**
 兼容iPhoneX的NavBaf顶部高度 （statusHeight）
 
 @return iPhoneX：44 other:20
 */
+ (CGFloat )getNavBarTopHeight {
    if (_k_w == 375 && _k_h == 812) {
        return 44;
    }
    return 20;
}

#pragma mrak -------- UI --------------------
-(void)addVerticalUI{
    
    _verticalCtrlView = [[UIView alloc]init];
    _verticalCtrlView.backgroundColor = [UIColor clearColor];
    [self addSubview:_verticalCtrlView];
    [_verticalCtrlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _verticalPlayerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _verticalPlayerBtn.center = self.center;
    [_verticalPlayerBtn setBackgroundImage:[UIImage imageNamed:@"home_video_play_Icon"] forState:UIControlStateNormal];
    [_verticalPlayerBtn addTarget:self action:@selector(verticalPlayerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_verticalCtrlView addSubview:_verticalPlayerBtn];
    [_verticalPlayerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_verticalCtrlView.mas_centerX);
        make.centerY.equalTo(_verticalCtrlView.mas_centerY);
    }];
    
    
    _fullcreenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_fullcreenBtn setBackgroundImage:[UIImage imageNamed:@"home_full_video_Icon"] forState:UIControlStateNormal];
    [_fullcreenBtn addTarget:self action:@selector(fullcreenBtnBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_verticalCtrlView addSubview:_fullcreenBtn];
    [_fullcreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_verticalCtrlView.mas_bottom).with.offset(-10);
        make.right.equalTo(_verticalCtrlView.mas_right).with.offset(-10);
        make.width.height.equalTo(@(20));
    }];
}

-(void)addLandscapeCtrlView{
    
    _landscapeCtrlView = [[UIView alloc]init];
    _landscapeCtrlView.backgroundColor = [UIColor clearColor];
    [self addSubview:_landscapeCtrlView];
    [_landscapeCtrlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _bottomView = [[UIView alloc]init];
    _bottomView.backgroundColor = [UIColor redColor];
    [_landscapeCtrlView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_landscapeCtrlView.mas_bottom).with.offset(0);
        make.left.right.equalTo(0);
        make.height.equalTo(@(40));
    }];
    
    _landscapeBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _landscapeBackBtn.center = self.center;
    [_landscapeBackBtn setBackgroundImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    [_landscapeBackBtn addTarget:self action:@selector(landscapeBackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_landscapeCtrlView addSubview:_landscapeBackBtn];
    [_landscapeBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_verticalCtrlView.mas_centerX);
        make.centerY.equalTo(_verticalCtrlView.mas_centerY);
    }];
}


-(void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
