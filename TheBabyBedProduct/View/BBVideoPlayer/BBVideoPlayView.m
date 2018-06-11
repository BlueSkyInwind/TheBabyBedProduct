//
//  BBVideoPlayView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/5/31.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBVideoPlayView.h"
#import "ASValueTrackingSlider.h"
@interface BBVideoPlayView()<UIGestureRecognizerDelegate>{
    
    BOOL _forcePortrait;
    
    BOOL _drag;
    
    
}
/* <#Description#>*/
@property(nonatomic,strong) UIView * vedioSuperView;
@property(atomic, retain) id<IJKMediaPlayback> player;
/* <#Description#>*/
@property(nonatomic,strong)UISlider * videoSlider;
/**<#Description#>*/
@property (nonatomic,strong)NSString   * playUrl;

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
    [playView addVerticalUI];
    [playView addLandscapeCtrlView];
    playView.landscapeCtrlView.hidden = true;
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
        self.backgroundColor = [UIColor blackColor];
        _drag = true;
        //监听横竖屏切换
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
        // app从后台进入前台都会调用这个方法
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationBecomeActive) name:UIApplicationWillEnterForegroundNotification object:nil];
        // 添加检测app进入后台的观察者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationEnterBackground) name: UIApplicationDidEnterBackgroundNotification object:nil];
        // 添加检测app进入后台的观察者
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changePlayerSource:) name:YDA_CFG_NOTIFICATION object:nil];

    }
    return self;
}
-(void)changePlayerSource:(NSNotification *)notification{
    
    NSDictionary * info = notification.userInfo;
    NSString * addressStr = info[Video_Address];
    _playUrl = addressStr;
    [self createPlayer:_playUrl];

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
    [self.player setPauseInBackground:true];
    self.autoresizesSubviews = YES;
    [self addSubview:self.player.view];
    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.player prepareToPlay];
    [self.player play];
}
-(void)palyVideo{
    [[BBUdpSocketManager shareInstance] sendCFGSettingRequestMessage:@{VideoPlayrStatus:@(1),VideoClarityStatus:@(1)}];
    [self refreshMediaControl];
}
-(void)pauseVideo{
    [self.player pause];
    [self refreshMediaControl];
}
-(void)stopVideo{
    [[BBUdpSocketManager shareInstance] sendCFGSettingRequestMessage:@{VideoPlayrStatus:@(0),VideoClarityStatus:@(1)}];
    [self.player stop];
    self.player = nil;
}
-(void)refreshMediaControl{
    
    NSTimeInterval duration = self.player.duration;
    NSTimeInterval position = self.player.currentPlaybackTime;
    if (_drag) {
        position = self.videoSlider.value;
    }else{
        position = self.player.currentPlaybackTime;
    }
    NSInteger intPosition = position + 0.5;
    NSInteger intDuration = duration + 0.5;
    if (duration > 0) {
        self.durationLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)(intDuration / 60), (int)(intDuration % 60)];
        self.currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d", (int)(intPosition / 60), (int)(intPosition % 60)];
        self.videoSlider.value = intPosition/intDuration;
    }
}

#pragma mrak -------- 监听横竖屏切换 --------------------

-(void)orientChange:(NSNotification *)notification{
    
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationPortrait) {
        
    }
    if ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight) {
        
    }
}
-(void)applicationBecomeActive{
    BOOL isPlaying = [self.player isPlaying];
    if (!isPlaying) {
        [self palyVideo];
    }
}
-(void)applicationEnterBackground{
    BOOL isPlaying = [self.player isPlaying];
    if (isPlaying) {
        [self stopVideo];
    }
}
#pragma mrak -------- 响应事件 --------------------
-(void)verticalPlayerBtnClick:(id)sender{
    UIButton * button = (UIButton *)sender;
    BOOL isPlaying = [self.player isPlaying];
    if (isPlaying) {
        button.alpha = 1;
        [self stopVideo];
    }else{
        button.alpha = 0.1;
        [self palyVideo];
    }
}
-(void)fullcreenBtnBtnClick:(id)sender{
    
    _forcePortrait = NO;
    [self setOrientationLandscapeConstraint:UIInterfaceOrientationLandscapeRight];
}

-(void)landscapeBackBtnClick:(id)sender{
    
    [self addPlayerToFatherView:self.superview];
    _forcePortrait = YES;
    [self setOrientationLandscapeConstraint:UIInterfaceOrientationPortrait];
}
-(void)screenShotBtnClick:(id)sender{
    [self screenShot];
}

-(void)landscapePlayerBtnClick:(id)sender{
    UIButton * button = (UIButton *)sender;
    BOOL isPlaying = [self.player isPlaying];
    if (isPlaying) {
        [self stopVideo];
    }else{
        [self palyVideo];
    }
}

-(void)clarityBtnClick:(id)sender{
    //切换清晰度
    [[BBUdpSocketManager shareInstance] sendCFGSettingRequestMessage:@{VideoPlayrStatus:@(0),VideoClarityStatus:@(1)}];
    
}
-(void)progressSliderTouchBegan:(UISlider *)sender{
    
    _drag = true;
}
-(void)progressSliderValueChanged:(UISlider *)sender{
    
    UISlider *slider = (UISlider *)sender;
    CGFloat chageValue = slider.value;
    [self refreshMediaControl];
    
}
-(void)progressSliderTouchEnded:(UISlider *)sender{
    
    _drag = false;

}
-(void)tapSliderAction:(UIPanGestureRecognizer *)tap{
    
    if ([tap.view isKindOfClass:[UISlider class]]) {
        UISlider *slider = (UISlider *)tap.view;
        CGPoint point = [tap locationInView:slider];
        CGFloat length = slider.frame.size.width;
        // 视频跳转的value
        CGFloat tapValue = point.x / length;
        
    }
}
// 不做处理，只是为了滑动slider其他地方不响应其他手势
- (void)panRecognizer:(UIPanGestureRecognizer *)sender {}

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
        self.verticalCtrlView.hidden = false;
        self.landscapeCtrlView.hidden = true;
        [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:NO];
    }
    else {
        self.verticalCtrlView.hidden = true;
        self.landscapeCtrlView.hidden = false;
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

    _landscapeBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _landscapeBackBtn.center = self.center;
    [_landscapeBackBtn setBackgroundImage:[UIImage imageNamed:@"white_Return"] forState:UIControlStateNormal];
    [_landscapeBackBtn addTarget:self action:@selector(landscapeBackBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_landscapeCtrlView addSubview:_landscapeBackBtn];
    [_landscapeBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_landscapeCtrlView.mas_top).with.offset(30);
        make.left.equalTo(_verticalCtrlView.mas_left).with.offset(10);
        make.width.height.equalTo(@(20));
    }];
    
    _screenshotsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _screenshotsBtn.center = self.center;
    [_screenshotsBtn setBackgroundImage:[UIImage imageNamed:@"video_Shot_Icon"] forState:UIControlStateNormal];
    [_screenshotsBtn addTarget:self action:@selector(screenShotBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_landscapeCtrlView addSubview:_screenshotsBtn];
    [_screenshotsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_landscapeCtrlView.mas_centerY).with.offset(0);
        make.right.equalTo(_verticalCtrlView.mas_right).with.offset(-10);
        make.width.height.equalTo(@(20));
    }];
    
    _bottomView = [[UIView alloc]init];
//    _bottomView.backgroundColor = [UIColor redColor];
    [_landscapeCtrlView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_landscapeCtrlView.mas_bottom).with.offset(0);
        make.left.right.equalTo(@(0));
        make.height.equalTo(@(40));
    }];
    
    _clarityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _clarityBtn.center = self.center;
    _clarityBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_clarityBtn setTitle:@"标清" forState:UIControlStateNormal];
    [_clarityBtn addTarget:self action:@selector(clarityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_clarityBtn];
    [_clarityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.right.equalTo(_bottomView.mas_right).with.offset(-20);
        make.height.equalTo(@(25));
    }];

    _landscapePlayerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _landscapePlayerBtn.center = self.center;
    [_landscapePlayerBtn setBackgroundImage:[UIImage imageNamed:@"video_puase_Icon"] forState:UIControlStateNormal];
    [_landscapePlayerBtn addTarget:self action:@selector(landscapePlayerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomView addSubview:_landscapePlayerBtn];
    [_landscapePlayerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.left.equalTo(_bottomView.mas_left).with.offset(20);
        make.width.height.equalTo(@(25));
    }];
    
//    _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _nextBtn.center = self.center;
//    [_nextBtn setBackgroundImage:[UIImage imageNamed:@"next_video_Icon"] forState:UIControlStateNormal];
//    [_nextBtn addTarget:self action:@selector(screenShotBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [_bottomView addSubview:_nextBtn];
//    [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_bottomView.mas_centerY);
//        make.left.equalTo(_landscapePlayerBtn.mas_right).with.offset(15);
//        make.width.height.equalTo(@(25));
//    }];
    
    _currentTimeLabel = [[UILabel alloc]init];
    _currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    _currentTimeLabel.text = @"--:--";
    _currentTimeLabel.textColor = [UIColor whiteColor];
    _currentTimeLabel.font = [UIFont systemFontOfSize:15];
    [_bottomView addSubview:_currentTimeLabel];
    [_currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomView.mas_centerY);
        make.left.equalTo(_landscapePlayerBtn.mas_right).with.offset(15);
    }];
    
//    _durationLabel = [[UILabel alloc]init];
//    _durationLabel.textAlignment = NSTextAlignmentCenter;
//    _durationLabel.text = @"--:--";
//    _durationLabel.textColor = [UIColor whiteColor];
//    _durationLabel.font = [UIFont systemFontOfSize:15];
//    [_bottomView addSubview:_durationLabel];
//    [_durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_bottomView.mas_centerY);
//        make.right.equalTo(_clarityBtn.mas_left).with.offset(-15);
//    }];
    
//    [_bottomView addSubview:self.videoSlider];
//    [_videoSlider mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(_bottomView.mas_centerY);
//        make.left.equalTo(_currentTimeLabel.mas_right).with.offset(5);
//        make.right.equalTo(_durationLabel.mas_left).with.offset(-5);
//    }];
}

- (UISlider *)videoSlider {
    if (!_videoSlider) {
        _videoSlider = [[UISlider alloc] init];
        UIImage * image = [UIImage bb_imageWithColor:rgb(255, 255, 57, 1) size:CGSizeMake(5, 5)];
        
        [_videoSlider setThumbImage:image forState:UIControlStateNormal];
        _videoSlider.maximumValue          = 1;
        _videoSlider.minimumTrackTintColor = rgb(255, 255, 57, 1);
        _videoSlider.maximumTrackTintColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];
        
        // slider开始滑动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchBegan:) forControlEvents:UIControlEventTouchDown];
        // slider滑动中事件
        [_videoSlider addTarget:self action:@selector(progressSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
        // slider结束滑动事件
        [_videoSlider addTarget:self action:@selector(progressSliderTouchEnded:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchUpOutside];
        
        UITapGestureRecognizer *sliderTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSliderAction:)];
        [_videoSlider addGestureRecognizer:sliderTap];
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panRecognizer:)];
        panRecognizer.delegate = self;
        [panRecognizer setMaximumNumberOfTouches:1];
        [panRecognizer setDelaysTouchesBegan:YES];
        [panRecognizer setDelaysTouchesEnded:YES];
        [panRecognizer setCancelsTouchesInView:YES];
        [_videoSlider addGestureRecognizer:panRecognizer];
    }
    return _videoSlider;
}
#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    CGRect rect = [self thumbRect];
    CGPoint point = [touch locationInView:self.videoSlider];
    if ([touch.view isKindOfClass:[UISlider class]]) { // 如果在滑块上点击就不响应pan手势
        if (point.x <= rect.origin.x + rect.size.width && point.x >= rect.origin.x) { return NO; }
    }
    return YES;
}
/**
 slider滑块的bounds
 */
- (CGRect)thumbRect {
    return [self.videoSlider thumbRectForBounds:self.videoSlider.bounds
                                      trackRect:[self.videoSlider trackRectForBounds:self.videoSlider.bounds]
                                          value:self.videoSlider.value];
}
-(void) screenShot{
    
    CGRect screenFrame = [UIApplication sharedApplication].keyWindow.frame;
    UIGraphicsBeginImageContextWithOptions(screenFrame.size, NO, 0);
    for (UIWindow *window in [[UIApplication sharedApplication] windows])
    {
        [window drawViewHierarchyInRect:screenFrame afterScreenUpdates:NO];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [QMUITips showInfo:@"已保存到相册"];
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




@implementation BBVideoPlayView (configureView)


@end
