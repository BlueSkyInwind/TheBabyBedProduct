//
//  BBVideoPlayShare.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/5/31.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBVideoPlayShare.h"
@interface BBVideoPlayShare()
    
@property(atomic, retain) id<IJKMediaPlayback> player;
    
    

@end

@implementation BBVideoPlayShare

+(instancetype)shareInstance{
    static BBVideoPlayShare * payer = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        payer = [[BBVideoPlayShare alloc]init];
    });
    return payer;
}
- (instancetype)init
{
        self = [super init];
        if (self) {
            
        }
        return self;
}

-(void)createPlayer{
    
    if (self.player != nil){
        return;
    }
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    self.player = [[IJKFFMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString:@"rtmp://live.hkstv.hk.lxdns.com/live/hks"] withOptions:options];
    self.player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.player.scalingMode = IJKMPMovieScalingModeAspectFit;
    self.player.shouldAutoplay = YES;
    [ self.player  prepareToPlay];
    
}
-(void)startPlay{
    if (self.player){
        [self.player play];
    }
}
    
-(void)stopPlay{
    if (self.player){
        [self.player pause];
    }
}
    
    
    
    
    
    
    
    
    
@end
