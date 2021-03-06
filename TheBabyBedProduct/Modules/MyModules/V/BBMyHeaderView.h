//
//  BBMyHeaderView.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBUser;
typedef NS_ENUM(NSInteger,BBMyHeaderViewFuncType) {
    BBMyHeaderViewFuncTypeMyAccount = 0,
    BBMyHeaderViewFuncTypeMyDevice,
    BBMyHeaderViewFuncTypeFamilyMember
};

@interface BBMyHeaderView : UIView

@property(nonatomic,copy) void(^avatarClickedBlock)(void);
/** 登录or注册 */
@property(nonatomic,copy) void(^loginOrRegistBlock)(BBMyHeaderView *headerV);

@property(nonatomic,copy) void(^funcBlock)(BBMyHeaderViewFuncType funcType);

-(void)updateUserMess;

@end
