//
//  GlobalAlertViewManager.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/5.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalAlertViewManager : NSObject

+(GlobalAlertViewManager *)shareInstance;

// index = 0 取消点击  = 1 确定点击
-(void)promptsPopViewWithtitle:(NSString *)title content:(NSString *)content cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle completion:(void(^)(NSInteger index))completion;
@end
