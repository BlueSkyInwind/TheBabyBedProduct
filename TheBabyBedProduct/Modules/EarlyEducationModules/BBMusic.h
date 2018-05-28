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
@end
/*
 
 {
 "age_from" = "-1";
 "age_to" = 5;
 author = "渡渡鸟";
 bitrate = 64000;
 description = "这是一则给不爱睡觉的小朋友的故事，如果你总是为了让孩子早些入睡伤透了脑筋，那就赶紧让孩子听听这个充满想象力的安静故事吧！";
 duration = 823;
 "editor_comment" = "主播鱼淼淼真情演绎的原创精品故事，欢迎关注我们后续的其他原创故事";
 filesize = 6586651;
 "has_chapter" = 0;
 icon = "http://img.ilisten.idaddy.cn/b/7/9ow5gusy.jpg";
 id = ADQGN1A9DTI;
 lyrics = "从前，有个不爱睡觉的小猴子，
 \n
 \n一到了睡觉时间，它就在森林里到处蹦跳，不肯睡觉，
 \n
 \n猴子妈妈为了哄它睡觉，给它讲故事，唱儿歌，玩游戏，
 \n
 \n可小猴子还在精神的翻着筋斗，不肯睡觉。
 \n
 \n猴子妈妈累了，她对小猴子说：“好，你别打扰妈妈和爸爸，我们要睡了，你自己玩儿吧，喜欢睡就睡，喜欢给它讲故事，唱儿歌，玩游戏，
 \n
 \n可小猴子还在精神的翻着筋斗，不肯睡觉。
 \n
 \n猴子妈妈累了，她对小猴子说：“好，你别打扰妈妈和爸爸，我们要睡了，你自己玩儿吧，喜欢睡就睡，喜欢\347\216玩儿就玩儿。”
 \n\t
 \n小猴子特别高兴，它终于可以不用睡觉，自由自在的玩儿了！\t
 \n
 \n小猴子的家在一棵枝繁叶茂的大树上。
 \n
 \n大树上的邻居还有鸟妈妈一家。
 \n
 \n小猴子不睡觉就去树杈的给它讲故事，唱儿歌，玩游戏，
 \n
 \n可小猴子还在精神的翻着筋斗，不肯睡觉。
 \n
 \n猴子妈妈累了，她对小猴子说：“好，你别打扰妈妈和爸爸，我们要睡了，你自己玩儿吧，喜欢睡就睡，喜欢\347\216玩儿就玩儿。”
 \n\t
 \n小猴子特别高兴，它终于可以不用睡觉，自由自在的玩儿了！\t
 \n
 \n小猴子的家在一棵枝繁叶茂的大树上。
 \n
 \n大树上的邻居还有鸟妈妈一家。
 \n
 \n小猴子不睡觉就去树杈的\351\270鸟妈妈家找小鸟宝宝玩儿。
 \n
 \n小鸟宝宝才刚刚出生几天，
 \n
 \n黄黄的嘴巴，毛绒绒的羽毛，
 \n
 \n还有一双眼睛还没有完全睁开，只知道张着大嘴，“唧唧”叫着找吃的。
 \n
 \n小猴子，非常非常喜欢可爱的小鸟宝宝。
 \n
 \n它去敲敲鸟妈妈家的门，咚咚咚 咚咚咚
 \n
 \n“喳喳，是谁呀？”鸟妈妈问。
 \n
 \n“我是小猴子，我想跟小鸟宝宝玩儿！”
 \n
 \n“小鸟宝宝睡了，明天再玩儿吧！喳喳！”鸟妈妈说到。
 \n
 \n小猴子只好自己在树上荡秋千，折跟头，打把势，
 \n
 \n夜风吹过，小猴子把树叶弄的哗啦啦响，
 \n
 \n然后让落下的树叶，随着风去旅行，
 \n
 \n树叶们在风中飘飘摇摇，装载着透过树冠缝隙的月光，
 \n
 \n像小飞机似的一片片飞了出去。
 \n
 \n小猴子开心极了，不睡觉真好！
 \n
 \n早晨，猴妈妈和猴爸爸要去给小猴子找食物，
 \n
 \n猴妈妈说：“小猴子，你夜里没睡觉，白天会过树冠缝隙的月光，
 \n
 \n像小飞机似的一片片飞了出去。
 \n
 \n小猴子开心极了，不睡觉真好！
 \n
 \n早晨，猴妈妈和猴爸爸要去给小猴子找食物，
 \n
 \n猴妈妈说：“小猴子，你夜里没睡觉，白天会\345\233困的，你就在家里等着吧！”
 \n
 \n“妈妈，我不困，白天了，我想和小鸟宝宝玩！”
 \n
 \n小猴子攀上枝头又去敲敲鸟妈妈家门。
 \n
 \n鸟妈妈对小猴子说，“小猴子，麻烦你陪陪鸟宝宝，我要去给宝宝去找食物。”
 \n
 \n小猴子点点头，开心的在树上陪伴鸟宝宝。
 \n
 \n鸟宝宝嘴张的很大，唧唧着要吃的。
 \n
 \n小猴子把自己的爪子，塞一根放在小鸟嘴里。
 \n
 \n小鸟的嘴含一含爪子，吐了出来，还是张大嘴唧唧唧唧唧唧。
 \n
 \n小猴子把自己的尾巴尖，塞到小鸟嘴里，
 \n“我要早早睡觉，白天我还要保护小鸟呢！我要陪小鸟玩儿！我要抓住那只狡猾的山猫，让它别再想吃我的朋友小鸟！”";
 md5 = 10b31fe543ffdb000fbf6950a2fe237d;
 name = "不爱睡觉的小猴子";
 performer = "鱼淼淼";
 "play_url" = "http://cdn.open.idaddy.cn/apsmp3/5d67/ydazn00000000001/201805260000/0/ADQGN1A9DTI.YS83L3BwaXJtNGNiLmF1ZGlv.mp3";
 "play_url_with_token" = "http://cdn.open.idaddy.cn/apsmp3/5d67/ydazn00000000001/201805260000/0/ADQGN1A9DTI.YS83L3BwaXJtNGNiLmF1ZGlv.mp3?token=3iNmTq49PMpVYMHlRamEsA.Mw03QzlBRDA3Ny1GNURFLTRFQzUtOTYxMy0xQTQ0RDIwNzc1QkUNMTgwNjI1";
 price = 0;
 rank = 9;
 status = 0;
 taxonomys = "2013年度精选集,儿童阅读从听开始,故事旅行记,睡前故事";
 },
 
 */

@interface BBMusicAudioinfos : NSObject
@property(nonatomic,strong) NSMutableArray *contents;
@end

@interface BBMusicResult : NSObject
@property(nonatomic,strong) BBMusicAudioinfos *audioinfos;
@property(nonatomic,assign) int retcode;
@end
