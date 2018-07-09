//
//  BBEarlyEducationMusicListViewController.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/9.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BaseViewController.h"
@class BBMusicCategory;
@class BBMusic;

typedef NS_ENUM(NSInteger,BBEarlyEducationMusicListVCForType) {
    BBEarlyEducationMusicListVCForTypeHotRecommend = 0,    //热门推荐
    BBEarlyEducationMusicListVCForTypeCategory             //分类
};

@interface BBEarlyEducationMusicListViewController : BaseViewController
@property(nonatomic,copy) NSString *musicListName;
@property(nonatomic,strong) BBMusicCategory *aMusicCategory;
/** 用于干啥 */
@property(nonatomic,assign) BBEarlyEducationMusicListVCForType forType;
/** 热门推荐数组 */
@property(nonatomic,strong) NSMutableArray<BBMusic *> *hotRecommends;

@end

