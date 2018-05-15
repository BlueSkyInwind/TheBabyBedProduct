//
//  BBMusicCategory.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/5/11.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBMusicCategory : NSObject
@property(nonatomic,copy) NSString *cat_count;
@property(nonatomic,copy) NSString *cat_icon_url;
@property(nonatomic,copy) NSString *cat_name;
@property(nonatomic,copy) NSString *cat_group_age_scope;
@property(nonatomic,copy) NSString *cat_parent;
@property(nonatomic,assign) NSInteger cat_id;
/*
"cat_count": "0",
"cat_icon_url": "http://img.ilisten.idaddy.cn/f/h/0/161756jkqdhs00z30ri3ji.png",
"cat_name": "\u513f\u6b4c",
"cat_id": 6707,
"cat_group_age_scope": "-1-8",
"cat_parent": 0
 */
@end

@interface BBMusicCategoryAudioinfos : NSObject
@property(nonatomic,strong) NSMutableArray *cats;
@end

@interface BBMusicCategoryResult : NSObject
@property(nonatomic,strong) BBMusicCategoryAudioinfos *audioinfos;
@property(nonatomic,assign) int retcode;
@end
