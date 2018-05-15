//
//  BBMusicHotRecommend.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/5/14.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBMusicHotRecommend : NSObject
@property(nonatomic,assign) BOOL has_chapter;
@property(nonatomic,copy) NSString *icon;
@property(nonatomic,copy) NSString *hotRecommendID;
@property(nonatomic,copy) NSString *md5;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *play_url;
@property(nonatomic,copy) NSString *play_url_with_token;
@property(nonatomic,copy) NSString *taxonomys;
@property(nonatomic,assign) NSInteger price;
@property(nonatomic,assign) NSInteger status;
@end
/*

 {
 "has_chapter" = 0;
 icon = "http://img.ilisten.idaddy.cn/b/2/ogu3gvjs.jpg";
 id = ADcGN1AzDTc;
 md5 = 102f087bd363bc220f1b3bb3ccb89afd;
 name = "\U5b9d\U8d1d\U4e56\U4e56\U7761";
 "play_url" = "http://cdn.open.idaddy.cn/apsmp3/2493/ydazn00000000001/201805140000/0/ADcGN1AzDTc.YS8yLzh0dXJuOHY0LmF1ZGlv.mp3";
 "play_url_with_token" = "http://cdn.open.idaddy.cn/apsmp3/2493/ydazn00000000001/201805140000/0/ADcGN1AzDTc.YS8yLzh0dXJuOHY0LmF1ZGlv.mp3?token=W1UQmxSFmAclPmavYdWgRw.Mw05RjIwOEVENy04NEJBLTRBNTQtQjU0RC1CNzZDRTFDMzU3MzYNMTgwNjEz";
 price = 0;
 status = 0;
 taxonomys = "2013\U5e74\U5ea6\U7cbe\U9009\U96c6,\U7761\U524d\U97f3\U4e50";
 },
 
 */

@interface BBMusicHotRecommendAudioinfos : NSObject
@property(nonatomic,strong) NSMutableArray *contents;
@end

@interface BBMusicHotRecommendResult : NSObject
@property(nonatomic,strong) BBMusicHotRecommendAudioinfos *audioinfos;
@property(nonatomic,assign) int retcode;
@end
