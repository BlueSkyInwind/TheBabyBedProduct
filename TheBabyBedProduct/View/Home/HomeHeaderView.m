//
//  HomeHeaderView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "HomeHeaderView.h"
#import "ZFPlayer.h"
#import "BBVideoPlayView.h"

@interface HomeHeaderView ()
    
@property(atomic, retain) id<IJKMediaPlayback> player;
@property(nonatomic, strong) UIButton * playerBtn;
@property(nonatomic,strong) ZFPlayerView *playerView;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property(nonatomic,strong) UIView *recommenderView;

@end

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
    //rtmp://pull.yingerxiang.com/huadong/video   rtmp://live.hkstv.hk.lxdns.com/live/hks
    BBVideoPlayView * videoPlayView = [BBVideoPlayView initBBVideoPlayView:_videoView videoUrl:@"rtmp://live.hkstv.hk.lxdns.com/live/hks"];
    
//    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
//    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"rtmp://live.hkstv.hk.lxdns.com/live/hks"] withOptions:options];
//    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
//    self.player.shouldAutoplay = YES;
//    _videoView.autoresizesSubviews = YES;
//    [_videoView addSubview:self.player.view];
//    [self.player.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(_videoView);
//    }];
//
//    [self.player prepareToPlay];
//    [self.player play];

//    _playerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _playerBtn.center = _videoView.center;
//    [_playerBtn setBackgroundImage:[UIImage imageNamed:@"home_video_play_Icon"] forState:UIControlStateNormal];
//    [_playerBtn addTarget:self action:@selector(playerBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:_playerBtn];
    

//    self.recommenderView = [UIView new];
//    [self addSubview:self.recommenderView];
//    self.recommenderView.backgroundColor = rgb(0, 0, 0, 0.5);
//    [self.recommenderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.videoView);
//    }];
//    
//    UIView *itemV = [UIView new];
//    itemV.backgroundColor = [UIColor clearColor];
//    [self.recommenderView addSubview:itemV];
//    [itemV mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.recommenderView.mas_centerX);
//        make.centerY.equalTo(self.recommenderView.mas_centerY);
//    }];
//    
//    UILabel *noGoldRecommenderLB = [UILabel bb_lbMakeWithSuperV:itemV fontSize:14 alignment:NSTextAlignmentCenter textColor:[UIColor whiteColor]];
//    noGoldRecommenderLB.text = @"您的免费观看分钟已使用完毕，请充值";
//    [noGoldRecommenderLB mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.top.equalTo(self.mas_top);
//        make.height.equalTo(@20);
//    }];
    
//    QMUIFillButton *cancelBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
//    [itemV addSubview:cancelBT];
//    cancelBT.titleLabel.font = [UIFont systemFontOfSize:16];
//    cancelBT.fillColor = k_color_153153153;
//    cancelBT.titleTextColor = [UIColor whiteColor];
//    [cancelBT setTitle:@"取消" forState:UIControlStateNormal];
//    cancelBT.frame = CGRectMake(leftMargin, CGRectGetMaxY(forgetPasswordBT.frame), _k_w-leftMargin*2, 47);
//    [cancelBT addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
//    [cancelBT mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(itemV.mas_centerX).with.offset(-60);
//    }]
    
    self.playerView.ZFPlayerViewGetCurrentSeconBlock = ^(ZFPlayerView *playerView,NSInteger currentSecond) {
        if (currentSecond >= 12) {
            [playerView pause];
            NSLog(@"你就剩12秒的时间，请尽快充值");
        }
    };
    
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
        for (UIView * view in _babyStatusView.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [view removeFromSuperview];
            }
        }
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

-(void)playerBtnClick:(id)sender{
        
        
}
    

@end
