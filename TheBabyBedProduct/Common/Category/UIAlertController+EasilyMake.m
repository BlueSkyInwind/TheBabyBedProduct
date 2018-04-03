//
//  UIAlertController+EasilyMake.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/30.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "UIAlertController+EasilyMake.h"

@implementation UIAlertController (EasilyMake)
+(instancetype)bb_alertControllerMakeForAlertCancelAndOKWithTitle:(NSString *)title
                                                          message:(NSString *)message
                                                        OKHandler:(BBAlertControllerMakeBlock)OKHandler
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *OKAlertAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        if (action) {
            OKHandler(action);
        }
    }];
    
    [alertC addAction:cancelAlertAction];
    [alertC addAction:OKAlertAction];
    
    return alertC;
}

+(instancetype)bb_alertControllerMakeForAlertOnlyCancelWithTitle:(NSString *)title
                                                         message:(NSString *)message
                                                     cancelTitle:(NSString *)cancelTitle
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:cancelTitle style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:cancelAlertAction];
    
    return alertC;
}
@end
