//
//  BBLoginView.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBLoginView : UIView
@property(nonatomic,copy) void(^forgetPasswordBlock)(void);
@property(nonatomic,copy) void(^loginBlock)(NSString *phone,NSString *password);
@property(nonatomic,copy) void(^thirdLoginBlock)(BBThirdLoginType type);

@end
