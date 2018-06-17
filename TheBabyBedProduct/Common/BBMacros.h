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
typedef NS_ENUM(NSInteger,BBUserGenderType) {
    BBUserGenderTypeMan = 0,      //男
    BBUserGenderTypeWoman,        //女
    BBUserGenderTypeSecrect,      //保密
    BBUserGenderTypeUnknow        //未知
};
typedef NS_ENUM(NSInteger,BBPayType) {
    BBPayTypeZhiFuBao = 0,
    BBPayTypeWeiXin
};
typedef NS_ENUM(NSInteger,BBConsumeType) {
    BBConsumeTypeRecharge = 0,     //充值
    BBConsumeTypeConsume           //消费
};
typedef NS_ENUM(NSInteger,BBApplyStatus) {
    BBApplyStatusAgree = 1,
    BBApplyStatusRefuse
};
typedef NS_ENUM(NSInteger,BBApplyType) {
    BBApplyTypeAll = -1,        //所有申请
    BBApplyTypeVideo = 0,       //视频
    BBApplyTypeBind             //绑定
};

#define k_bb_settingManager  @"KBBSETTINGMANAGER"

#define k_bb_saveUserMessage @"KBBSAVEUSERMESSAGE"                //用户
#define k_bb_saveUserDeviceMessage @"KBBSAVEUSERDEVICEMESSAGE"    //用户设备

#define k_bb_saveIdentity    @"KBBSAVEIDENTITY"  //保存用户身份字典

 
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
#import "NSString+Verify.h"
#import "NSDate+BB.h"
#import "UIDevice+GetDeviceInfo.h"
#import "UITableView+MJRefresh.h"
#import "UIDevice+Adapter.h"
#import "UIDevice+GetDeviceMessages.h"
#import "LYEmptyViewHeader.h"

#endif /* BBMacros_h */
