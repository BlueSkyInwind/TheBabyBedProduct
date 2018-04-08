//
//  MessageTableViewCell.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/29.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.unreadStatusView.layer.cornerRadius = self.unreadStatusView.frame.size.width / 2;
    self.unreadStatusView.clipsToBounds = true;
    self.leftContentConstraint.constant = 27;
//    self.unreadStatusView.hidden = true;
    self.selelctBtn.hidden = true;
}

- (IBAction)selectButtonClick:(id)sender {
    UIButton * button = (UIButton *)sender;
    button.selected = !button.selected;
//    if (self.selectStatus) {
//        self.selectStatus(button.selected);
//    }
}

-(void)isEidtMode:(BOOL)isEidt{
    [UIView animateWithDuration:1 animations:^{
        if (isEidt) {
            self.leftContentConstraint.constant = 50;
            self.selelctBtn.hidden = false;
            self.unreadStatusView.hidden = true;
        }else{
            self.leftContentConstraint.constant = 27;
            self.selelctBtn.hidden = true;
        }
    } completion:nil];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
