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
    self.view.backgroundColor = k_color_vcBg;
    self.titleStr = @"声音选择";
    _selecteIndex = 0;
    [self creatTableVUI];
    [self createStreamer];
}
-(void)creatTableVUI
{
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectMake(0, PPDevice_navBarHeight, _k_w, _k_h-PPDevice_navBarHeight) delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    
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
    
    Track *track = [[Track alloc] init];
    
        NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:self.ringENNames[_selecteIndex] ofType: @"mp3"];
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];
        NSLog(@"通知铃声 %@ MP3路径",soundFilePath);
        track.audioFileURL = fileURL;
    
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
}

- (void)addStreamerObserver
{
    [_streamer addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:kStatusKVOKey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (context == kStatusKVOKey) {
        [self performSelector:@selector(updateStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateStatus
{

    switch ([_streamer status]) {
        case DOUAudioStreamerPlaying:
            break;
            
        case DOUAudioStreamerPaused:
            break;
            
        case DOUAudioStreamerIdle:
            break;
            
        case DOUAudioStreamerFinished:
            [_streamer stop];
            break;
            
        case DOUAudioStreamerBuffering:
            break;
            
        case DOUAudioStreamerError:
            break;
    }
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
