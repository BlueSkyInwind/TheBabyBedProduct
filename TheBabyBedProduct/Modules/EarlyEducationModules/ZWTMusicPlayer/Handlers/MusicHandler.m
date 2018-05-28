//
//  MusicHandler.m
//  Ting
//
//  Created by Aufree on 11/23/15.
//  Copyright © 2015 Ting. All rights reserved.
//

#import "MusicHandler.h"
#import "BBMusic.h"
#import "BBMusicViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "NSString+Additions.h"
#import "BaseHelper.h"
#import "SDImageCache.h"
#import "SDWebImageDownloader.h"
#import "UIImageView+WebCache.h"

@implementation MusicHandler

+ (void)cacheMusicCovorWithMusicEntities:(NSArray *)musicEntities currentIndex:(NSInteger)currentIndex {
    NSInteger previoudsIndex = currentIndex-1;
    NSInteger nextIndex = currentIndex+1;
    previoudsIndex = previoudsIndex < 0 ? 0 : previoudsIndex;
    nextIndex = nextIndex == musicEntities.count ? musicEntities.count - 1 : nextIndex;
    NSMutableArray *indexArray = @[].mutableCopy;
    [indexArray addObject:[NSNumber numberWithInteger:previoudsIndex]];
    [indexArray addObject:[NSNumber numberWithInteger:nextIndex]];
    for (NSNumber *indexNum in indexArray) {
        NSString *imageWidth = [NSString stringWithFormat:@"%.f", (SCREEN_WIDTH - 70) * 2];
        BBMusic *music = musicEntities[indexNum.integerValue];
        NSURL *imageUrl = [BaseHelper qiniuImageCenter:music.icon withWidth:imageWidth withHeight:imageWidth];
        UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:imageUrl.absoluteString];
        if (!image) {
            [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:imageUrl options:SDWebImageDownloaderUseNSURLCache progress:nil completed:nil];
        }
    }
}

+ (void)configNowPlayingInfoCenter {
    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        BBMusic *music = [BBMusicViewController sharedInstance].currentPlayingMusic;
        
        AVURLAsset *audioAsset = [AVURLAsset URLAssetWithURL:[NSURL URLWithString:music.play_url_with_token] options:nil];
        CMTime audioDuration = audioAsset.duration;
        float audioDurationSeconds = CMTimeGetSeconds(audioDuration);

        [dict setObject:music.name forKey:MPMediaItemPropertyTitle];
        [dict setObject:music.author forKey:MPMediaItemPropertyArtist];
        [dict setObject:[BBMusicViewController sharedInstance].musicTitle forKey:MPMediaItemPropertyAlbumTitle];
//        [dict setObject:@(audioDurationSeconds) forKey:MPMediaItemPropertyPlaybackDuration];
        
        [dict setObject:@0 forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime]; //音乐当前已经播放时间
        [dict setObject:[NSNumber numberWithFloat:1.0] forKey:MPNowPlayingInfoPropertyPlaybackRate];//进度光标的速度 （这个随 自己的播放速率调整，我默认是原速播放）
        [dict setObject:@100 forKey:MPMediaItemPropertyPlaybackDuration];//歌曲总时间设置
        
        
        
        CGFloat playerAlbumWidth = (SCREEN_WIDTH - 16) * 2;
        UIImageView *playerAlbum = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, playerAlbumWidth, playerAlbumWidth)];
        UIImage *placeholderImage = [UIImage imageNamed:@"music_lock_screen_placeholder"];
        NSURL *URL = [BaseHelper qiniuImageCenter:music.icon
                                        withWidth:[NSString stringWithFormat:@"%.f", playerAlbumWidth]
                                       withHeight:[NSString stringWithFormat:@"%.f", playerAlbumWidth]];
        [playerAlbum sd_setImageWithURL:URL
                       placeholderImage:placeholderImage
                              completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                  if (!image) {
                                      image = [UIImage new];
                                      image = placeholderImage;
                                  }
                                  MPMediaItemArtwork *artwork = [[MPMediaItemArtwork alloc] initWithImage:image];
                                  playerAlbum.contentMode = UIViewContentModeScaleAspectFill;
                                  [dict setObject:artwork forKey:MPMediaItemPropertyArtwork];
                                  [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
                              }];
        
    }
}

@end
