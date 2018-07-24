//
//  BBQuestionListCell.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/7/24.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBQuestion;

@interface BBQuestionListCell : UITableViewCell
-(void)setupCellWithQuestion:(BBQuestion *)question;
@end
