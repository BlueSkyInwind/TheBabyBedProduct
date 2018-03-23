//
//  DateChooseView.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/23.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef void (^ChooseDateBlock) (NSTimeInterval chooseInterval);
@interface DateChooseView : UIView{
    
    NSTimeInterval _dispalyInterval;
}

@property (nonatomic,strong)UIButton * leftButton;

@property (nonatomic,strong)UIButton * rightButton;

@property (nonatomic,strong)UILabel * dateDisplayLabel;

@property (nonatomic,copy)ChooseDateBlock chooseDateBlock;

+(instancetype)initFrame:(CGRect)frame mainColor:(UIColor *)color;
@end
