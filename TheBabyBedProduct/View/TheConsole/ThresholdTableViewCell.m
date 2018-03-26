//
//  ThresholdTableViewCell.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/26.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ThresholdTableViewCell.h"

@implementation ThresholdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.diaplayImageView.layer.cornerRadius = self.imageView.frame.size.width / 2;
    self.diaplayImageView.clipsToBounds = true;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
