//
//  BBMyDevieceCell.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/3.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,BBMyDevieceCellBindingType) {
    BBMyDevieceCellBindingTypeTW = 0,
    BBMyDevieceCellBindingTypeTB,
    BBMyDevieceCellBindingTypeWD
};

@interface BBMyDevieceCell : UITableViewCell
@property(nonatomic,copy) void(^deleteSensorBlock)(BBMyDevieceCellBindingType bindingType);
-(void)setupCellWithIndexPath:(NSIndexPath *)indexPath leftTitle:(NSString *)leftTitle;
@end
