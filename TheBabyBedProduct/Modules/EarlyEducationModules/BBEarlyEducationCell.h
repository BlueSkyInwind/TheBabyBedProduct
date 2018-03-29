//
//  BBEarlyEducationCell.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/29.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBEarlyEducationCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView *imgV;
@property(nonatomic,strong) UILabel *tLB;
-(void)setupCellWithImgName:(NSString *)imgName text:(NSString *)text;
@end
