//
//  BBVideoPlayView.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/5/31.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBVideoPlayView : UIView

+(id)initBBVideoPlayView:(UIView *)superView videoUrl:(NSString *)videoUrl;

@end


@interface BBVideoPlayView (configureView)

-(void)palyVideo;
-(void)pauseVideo;

@end

