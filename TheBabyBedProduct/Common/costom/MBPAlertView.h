//
//  MBPAlertView.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MBProgressHUD;

@interface MBPAlertView : NSObject

@property (nonatomic,strong) MBProgressHUD *progressHud;
@property (nonatomic,strong) MBProgressHUD *waitHud;
@property (nonatomic,strong) MBProgressHUD *waitHudView;

+ (MBPAlertView *)sharedMBPTextView;

//- (void)presentViewController:(UIViewController *)viewControllerToPresent animated: (BOOL)flag completion:(void (^ __nullable)(void))completion

- (void) showTextOnly:(UIView *)view message: (NSString *)message;

/**
 进度显示
 
 @param view 父视图
 @param progress 进度值
 */
- (void) showProgressOnly:(UIView *)view Progress: (float)progress;

/**
 展现等待条
 
 @param view 父视图
 */
- (void) showIndeterminateOnly:(UIView *)view;
-(void)removeWaitHud;





@end
