//
//  ThermometerView.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThermometerView : UIView

@property (weak, nonatomic) IBOutlet UILabel *alarTemNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *foreheadTemLabel;

@property (weak, nonatomic) IBOutlet UIView *alarThermometerView;
@property (weak, nonatomic) IBOutlet UIView *foreheadThermometerView;

@property (weak, nonatomic) IBOutlet UIButton *switchBtn;

@property (strong, nonatomic)UIImageView * alarTemImageView;
@property (strong, nonatomic)UIImageView * foreheadTemImageView;



@end
