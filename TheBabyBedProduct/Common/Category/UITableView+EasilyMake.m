//
//  UITableView+EasilyMake.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "UITableView+EasilyMake.h"

@implementation UITableView (EasilyMake)
+(instancetype)bb_tableVMakeWithSuperV:(UIView *)superV
                                 frame:(CGRect)frame
                              delegate:(id)delegate
                               bgColor:(UIColor *)bgColor
                                 style:(UITableViewStyle)style
{
    UITableView *tableV = [[UITableView alloc]initWithFrame:frame style:style];
    if (superV) {
        [superV addSubview:tableV];
    }
    if (delegate) {
        tableV.delegate = delegate;
        tableV.dataSource = delegate;
    }
    if (bgColor) {
        tableV.backgroundColor = bgColor;
    }
    //去掉所有分割线
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    //去掉多余的分割线
    [tableV setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    return tableV;
}
@end
