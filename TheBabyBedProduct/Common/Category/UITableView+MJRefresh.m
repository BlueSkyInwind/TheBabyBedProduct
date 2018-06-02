//
//  UITableView+MJRefresh.m
//  JRTianTong
//
//  Created by ╰莪呮想好好宠Nǐつ on 2017/9/15.
//  Copyright © 2017年 JinRi . All rights reserved.
//

#import "UITableView+MJRefresh.h"

@implementation UITableView (MJRefresh)

/**
 【header】返回一个MJRefreshNormalHeader对象
 
 @param target target对象（如：vc）
 @param action 下拉刷新action
 @param hasLastDate 是否显示“最后更新”lb
 @param enterStartRefresh 是否已进入界面就自动刷新
 */
+(MJRefreshHeader *)pp_headerForNomaWithTarget:(id)target
                                        action:(SEL)action
                                   hasLastDate:(BOOL)hasLastDate
                             enterStartRefresh:(BOOL)enterStartRefresh
{
    MJRefreshNormalHeader *normalHeader = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
    normalHeader.lastUpdatedTimeLabel.hidden = !hasLastDate;
    if (enterStartRefresh) {
        [normalHeader beginRefreshing];
    }
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    normalHeader.automaticallyChangeAlpha = YES;
    
    return normalHeader;
}

/**
 【footer】返回一个MJRefreshAutoNormalFooter对象
 
 @param target target对象（如：vc）
 @param action 下拉刷新action
 */
+(MJRefreshAutoNormalFooter *)pp_footerForAutoNormalWithTarger:(id)target
                                                        action:(SEL)action
{
    //可以参考http://www.jianshu.com/p/4ea427bab0af
    MJRefreshAutoNormalFooter *autoNomalFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    /** 自动根据有无数据来显示和隐藏（有数据就显示，没有数据隐藏。默认是NO） */
    autoNomalFooter.automaticallyHidden = YES;
    
    return autoNomalFooter;
}
@end
