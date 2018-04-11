//
//  RoomTemperatureView.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXLineChartView.h"
#import "DateChooseView.h"
@interface RoomTemperatureView : UIView

@property (nonatomic,strong)UIColor * mainColor;
@property (nonatomic,strong)UIColor * fillColor;

/**<#Description#>*/
@property (nonatomic,strong)NSArray  * pointsArr;




-(void)configureView;

@end
