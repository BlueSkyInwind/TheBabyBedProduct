//
//  BBWarningRingSettingViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBWarningRingSettingViewController.h"
#import "BBWarningRingListCell.h"
#import "DOUAudioStreamer.h"
#import "Track.h"

static void *kStatusKVOKey = &kStatusKVOKey;

@interface BBWarningRingSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _selecteIndex;
}
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray<NSString *> *ringCNNames;
@property(nonatomic,strong) NSMutableArray<NSString *> *ringENNames;
@property(nonatomic, strong) DOUAudioStreamer *streamer;

@end

@implementation BBWarningRingSettingViewController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.streamer) {
        [self.streamer stop];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = rgb(247, 249, 251, 1);
    _selecteIndex = 0;
    [self creatTableVUI];
    [self createStreamer];
}
-(void)creatTableVUI
{
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:self.view.bounds delegate:self bgColor:rgb(247, 249, 251, 1) style:UITableViewStylePlain];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ringCNNames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBWarningRingListCell *cell = [BBWarningRingListCell bb_cellMakeWithTableView:tableView];
    if (self.ringCNNames.count > indexPath.row) {
        BOOL isCurrent = (indexPath.row == _selecteIndex);
        [cell setupCellWithRingName:self.ringCNNames[indexPath.row] isSelected:isCurrent];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isCurrent = (indexPath.row == _selecteIndex);
    if (isCurrent) {
        return;
    }
    _selecteIndex = indexPath.row;
    [self.tableView reloadData];

#warning toDo
    //此处应该还要播放下选中的警告铃声
    [self createStreamer];
}
- (void)createStreamer
{

    
//    [self setupMusicViewWithMusic:_musics[_currentIndex]];
//    [self loadPreviousAndNextMusicImage];
//    
//    //    [MusicHandler configNowPlayingInfoCenter];
//    [self setNowPlayingInfoCenter];
    
    Track *track = [[Track alloc] init];
    
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:self.ringENNames[_selecteIndex] ofType: @"mp3"];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];
        NSLog(@"通知铃声 %@ MP3路径",soundFilePath);
        track.audioFileURL = fileURL;
    //    track.audioFileURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?token=%@",_music.play_url,[GVUserDefaults standardUserDefaults].deviceToken]];
    
    //    track.audioFileURL = [NSURL URLWithString:@"http://cdn.open.idaddy.cn/apsmp3/51d2/ydazn00000000001/201805270000/0/ADcGN1AzDTc.YS8yLzh0dXJuOHY0LmF1ZGlv.mp3?token=221aIwL2fb4HGmacjbuXlA.Mw03QzlBRDA3Ny1GNURFLTRFQzUtOTYxMy0xQTQ0RDIwNzc1QkUNMTgwNjI2"];
//    track.audioFileURL = [NSURL URLWithString:_music.play_url_with_token];
    
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
//    [_streamer removeObserver:self forKeyPath:@"duration"];
//    [_streamer removeObserver:self forKeyPath:@"bufferingRatio"];
}

- (void)addStreamerObserver
{
    [_streamer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
//    [_streamer addObserver:self forKeyPath:@"duration" options:NSKeyValueObservingOptionNew context:kDurationKVOKey];
//    [_streamer addObserver:self forKeyPath:@"bufferingRatio" options:NSKeyValueObservingOptionNew context:kBufferingRatioKVOKey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == kStatusKVOKey) {
        [self performSelector:@selector(updateStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
//    else if (context == kDurationKVOKey) {
//        [self performSelector:@selector(updateSliderValue:)
//                     onThread:[NSThread mainThread]
//                   withObject:nil
//                waitUntilDone:NO];
//        ;
//
//    } else if (context == kBufferingRatioKVOKey) {
//        [self performSelector:@selector(updateBufferingStatus)
//                     onThread:[NSThread mainThread]
//                   withObject:nil
//                waitUntilDone:NO];
//    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateStatus
{
//    self.musicIsPlaying = NO;
//    _musicIndicator.state = NAKPlaybackIndicatorViewStateStopped;
    switch ([_streamer status]) {
        case DOUAudioStreamerPlaying:
//            self.musicIsPlaying = YES;
//            _musicIndicator.state = NAKPlaybackIndicatorViewStatePlaying;
            break;
            
        case DOUAudioStreamerPaused:
            break;
            
        case DOUAudioStreamerIdle:
            break;
            
        case DOUAudioStreamerFinished:
//            if (_musicCycleType == MusicCycleTypeLoopSingle) {
//                [_streamer play];
//            } else {
//                [self playNextMusic:nil];
//            }
            [_streamer stop];
            break;
            
        case DOUAudioStreamerBuffering:
//            _musicIndicator.state = NAKPlaybackIndicatorViewStatePlaying;
            break;
            
        case DOUAudioStreamerError:
            break;
    }
    //    [self updateMusicsCellsState];
}

-(NSMutableArray<NSString *> *)ringCNNames
{
    if (!_ringCNNames) {
        _ringCNNames = [NSMutableArray array];
        [_ringCNNames addObjectsFromArray:@[
                                          @"铃声一",
                                          @"铃声二",
                                          @"铃声三",
                                          @"铃声四",
                                          @"铃声五"
                                          ]];
    }
    return _ringCNNames;
}

-(NSMutableArray<NSString *> *)ringENNames
{
    if (!_ringENNames) {
        _ringENNames = [NSMutableArray array];
        [_ringENNames addObjectsFromArray:@[
                                            @"dadadada",
                                            @"didu",
                                            @"mytheme",
                                            @"storystory",
                                            @"supermali"
                                            ]];
    }
    return _ringENNames;
}

@end
