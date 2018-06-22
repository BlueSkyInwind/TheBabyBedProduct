//
//  ConsoleRateView.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/24.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ConsoleRateView : UIView

@property (nonatomic,strong)UIImage * centerImage;
@property (nonatomic,strong)UIColor * currentColor;
@property (nonatomic,strong)UILabel * titleLabel;


+(instancetype)initWithFrame:(CGRect)frame image:(UIImage *)image circleColor:(UIColor *)color title:(NSString *)title;
-(void)updateProgressWithNumber:(CGFloat)num;
@end
