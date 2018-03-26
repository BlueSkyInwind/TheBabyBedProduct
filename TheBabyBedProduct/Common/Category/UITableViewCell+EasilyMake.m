//
//  UITableViewCell+EasilyMake.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "UITableViewCell+EasilyMake.h"

@implementation UITableViewCell (EasilyMake)
+(instancetype)bb_cellMakeWithTableView:(UITableView *)tableView
{
    if (!tableView) {
        NSLog(@"%@%s",@"你未传入有效tableView,虽然不影响获取cell,但复用可能有问题！！！",__func__);
    }
    NSString * identifier = [NSString stringWithFormat:@"%@Identifier",NSStringFromClass(self)];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
