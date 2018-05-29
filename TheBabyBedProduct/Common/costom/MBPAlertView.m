//
//  MBPAlertView.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "MBPAlertView.h"

@implementation MBPAlertView

+ (MBPAlertView *)sharedMBPTextView
{
    static MBPAlertView *sharedMBPInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedMBPInstance = [[self alloc] init];
    });
    return sharedMBPInstance;
}

- (void) showTextOnly:(UIView *)view message: (NSString *)message
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    
    if (message.length < 20) {
        hud.labelText = message;
        hud.labelFont = [UIFont systemFontOfSize:12];
    } else {
        hud.detailsLabelText = message;
        hud.detailsLabelFont = [UIFont systemFontOfSize:12];
    }
    hud.margin = 13.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

- (void) showProgressOnly:(UIView *)view Progress: (float)progress
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (progress == 0) {
            self.progressHud= [MBProgressHUD showHUDAddedTo:view animated:YES];
            //设置模式为进度框形的
            self.progressHud.mode = MBProgressHUDModeDeterminate;
        }
        self.progressHud.progress = progress;
        if (progress == 1.0) {
            [self.progressHud hide:true];
            self.progressHud = nil;
        }
        self.progressHud.removeFromSuperViewOnHide = YES;
    });
}

- (void) showIndeterminateOnly:(UIView *)view
{
    if (self.waitHud) {
        return;
    }
    self.waitHud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Configure for text only and offset down
    self.waitHud.mode = MBProgressHUDModeIndeterminate;
    self.progressHud.removeFromSuperViewOnHide = YES;
}

-(void)removeWaitHud{
    [self.waitHud hide:true];
    self.waitHud = nil;
}









@end
