//
//  ConsoleRateBottonView.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/24.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^HistoryBtnClick)(UIButton *button);
@interface ConsoleRateBottonView : UIView

@property (nonatomic,strong)UIButton * historyButton;
@property (nonatomic,strong)UILabel * explainLabel;
@property (nonatomic,strong)UIImageView * displayIcon;

@property (nonatomic,copy)HistoryBtnClick historyBtnClick;

-(instancetype)initWithFrame:(CGRect)frame;
@end
