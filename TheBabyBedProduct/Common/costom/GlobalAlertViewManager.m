//
//  GlobalAlertViewManager.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/5.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "GlobalAlertViewManager.h"
#import "GlobalPopView.h"

@interface GlobalAlertViewManager()


/* <#Description#>*/
@property(nonatomic,strong)GlobalPopView * popView;
@end

@implementation GlobalAlertViewManager


static GlobalAlertViewManager * manager = nil;
+(GlobalAlertViewManager *)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GlobalAlertViewManager alloc]init];
    });
    return manager;
}


-(void)promptsPopViewWithtitle:(NSString *)title content:(NSString *)content cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle completion:(void(^)(NSInteger index))completion{
    
    if (_popView) {
        return;
    }
    __weak typeof (self) weakSelf = self;
    _popView =  [GlobalPopView initWithTitle:title content:content cancelTitle:cancelTitle sureTitle:sureTitle clickcompletion:^(NSInteger index) {
        completion(index);
        [weakSelf.popView dismiss];
        weakSelf.popView = nil;
    }];
    [_popView show];
    
}








@end
