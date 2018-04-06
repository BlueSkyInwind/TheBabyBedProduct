//
//  BBMacros.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#ifndef BBMacros_h
#define BBMacros_h

typedef NS_ENUM(NSInteger,BBLoginType) {
    BBLoginTypeDefault = 0,
    BBLoginTypeWeiXin,
    BBLoginTypeQQ,
    BBLoginTypeWeiBo
};

#define k_bb_settingManager  @"KBBSETTINGMANAGER"
#define k_bb_saveUserMessage @"KBBSAVEUSERMESSAGE"

 
#import "UIView+PP_Frame.h"
#import "UILabel+EasilyMake.h"
#import "UITableView+EasilyMake.h"
#import "UITableViewCell+EasilyMake.h"
#import "UIButton+EasilyMake.h"
#import "NSMutableAttributedString+PPTextField.h"
#import "UIImageView+EasilyMake.h"
#import "UIAlertController+EasilyMake.h"
#import "BBUser.h"
#import "NetWorkRequestManager+BBRequest.h"
#import "MJExtension.h"

#endif /* BBMacros_h */
