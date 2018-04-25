//
//  BBDeviceHeaderBottomView.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBDeviceHeaderBottomView : UIView
@property(nonatomic,copy) void(^bingingOrCancelBlock)(NSString *deviceId);

-(void)updateDeviceHBView;
@end
