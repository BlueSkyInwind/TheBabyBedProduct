//
//  UITableView+MJRefresh.h
//  JRTianTong
//
//  Created by ╰莪呮想好好宠Nǐつ on 2017/9/15.
//  Copyright © 2017年 JinRi . All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (MJRefresh)


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
                             enterStartRefresh:(BOOL)enterStartRefresh;


/**
 【footer】返回一个MJRefreshAutoNormalFooter对象

 @param target target对象（如：vc）
 @param action 下拉刷新action
 */
+(MJRefreshAutoNormalFooter *)pp_footerForAutoNormalWithTarger:(id)target
                                                        action:(SEL)action;
@end
