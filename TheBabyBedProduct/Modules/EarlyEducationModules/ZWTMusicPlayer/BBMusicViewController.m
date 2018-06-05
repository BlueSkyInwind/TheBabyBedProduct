//
//  BBMusicViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/5/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBMusicViewController.h"
#import "Track.h"
#import "MusicSlider.h"
#import "MusicHandler.h"
#import "BaseHelper.h"
#import "MusicIndicator.h"

#include <stdlib.h>
#import "UIView+Animations.h"
#import "NSString+Additions.h"
#import <MediaPlayer/MediaPlayer.h>

#import "DOUAudioStreamer.h"
#import "GVUserDefaults+Properties.h"
#import "UIImageView+WebCache.h"

static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;
static void *kBufferingRatioKVOKey = &kBufferingRatioKVOKey;


@interface BBMusicViewController ()
@property(nonatomic,strong) BBMusic *music;
@property(nonatomic, strong) DOUAudioStreamer *streamer;
@property (strong, nonatomic) MusicSlider *musicSlider;
@property (strong, nonatomic) MusicIndicator *musicIndicator;


@property (nonatomic) NSTimer *musicDurationTimer;
@property (nonatomic) NSInteger currentIndex;
@property (nonatomic) BOOL musicIsPlaying;
@property (nonatomic, assign) MusicCycleType musicCycleType;
@property (strong, nonatomic) NSMutableArray *originArray;
@property (strong, nonatomic) NSMutableArray *randomArray;
@property (strong, nonatomic) NSMutableString *lastMusicUrl;


@property (nonatomic, assign) BOOL dontReloadMusic;
@property (nonatomic, assign) NSInteger specialIndex;
@property (nonatomic, copy) NSNumber *parentId;
//@property (nonatomic, weak) id<MusicViewControllerDelegate> delegate;
@property (nonatomic, assign) BOOL isNotPresenting;


@property(nonatomic,strong) UILabel *musicTitleLabel;
@property(nonatomic,strong) UILabel *beginTimeLabel;
@property(nonatomic,strong) UILabel *endTimeLabel;
@property (weak, nonatomic) UIButton *previousMusicButton;
@property (weak, nonatomic) UIButton *nextMusicButton;
@property (weak, nonatomic) UIButton *toggleButton;  //开关
@property (weak, nonatomic) UIButton *cycleButton;   //循环

@property (weak, nonatomic) UIImageView *backgroudImageView;
@property (weak, nonatomic) UIView *backgroudView;
@property (weak, nonatomic) UIImageView *albumImageView;
@property (strong, nonatomic) UIVisualEffectView *visualEffectView;

@property (weak, nonatomic) UILabel *musicNameLabel;
@property (weak, nonatomic) UILabel *singerLabel;
@end

@implementation BBMusicViewController
-(void)creatUI
{
    self.view.backgroundColor = [UIColor whiteColor];
   

    UIImageView *bgV = [UIImageView bb_imgVMakeWithSuperV:self.view imgName:@"bb_playMusic_bg.jpg"];
    bgV.userInteractionEnabled = YES;
    bgV.frame = self.view.bounds;
    
    UILabel *titleLB = [UILabel bb_lbMakeWithSuperV:bgV fontSize:18 alignment:NSTextAlignmentCenter textColor:[UIColor whiteColor]];
    titleLB.frame = CGRectMake(60, 27, _k_w-120, 30);
    titleLB.text = @"音乐播放";
    
    UIButton *dismissBt = [UIButton bb_btMakeWithSuperV:self.view imageName:@"return"];
    [dismissBt addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
#warning pp605 适配
    dismissBt.frame = CGRectMake(15, 20, 50, 50);
    
    UIView *bottomV = [[UIView alloc]initWithFrame:CGRectMake(0, _k_h-120, _k_w, 120)];
    [self.view addSubview:bottomV];
    
    self.beginTimeLabel = [UILabel bb_lbMakeWithSuperV:bottomV fontSize:10 alignment:NSTextAlignmentLeft textColor:[UIColor whiteColor]];
    self.beginTimeLabel.frame = CGRectMake(8, 0, 40, 36);
    
    self.endTimeLabel = [UILabel bb_lbMakeWithSuperV:bottomV fontSize:10 alignment:NSTextAlignmentRight textColor:[UIColor whiteColor]];
    self.endTimeLabel.frame = CGRectMake(_k_w-8-40, 0, 40, 36);
    
    self.musicSlider = [[MusicSlider alloc]initWithFrame:CGRectMake(self.beginTimeLabel.right, 0, _k_w-96, 36)];
    [bottomV addSubview:self.musicSlider];
    [self.musicSlider addTarget:self action:@selector(didChangeMusicSliderValue:) forControlEvents:UIControlEventValueChanged];
    self.musicSlider.minimumTrackTintColor = [UIColor whiteColor];
//    self.musicSlider.maximumTrackTintColor = [UIColor purpleColor];
//    self.musicSlider.thumbTintColor = [UIColor yellowColor];
    
    CGFloat toggleW = 50;
    CGFloat toggleX = (_k_w-self.toggleButton.width)/2;
    CGFloat toggleY =  51;
    self.toggleButton = [UIButton bb_btMakeWithSuperV:bottomV imageName:@"music_play_playing"];
    self.toggleButton.frame = CGRectMake(toggleX, toggleY, toggleW, toggleW);
    [self.toggleButton addTarget:self action:@selector(playOrSuspendAction) forControlEvents:UIControlEventTouchUpInside];
    [self.toggleButton setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    
    UIButton *previousBT = [UIButton bb_btMakeWithSuperV:bottomV imageName:@"music_play_previous"];
    previousBT.frame = CGRectMake(self.toggleButton.left-60, toggleY+5, 40, 40);
    [previousBT addTarget:self action:@selector(previousAction) forControlEvents:UIControlEventTouchUpInside];
    [previousBT setImageEdgeInsets:UIEdgeInsetsMake(9, 9, 9, 9)];

    
    UIButton *nextBT = [UIButton bb_btMakeWithSuperV:bottomV imageName:@"music_play_next"];
    nextBT.frame = CGRectMake(self.toggleButton.right+20, toggleY+5, 40, 40);
    [nextBT addTarget:self action:@selector(nextAction) forControlEvents:UIControlEventTouchUpInside];
    [nextBT setImageEdgeInsets:UIEdgeInsetsMake(9, 9, 9, 9)];

    
    UIButton *voiceBT = [UIButton bb_btMakeWithSuperV:bottomV imageName:@"music_play_voice"];
    voiceBT.frame = CGRectMake(20, toggleY+5, 40, 40);
    [voiceBT addTarget:self action:@selector(voiceAction) forControlEvents:UIControlEventTouchUpInside];
    [voiceBT setImageEdgeInsets:UIEdgeInsetsMake(9, 5, 9, 5)];
    
    self.cycleButton = [UIButton bb_btMakeWithSuperV:bottomV imageName:@"music_play_order"];
    self.cycleButton.frame = CGRectMake(_k_w-20-40, toggleY+5, 40, 40);
    [self.cycleButton addTarget:self action:@selector(cycleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.cycleButton setImageEdgeInsets:UIEdgeInsetsMake(9, 9, 9, 9)];
}
-(void)voiceAction
{
    
}
#pragma mark --- 播放or暂停
-(void)playOrSuspendAction
{
    if (_musicIsPlaying) {
        [_streamer pause];
    } else {
        [_streamer play];
    }
}

-(void)previousAction
{
    if (_musics.count == 1) {
        [QMUITips showWithText:@"已经是第一首歌曲了"];
        return;
    }
    if (_musicCycleType == MusicCycleTypeShuffle && _musics.count > 2) {
        [self setupRandomMusicIfNeed];
    } else {
        NSInteger firstIndex = 0;
        if (_currentIndex == firstIndex || [self currentIndexIsInvalid]) {
            self.currentIndex = _musics.count - 1;
        } else {
            self.currentIndex--;
        }
    }
    
    [self setupStreamer];
}
-(void)nextAction
{
    if (_musics.count == 1) {
        [self showMiddleHint:@"已经是最后一首歌曲"];
        return;
    }
    if (_musicCycleType == MusicCycleTypeShuffle && _musics.count > 2) {
        [self setupRandomMusicIfNeed];
    } else {
        [self checkNextIndexValue];
    }
    
    [self setupStreamer];
}
-(void)cycleAction
{
    switch (_musicCycleType) {
        case MusicCycleTypeLoopAll: {
            self.musicCycleType = MusicCycleTypeShuffle;
            [self showMiddleHint:@"随机播放"]; } break;
        case MusicCycleTypeShuffle: {
            self.musicCycleType = MusicCycleTypeLoopSingle;
            [self showMiddleHint:@"单曲循环"]; } break;
        case MusicCycleTypeLoopSingle: {
            self.musicCycleType = MusicCycleTypeLoopAll;
            [self showMiddleHint:@"列表循环"]; } break;
            
        default:
            break;
    }
    
    [GVUserDefaults standardUserDefaults].musicCycleType = self.musicCycleType;
}
-(void)dismissAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

+(instancetype)sharedInstance
{
    static BBMusicViewController *_sharedMusicVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedMusicVC = [[BBMusicViewController alloc]init];;
        _sharedMusicVC.streamer = [[DOUAudioStreamer alloc] init];
    });
    
    return _sharedMusicVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self adapterIphone4];
    _musicDurationTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateSliderValue:) userInfo:nil repeats:YES];
    _currentIndex = self.playingIndex;
//    _musicIndicator = [MusicIndicator sharedInstance];
    _originArray = [NSMutableArray array];
    _randomArray = [NSMutableArray array];
    
    [self creatUI];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self remoteControlEventHandler];
    _musicCycleType = [GVUserDefaults standardUserDefaults].musicCycleType;
    [self setupRadioMusicIfNeeded];
    
    if (_dontReloadMusic && _streamer) {
        return;
    }
    _currentIndex = self.playingIndex;
    
    [_originArray removeAllObjects];
    [self loadOriginArrayIfNeeded];
    
    [self createStreamer];
}
- (void)remoteControlEventHandler
{
    // 直接使用sharedCommandCenter来获取MPRemoteCommandCenter的shared实例
    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
    
    // 启用播放命令 (锁屏界面和上拉快捷功能菜单处的播放按钮触发的命令)
    commandCenter.playCommand.enabled = YES;
    // 为播放命令添加响应事件, 在点击后触发
    [commandCenter.playCommand addTarget:self action:@selector(playAction)];
    
    // 播放, 暂停, 上下曲的命令默认都是启用状态, 即enabled默认为YES
    // 为暂停, 上一曲, 下一曲分别添加对应的响应事件
    [commandCenter.pauseCommand addTarget:self action:@selector(pauseAction)];
    //    [commandCenter.previousTrackCommand addTarget:self action:@selector(previousTrackAction:)];
    //    [commandCenter.nextTrackCommand addTarget:self action:@selector(nextTrackAction:)];
    
    // 启用耳机的播放/暂停命令 (耳机上的播放按钮触发的命令)
    commandCenter.togglePlayPauseCommand.enabled = YES;
    // 为耳机的按钮操作添加相关的响应事件
    //    [commandCenter.togglePlayPauseCommand addTarget:self action:@selector(playOrPauseAction:)];
    
    MPSkipIntervalCommand *skipBackwardIntervalCommand = [commandCenter skipBackwardCommand];
    [skipBackwardIntervalCommand setEnabled:YES];
    [skipBackwardIntervalCommand addTarget:self action:@selector(skipBackwardEvent)];
    skipBackwardIntervalCommand.preferredIntervals = @[@(30)];  // 设置快进时间
    
    MPSkipIntervalCommand *skipForwardIntervalCommand = [commandCenter skipForwardCommand];
    skipForwardIntervalCommand.preferredIntervals = @[@(30)];  // 倒退时间 最大 99
    [skipForwardIntervalCommand setEnabled:YES];
    [skipForwardIntervalCommand addTarget:self action:@selector(skipForwardEvent)];
}
-(void)setNowPlayingInfoCenter
{
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        //        MusicEntity *music = [MusicViewController sharedInstance].currentPlayingMusic;
        AVURLAsset *audioAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:_music.play_url_with_token] options:nil];
        CMTime audioDuration = audioAsset.duration;
        float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
        NSLog(@"%@ audioDurationSeconds %@",[NSString timeIntervalToMMSSFormat:[[BBMusicViewController sharedInstance].streamer currentTime]],[NSString timeIntervalToMMSSFormat:audioDurationSeconds]);
        
        [dict setObject:_music.name forKey:MPMediaItemPropertyTitle];
        [dict setObject:_music.author forKey:MPMediaItemPropertyArtist];
        [dict setObject:_musicTitle forKey:MPMediaItemPropertyAlbumTitle];
        [dict setObject:@(audioDurationSeconds) forKey:MPMediaItemPropertyPlaybackDuration];
        
        [dict setObject:[NSNumber numberWithDouble:[_streamer currentTime]] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime]; //音乐当前已经播放时间
        [dict setObject:[NSNumber numberWithFloat:1.0] forKey:MPNowPlayingInfoPropertyPlaybackRate];//进度光标的速度 （这个随 自己的播放速率调整，我默认是原速播放）
        
        
        
        
        CGFloat playerAlbumWidth = (SCREEN_WIDTH - 16) * 2;
        UIImageView *playerAlbum = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, playerAlbumWidth, playerAlbumWidth)];
        UIImage *placeholderImage = [UIImage imageNamed:@"music_lock_screen_placeholder"];
        NSURL *URL = [BaseHelper qiniuImageCenter:_music.icon
                                        withWidth:[NSString stringWithFormat:@"%.f", playerAlbumWidth]
                                       withHeight:[NSString stringWithFormat:@"%.f", playerAlbumWidth]];
        NSLog(@"%@ URL",URL);
        [playerAlbum sd_setImageWithURL:URL
                       placeholderImage:placeholderImage
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  if (!image) {
                                      image = [UIImage new];
                                      image = placeholderImage;
                                  }
                                  
                                  //                                  NSLog(@"%@ error",error);
                                  MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
                                  playerAlbum.contentMode = UIViewContentModeScaleAspectFill;
                                  [dict setObject:artwork forKey:MPMediaItemPropertyArtwork];
                                  [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
                              }];
        //        [playerAlbum sd_setImageWithURL:URL placeholderImage:placeholderImage];
        //        playerAlbum.contentMode = UIViewContentModeScaleAspectFill;
        //        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
        
    }
}
-(void)pauseAction
{
    NSLog(@"播放");
    [[BBMusicViewController sharedInstance].streamer pause];
}
-(void)playAction
{
    [[BBMusicViewController sharedInstance].streamer play];
}
-(void)skipBackwardEvent
{
    if (_streamer.status == DOUAudioStreamerFinished) {
        _streamer = nil;
        
        [self createStreamer];
        
    }
    
    [_streamer setCurrentTime:[_streamer currentTime]-30];
    NSLog(@"%f [_streamer currentTime]-30",[_streamer currentTime]-30);
    [self updateProgressLabelValue];
    [self updateNowPlayingInfoCenterTime];
}
-(void)skipForwardEvent
{
    if (_streamer.status == DOUAudioStreamerFinished) {
        _streamer = nil;
        
        [self createStreamer];
        
    }
    NSLog(@"%f [_streamer currentTime]-30",[_streamer currentTime]+30);
    [_streamer setCurrentTime:[_streamer currentTime]+30];
    [self updateProgressLabelValue];
    [self updateNowPlayingInfoCenterTime];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    _dontReloadMusic = YES;
}

- (void)loadOriginArrayIfNeeded {
    if (_originArray.count == 0) {
        for (int i = 0; i < _musics.count; i++) {
            [_originArray addObject:[NSNumber numberWithInt:i]];
        }
        NSNumber *currentNum = [NSNumber numberWithInteger:_currentIndex];
        if ([_originArray containsObject:currentNum]) {
            [_originArray removeObject:currentNum];
        }
    }
}

# pragma mark - Basic setup

//- (void)adapterIphone4 {
//    if (IS_IPHONE_4_OR_LESS) {
//        CGFloat margin = 65;
//        _albumImageLeftConstraint.constant = margin;
//        _albumImageRightConstraint.constant = margin;
//    }
//}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    [self setupMusicViewWithMusic:_musics[currentIndex]];
}

- (void)setupMusicViewWithMusic:(BBMusic *)music {
    _music = music;
    _musicNameLabel.text = music.name;
    _singerLabel.text = music.author;
    _musicTitleLabel.text = _musicTitle;
    [self setupBackgroudImage];
}

- (void)setMusicCycleType:(MusicCycleType)musicCycleType {
    _musicCycleType = musicCycleType;
    [self updateMusicCycleButton];
}

- (void)updateMusicCycleButton {
    switch (_musicCycleType) {
        case MusicCycleTypeLoopAll:
            [_cycleButton setImage:[UIImage imageNamed:@"music_play_order"] forState:UIControlStateNormal];
            break;
        case MusicCycleTypeShuffle:
            [_cycleButton setImage:[UIImage imageNamed:@"music_play_random"] forState:UIControlStateNormal];
            break;
        case MusicCycleTypeLoopSingle:
            [_cycleButton setImage:[UIImage imageNamed:@"music_play_singlecycle"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

- (void)setupRadioMusicIfNeeded {
    [self updateMusicCycleButton];
    [self checkCurrentIndex];
}


- (void)setupBackgroudImage {
    _albumImageView.layer.cornerRadius = 7;
    _albumImageView.layer.masksToBounds = YES;
    
    NSString *imageWidth = [NSString stringWithFormat:@"%.f", (SCREEN_WIDTH - 70) * 2];
    NSURL *imageUrl = [BaseHelper qiniuImageCenter:_music.icon withWidth:imageWidth withHeight:imageWidth];
    [_backgroudImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"music_placeholder"]];
    [_albumImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"music_placeholder"]];
    
    if(![_visualEffectView isDescendantOfView:_backgroudView]) {
        UIVisualEffect *blurEffect;
        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _visualEffectView.frame = self.view.bounds;
        [_backgroudView addSubview:_visualEffectView];
        [_backgroudView addSubview:self.visualEffectView];
    }
    
    [_backgroudImageView startTransitionAnimation];
    [_albumImageView startTransitionAnimation];
}



# pragma mark - Music Action

- (IBAction)didTouchDismissButton:(id)sender {
    __weak typeof(self) weakSelf = self;
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        weakSelf.dontReloadMusic = NO;
        weakSelf.lastMusicUrl = [weakSelf currentPlayingMusic].play_url_with_token.mutableCopy;
    }];
}


- (IBAction)didTouchMusicCycleButton:(id)sender {
    switch (_musicCycleType) {
        case MusicCycleTypeLoopAll: {
            self.musicCycleType = MusicCycleTypeShuffle;
            [self showMiddleHint:@"随机播放"]; } break;
        case MusicCycleTypeShuffle: {
            self.musicCycleType = MusicCycleTypeLoopSingle;
            [self showMiddleHint:@"单曲循环"]; } break;
        case MusicCycleTypeLoopSingle: {
            self.musicCycleType = MusicCycleTypeLoopAll;
            [self showMiddleHint:@"列表循环"]; } break;
            
        default:
            break;
    }
    
    [GVUserDefaults standardUserDefaults].musicCycleType = self.musicCycleType;
}

- (void)setMusicIsPlaying:(BOOL)musicIsPlaying {
    _musicIsPlaying = musicIsPlaying;
    if (_musicIsPlaying) {
        [_toggleButton setImage:[UIImage imageNamed:@"music_play_playing"] forState:UIControlStateNormal];
    } else {
        [_toggleButton setImage:[UIImage imageNamed:@"music_play_suspend"] forState:UIControlStateNormal];
    }
}

- (IBAction)didTouchMoreButton:(id)sender {
    
}

# pragma mark - Musics delegate

- (void)playMusicWithSpecialIndex:(NSInteger)index {
    _currentIndex = index;
    
    [self createStreamer];
    
}


- (IBAction)didChangeMusicSliderValue:(id)sender {
    if (_streamer.status == DOUAudioStreamerFinished) {
        _streamer = nil;
        
        [self createStreamer];
        
    }
    
    [_streamer setCurrentTime:[_streamer duration] * _musicSlider.value];
    [self updateProgressLabelValue];
    [self updateNowPlayingInfoCenterTime];
}

- (IBAction)playPreviousMusic:(id)sender {
    if (_musics.count == 1) {
        [self showMiddleHint:@"已经是第一首歌曲"];
        return;
    }
    if (_musicCycleType == MusicCycleTypeShuffle && _musics.count > 2) {
        [self setupRandomMusicIfNeed];
    } else {
        NSInteger firstIndex = 0;
        if (_currentIndex == firstIndex || [self currentIndexIsInvalid]) {
            self.currentIndex = _musics.count - 1;
        } else {
            self.currentIndex--;
        }
    }
    
    [self setupStreamer];
}

- (IBAction)playNextMusic:(id)sender {
    if (_musics.count == 1) {
        [self showMiddleHint:@"已经是最后一首歌曲"];
        return;
    }
    if (_musicCycleType == MusicCycleTypeShuffle && _musics.count > 2) {
        [self setupRandomMusicIfNeed];
    } else {
        [self checkNextIndexValue];
    }
    
    [self setupStreamer];
}

- (void)checkNextIndexValue {
    NSInteger lastIndex = _musics.count - 1;
    if (_currentIndex == lastIndex || [self currentIndexIsInvalid]) {
        self.currentIndex = 0;
    } else {
        self.currentIndex++;
    }
}

# pragma mark - Setup streamer

- (void)setupRandomMusicIfNeed {
    [self loadOriginArrayIfNeeded];
    int t = arc4random()%_originArray.count;
    _randomArray[0] = _originArray[t];
    _originArray[t] = _originArray.lastObject;
    [_originArray removeLastObject];
    self.currentIndex = [_randomArray[0] integerValue];
}


- (void)setupStreamer {
    
    [self createStreamer];
    
}

# pragma mark - Check Current Index

- (BOOL)currentIndexIsInvalid {
    return _currentIndex >= _musics.count;
}

- (void)checkCurrentIndex {
    if ([self currentIndexIsInvalid]) {
        _currentIndex = 0;
    }
}

# pragma mark - Handle Music Slider

- (void)updateSliderValue:(id)timer {
    if (!_streamer) {
        return;
    }
    if (_streamer.status == DOUAudioStreamerFinished) {
        [_streamer play];
    }
    [self updateNowPlayingInfoCenterTime];
    if ([_streamer duration] == 0.0) {
        [_musicSlider setValue:0.0f animated:NO];
        
    } else {
        if (_streamer.currentTime >= _streamer.duration) {
            _streamer.currentTime -= _streamer.duration;
        }
        
        [_musicSlider setValue:[_streamer currentTime] / [_streamer duration] animated:YES];
        [self updateProgressLabelValue];
        
        
    }
    
}
-(void)updateNowPlayingInfoCenterTime
{
    //    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[[MPNowPlayingInfoCenter defaultCenter] nowPlayingInfo]];
    //    [dict setObject:_musicEntity.name forKey:MPMediaItemPropertyTitle];
    //    [dict setObject:_musicEntity.artistName forKey:MPMediaItemPropertyArtist];
    //    [dict setObject:_musicTitle forKey:MPMediaItemPropertyAlbumTitle];
    //    [dict setObject:[NSNumber numberWithDouble:[_streamer currentTime]] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime]; //音乐当前已经过时间
    //    [dict setObject:[NSNumber numberWithDouble:[_streamer duration]] forKey:MPMediaItemPropertyPlaybackDuration];
    //    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    
    
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        //        MusicEntity *music = [MusicViewController sharedInstance].currentPlayingMusic;
        //        AVURLAsset *audioAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:_musicEntity.musicUrl] options:nil];
        //        CMTime audioDuration = audioAsset.duration;
        //        float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
        //        NSLog(@"%@ audioDurationSeconds %@",[NSString timeIntervalToMMSSFormat:[[MusicViewController sharedInstance].streamer currentTime]],[NSNumber numberWithDouble:[_streamer duration]]);
        
        [dict setObject:_music.name forKey:MPMediaItemPropertyTitle];
        [dict setObject:_music.author forKey:MPMediaItemPropertyArtist];
        [dict setObject:_musicTitle forKey:MPMediaItemPropertyAlbumTitle];
        [dict setObject:[NSNumber numberWithDouble:[_streamer duration]] forKey:MPMediaItemPropertyPlaybackDuration];
        
        [dict setObject:[NSNumber numberWithDouble:[_streamer currentTime]] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime]; //音乐当前已经播放时间
        [dict setObject:[NSNumber numberWithFloat:1.0] forKey:MPNowPlayingInfoPropertyPlaybackRate];//进度光标的速度 （这个随 自己的播放速率调整，我默认是原速播放）
        
        
        
        
        CGFloat playerAlbumWidth = (SCREEN_WIDTH - 16) * 2;
        UIImageView *playerAlbum = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, playerAlbumWidth, playerAlbumWidth)];
        UIImage *placeholderImage = [UIImage imageNamed:@"music_lock_screen_placeholder"];
        NSURL *URL = [BaseHelper qiniuImageCenter:_music.icon
                                        withWidth:[NSString stringWithFormat:@"%.f", playerAlbumWidth]
                                       withHeight:[NSString stringWithFormat:@"%.f", playerAlbumWidth]];
        //        NSLog(@"%@ URL",URL);
        [playerAlbum sd_setImageWithURL:URL
                       placeholderImage:placeholderImage
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  if (!image) {
                                      image = [UIImage new];
                                      image = placeholderImage;
                                  }
                                  
                                  //                                  NSLog(@"%@ error",error);
                                  MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
                                  playerAlbum.contentMode = UIViewContentModeScaleAspectFill;
                                  [dict setObject:artwork forKey:MPMediaItemPropertyArtwork];
                                  [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
                              }];
        //        [playerAlbum sd_setImageWithURL:URL placeholderImage:placeholderImage];
        //        playerAlbum.contentMode = UIViewContentModeScaleAspectFill;
        //        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
        
    }
}
- (void)updateProgressLabelValue {
    _beginTimeLabel.text = [NSString timeIntervalToMMSSFormat:_streamer.currentTime];
    _endTimeLabel.text = [NSString timeIntervalToMMSSFormat:_streamer.duration];
}

- (void)updateBufferingStatus {
    
}

- (void)invalidMusicDurationTimer {
    if ([_musicDurationTimer isValid]) {
        [_musicDurationTimer invalidate];
    }
    _musicDurationTimer = nil;
}

# pragma mark - Audio Handle

- (void)createStreamer {
    if (_specialIndex > 0) {
        _currentIndex = _specialIndex;
        _specialIndex = 0;
    }
    
    [self setupMusicViewWithMusic:_musics[_currentIndex]];
    [self loadPreviousAndNextMusicImage];
    
    //    [MusicHandler configNowPlayingInfoCenter];
    [self setNowPlayingInfoCenter];
    
    Track *track = [[Track alloc] init];
    
//    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:_musicEntity.fileName ofType: @"mp3"];
//    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];
//    NSLog(@"%@ MP3路径",soundFilePath);
//    track.audioFileURL = [NSURL URLWithString:@"http://aod.tx.xmcdn.com/group34/M06/10/EB/wKgJYFoIZqyBBE3FAD7DQUdalpc987.mp3"];
//    track.audioFileURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?token=%@",_music.play_url,[GVUserDefaults standardUserDefaults].deviceToken]];

//    track.audioFileURL = [NSURL URLWithString:@"http://cdn.open.idaddy.cn/apsmp3/51d2/ydazn00000000001/201805270000/0/ADcGN1AzDTc.YS8yLzh0dXJuOHY0LmF1ZGlv.mp3?token=221aIwL2fb4HGmacjbuXlA.Mw03QzlBRDA3Ny1GNURFLTRFQzUtOTYxMy0xQTQ0RDIwNzc1QkUNMTgwNjI2"];
    track.audioFileURL = [NSURL URLWithString:_music.play_url_with_token];
    
    @try {
        [self removeStreamerObserver];
    } @catch(id anException){
    }
    
    _streamer = nil;
    _streamer = [DOUAudioStreamer streamerWithAudioFile:track];
    
    [self addStreamerObserver];
    [self.streamer play];
}

- (void)removeStreamerObserver {
    [_streamer removeObserver:self forKeyPath:@"status"];
    [_streamer removeObserver:self forKeyPath:@"duration"];
    [_streamer removeObserver:self forKeyPath:@"bufferingRatio"];
}

- (void)addStreamerObserver {
    [_streamer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
    [_streamer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
    [_streamer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == kStatusKVOKey) {
        [self performSelector:@selector(updateStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    } else if (context == kDurationKVOKey) {
        [self performSelector:@selector(updateSliderValue:)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
        ;
        
    } else if (context == kBufferingRatioKVOKey) {
        [self performSelector:@selector(updateBufferingStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateStatus
{
    self.musicIsPlaying = NO;
    _musicIndicator.state = NAKPlaybackIndicatorViewStateStopped;
    switch ([_streamer status]) {
        case DOUAudioStreamerPlaying:
            self.musicIsPlaying = YES;
            _musicIndicator.state = NAKPlaybackIndicatorViewStatePlaying;
            break;
            
        case DOUAudioStreamerPaused:
            break;
            
        case DOUAudioStreamerIdle:
            break;
            
        case DOUAudioStreamerFinished:
            if (_musicCycleType == MusicCycleTypeLoopSingle) {
                [_streamer play];
            } else {
                [self playNextMusic:nil];
            }
            break;
            
        case DOUAudioStreamerBuffering:
            _musicIndicator.state = NAKPlaybackIndicatorViewStatePlaying;
            break;
            
        case DOUAudioStreamerError:
            break;
    }
//    [self updateMusicsCellsState];
}



# pragma mark - Musics Delegate

//- (void)updateMusicsCellsState {
//    if (_delegate && [_delegate respondsToSelector:@selector(updatePlaybackIndicatorOfVisisbleCells)]) {
//        [_delegate updatePlaybackIndicatorOfVisisbleCells];
//    }
//}

# pragma mark - Music convenient method

- (void)loadPreviousAndNextMusicImage {
    [MusicHandler cacheMusicCovorWithMusicEntities:_musics currentIndex:_currentIndex];
}

# pragma mark - HUD

- (void)showMiddleHint:(NSString *)hint {
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.labelFont = [UIFont systemFontOfSize:15];
    hud.margin = 10.f;
    hud.yOffset = 0;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

# pragma mark - Public Method

- (BBMusic *)currentPlayingMusic {
    if (_musics.count == 0) {
        _musics = nil;
    }
    
    return _musics[_currentIndex];
}


@end

