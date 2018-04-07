//
//  BBRegistView.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKCountDownButton;

@interface BBRegistView : UIScrollView
@property(nonatomic,copy) void(^getCodeBlock)(NSString *phone,JKCountDownButton *countDownBT);
@property(nonatomic,copy) void(^registBlock)(NSString *phone,NSString *code,NSString *password);
@property(nonatomic,copy) void(^agreeProtocolBlock)(BOOL isAgree);
@property(nonatomic,copy) void(^clickProtocolBlock)(void);
@end

