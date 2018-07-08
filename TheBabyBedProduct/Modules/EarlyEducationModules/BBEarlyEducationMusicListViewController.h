//
//  BBEarlyEducationMusicListViewController.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/9.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BaseViewController.h"
@class BBMusicCategory;

@interface BBEarlyEducationMusicListViewController : BaseViewController
@property(nonatomic,copy) NSString *musicListName;
@property(nonatomic,strong) BBMusicCategory *aMusicCategory;
@end
