//
//  BBEarlyEducationCell.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/29.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBEarlyEducationCell.h"
#import "UIImageView+WebCache.h"

@implementation BBEarlyEducationCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self creatUI];
    }
    return self;
}

-(void)setupCellWithAHotRecommend:(BBMusicHotRecommend *)aHotRecommend
{
    [self.imgV sd_setImageWithURL:[NSURL URLWithString:aHotRecommend.icon] placeholderImage:nil];
    self.tLB.text = aHotRecommend.name;
}
-(void)creatUI
{
    self.imgV = [UIImageView bb_imgVMakeWithSuperV:self.contentView];
    self.tLB = [UILabel bb_lbMakeWithSuperV:self.contentView fontSize:12 alignment:NSTextAlignmentCenter textColor:k_color_515151];
    
    self.imgV.frame = CGRectMake(5, 5, self.width-10, self.height-34);
    self.tLB.frame = CGRectMake(0, self.imgV.bottom, self.width, 24);
}
@end
