//
//  BBMyListSubTitleCell.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBMyListSubTitleCell : UITableViewCell
/** 子标题 */
@property(nonatomic,copy,readonly) NSString *subTitle;
-(void)setupCellWithImgName:(NSString *)imgName title:(NSString *)title subTitle:(NSString *)subTitle;
@end
