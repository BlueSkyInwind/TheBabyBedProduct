//
//  HomeLeftItemView.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^HomeHeaderClick)(UIButton * button);

@interface HomeLeftItemView : UIView

/**头像*/
@property (nonatomic,strong)UIButton  * headerBtn;
/**babyName*/
@property (nonatomic,strong)UILabel  * nameLabel;

@property (nonatomic,copy)HomeHeaderClick  homeHeaderClick;


@end
