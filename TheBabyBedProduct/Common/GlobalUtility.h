//
//  GlobalUtility.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalUtility : NSObject


@property (nonatomic,assign) BOOL loginFlage;
@property (nonatomic,assign) BOOL networkState;
@property (nonatomic,strong) NSString  * token;

+ (GlobalUtility *)sharedUtility;

/**
 退出登录时清理数据
 */
+ (void)EmptyData;

@end
