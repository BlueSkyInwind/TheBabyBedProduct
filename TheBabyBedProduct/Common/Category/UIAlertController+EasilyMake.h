//
//  UIAlertController+EasilyMake.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/30.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BBAlertControllerMakeBlock)(UIAlertAction *action);

@interface UIAlertController (EasilyMake)

+(instancetype)bb_alertControllerMakeForAlertCancelAndOKWithTitle:(NSString *)title
                                                          message:(NSString *)message
                                                        OKHandler:(BBAlertControllerMakeBlock)OKHandler;

+(instancetype)bb_alertControllerMakeForAlertOnlyCancelWithTitle:(NSString *)title
                                                         message:(NSString *)message
                                                     cancelTitle:(NSString *)cancelTitle;
@end
