//
//  BBEarlyEducationHeaderView.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/29.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,BBEarlyEducationItemType) {
    BBEarlyEducationItemTypeTaiJiaoYinYue     = 0,
    BBEarlyEducationItemTypeJingDianTongHua,
    BBEarlyEducationItemTypeShuiQianGuShi,
    BBEarlyEducationItemTypeYinYueQiMeng,
    BBEarlyEducationItemTypeShiGeMeiWen,
    BBEarlyEducationItemTypeJingDianYinYue,
    BBEarlyEducationItemTypeGangQinQu,
    BBEarlyEducationItemTypeGuDianYinYue
};

@interface BBEarlyEducationHeaderView : UICollectionReusableView
@property(nonatomic,copy) void(^itemClickedBlock)(BBEarlyEducationItemType itemType);
@property(nonatomic,copy) void(^bannerClickBlock)(NSInteger selectedIndex);
@property(nonatomic,copy) void(^lookMoreBlock)(void);

@end

//注意：此处主要是因为切图给的尺寸不对，所以自己处理，因为时间紧，再等切图就麻烦，此版本请自动忽略代码质量！！！
@interface BBItemButton : UIView
-(instancetype)initWithFrame:(CGRect)frame imgName:(NSString *)imgName text:(NSString *)text;
@property(nonatomic,strong) UIImageView *topImgV;
@property(nonatomic,strong) UILabel *bottomTextLB;
@property(nonatomic,strong) UIButton *tempBT;
@end
