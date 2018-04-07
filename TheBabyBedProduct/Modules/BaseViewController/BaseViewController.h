//
//  BaseViewController.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BBLoginRegistResultBlock)(BOOL isSuccess);

@interface BaseViewController : UIViewController


//返回按钮
- (void)addBackItem;

-(void)goLoginRegistVc;
-(void)bb_goLoginRegistVC:(BBLoginRegistResultBlock)resultBlock;
@end
