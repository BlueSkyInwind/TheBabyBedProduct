//
//  DeviceConnectAnimationView.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceConnectAnimationView : UIView{
    
    CAReplicatorLayer *_containerLayer2;
}


/**<#Description#>*/
@property (nonatomic,strong)UIView  * backView;
- (void)beginAnimation;
@end