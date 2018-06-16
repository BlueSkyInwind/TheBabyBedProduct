//
//  videoClarityChangeView.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/6/11.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^ClarityChange)(NSInteger clickIndex,NSString * title);
@interface videoClarityChangeView : UIView

/**<#Description#>*/
@property (nonatomic,strong)UIView  * backView;
/**<#Description#>*/
@property (nonatomic,strong)NSArray * titleArr;

@property (nonatomic,strong,readonly)NSMutableArray * buttonArr;
/**<#Description#>*/
@property (nonatomic,copy)ClarityChange clarityChange;

+(void)showClarityChangeView:(CGRect)frame superView:(UIView *)superView dataSource:(NSArray *)dataSource complication:(ClarityChange)index;
+(void)hideChangeView;


@end
