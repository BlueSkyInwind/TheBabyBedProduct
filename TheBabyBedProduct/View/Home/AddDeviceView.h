//
//  AddDeviceView.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/4/3.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AddDeviceClick)();
@interface AddDeviceView : UIView

/**添加设备按钮*/
@property (nonatomic,strong)UIButton  * addbutton;

/**<#Description#>*/
@property (nonatomic,copy)AddDeviceClick  addDeviceClick;

@end
