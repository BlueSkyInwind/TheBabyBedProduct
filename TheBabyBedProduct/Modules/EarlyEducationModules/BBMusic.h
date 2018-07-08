//
//  BBMusic.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/5/11.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBMusic : NSObject
@property(nonatomic,assign) BOOL has_chapter;
@property(nonatomic,copy) NSString *icon;            //1
@property(nonatomic,copy) NSString *musicID;         //1
@property(nonatomic,copy) NSString *md5;
@property(nonatomic,copy) NSString *name;            //1
@property(nonatomic,copy) NSString *play_url;
@property(nonatomic,copy) NSString *play_url_with_token;   //1
@property(nonatomic,copy) NSString *taxonomys;
@property(nonatomic,assign) NSInteger price;
@property(nonatomic,assign) NSInteger status;
@property(nonatomic,copy) NSString *author;      //1
@property(nonatomic,strong) NSNumber *age_from;
@property(nonatomic,strong) NSNumber *age_to;
@end

/*
{
    "age_from" = "-1";
    "age_to" = 4;
    author = "天天艺术";
    "chapter_count" = 10;
    description = "睡眠对每个人来说是非常重要的，尤其是婴幼儿！处于人生起步阶段的婴儿，睡眠时间的长短，睡眠质量的好坏，都直接影响着宝宝的身体发育和心智发展。良好的睡眠，可以促进宝宝的生长发育，增强宝宝智力和体力，增强宝宝的抗病能力。所以作为家长，需要细心关注宝宝睡眠，给宝宝香甜安稳的美觉。本辑收录了中外著名的幼儿音乐，体裁新颖，音乐轻柔舒缓。让宝宝在美妙的音乐中，自然进入梦乡。";
    "editor_comment" = "该辑音乐为《我的第一套古典音乐CD》的7张CD专辑之一。
    \n这套产品精选60首最适合宝宝聆听的古典音乐经典篇章，每首音乐开始都有有趣的童话故事引导宝宝进入音乐世界，调节宝宝体内的生物节律，刺激大脑皮层活动，调节大脑功能，促进宝宝大脑和感觉器官的发育，提高宝宝的思维能力，培养宝宝音乐节奏感、哼唱乐曲的模仿能力，是帮助宝宝敲开音乐大门的魔法石。";
    "has_chapter" = 1;
    icon = "http://img.ilisten.idaddy.cn/b/5/g9fno7qy.jpg";
    id = ADEGNFA9DTA;
    name = "宝宝睡前音乐";
    performer = "天天艺术";
    price = 599;
    rank = "8.800000000000001";
    status = 0;
    taxonomys = "古典音乐,睡前音乐,精品音乐,胎教音乐,音乐启蒙";
},
{
    "age_from" = "-1";
    "age_to" = 0;
    author = "佚名";
    "chapter_count" = 10;
    description = "爱因斯坦说过：没有早期音乐教育，干什么事我都会一事无成。音乐胎教是大多数孕妈妈进行胎教的首选。用灵动的音乐带着孕妈妈和宝宝进行一段打开心扉的音乐之旅。国外名曲让音乐胎教时光更富情趣。";
    "editor_comment" = "每一对父母都知道音乐胎教的好处。但是你可知道如何让宝宝感知一段美好的旋律？你可知道如何与宝宝在音乐声中交流情感？外国篇胎教音乐精选10首最经典的动人音乐，让孕妈妈在舒缓的音乐中陶冶情操。";
    "has_chapter" = 1;
    icon = "http://img.ilisten.idaddy.cn/b/0/kl23qvg2.jpg";
    id = ADAGP1A1DTU;
    name = "胎教音乐：中国篇1";
    performer = "九通";
    price = 299;
    rank = "9.5";
    status = 0;
    taxonomys = "VIP畅销故事,九通胎教系列,古典音乐,胎教音乐,胎教音乐";
},
{
    "age_from" = "-1";
    "age_to" = 16;
    author = "佚名";
    bitrate = 64001;
    description = "这首小夜曲色彩明朗，轻快的漫步节奏和娓娓动听的旋律，具有一种典雅质朴的情调，表现了无忧无虑的意境。在展开过程中的旋律进行，时而出现极其自然的大跳音程，使曲调更富于生气。";
    duration = 194;
    "editor_comment" = "";
    filesize = 1553796;
    "has_chapter" = 0;
    icon = "http://img.ilisten.idaddy.cn/b/6/ow6qr1j.jpg";
    id = ADAGPlAwDTM;
    lyrics = "";
    md5 = bbeba440d91c7e1536c63f3c9f4b6069;
    name = "海顿小夜曲";
    performer = "";
    "play_url" = "http://cdn.open.idaddy.cn/apsmp3/f4f2/ydazn00000000001/201806050000/0/ADAGPlAwDTM.YTY0LzYva3h1ZGY0a2suYXVkaW8.mp3";
    "play_url_with_token" = "http://cdn.open.idaddy.cn/apsmp3/f4f2/ydazn00000000001/201806050000/0/ADAGPlAwDTM.YTY0LzYva3h1ZGY0a2suYXVkaW8.mp3?token=7I6rzN5vxSfyUHs4qKg1DA.Mw1ENjgxMTQ4OC02NDNCLTQ4MzUtQTM2RS0zMjkzOTdENUMxQzANMTgwNzA0";
    price = 0;
    rank = "9.1";
    status = 0;
    taxonomys = "胎教音乐,古典音乐,音乐启蒙,小提琴曲,器乐欣赏";
}
);
*/
@interface BBMusicAudioinfos : NSObject
@property(nonatomic,strong) NSMutableArray *contents;
@end

@interface BBMusicResult : NSObject
@property(nonatomic,strong) BBMusicAudioinfos *audioinfos;
@property(nonatomic,assign) int retcode;
@end
