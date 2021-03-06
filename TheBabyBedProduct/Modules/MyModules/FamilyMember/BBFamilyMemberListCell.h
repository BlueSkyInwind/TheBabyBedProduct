//
//  BBFamilyMemberListCell.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/29.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BBUser;
@class BBFamilyMember;

@interface BBFamilyMemberListCell : UITableViewCell
@property(nonatomic,copy) void(^setOrAgreeBlock)(BOOL isSetting);
@property(nonatomic,copy) void(^refuseBlock)(void);

-(void)setupCellWithUser:(BBUser *)user isleft:(BOOL)isLeft;
-(void)setupWithFamilyMember:(BBFamilyMember *)familyMember applyType:(BBApplyType)applyType;
@end
