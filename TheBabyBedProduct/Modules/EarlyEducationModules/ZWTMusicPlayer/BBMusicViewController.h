//
//  BBMusicViewController.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/5/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "BBMusic.h"

@interface BBMusicViewController : BaseViewController
@property (nonatomic, copy) NSString *musicTitle;
@property(nonatomic,strong) NSMutableArray<BBMusic *> *musics;
@property(nonatomic,assign) NSInteger playingIndex;
+ (instancetype)sharedInstance;
-(BBMusic *)currentPlayingMusic;
- (void)playMusicWithSpecialIndex:(NSInteger)index;
@end
