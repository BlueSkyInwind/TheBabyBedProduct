//
//  BBQuestionListCell.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/7/24.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBQuestionListCell.h"
#import "BBQuestion.h"

@interface BBQuestionListCell ()
@property(nonatomic,strong) UILabel *questionLB;
@end

@implementation BBQuestionListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self creatCellUI];
    }
    return self;
}
-(void)creatCellUI
{
    CGFloat lbX = 23;
    CGFloat rightMargin = 10;
    CGFloat arrowW = 6;
    CGFloat arrowH = 11;
    CGFloat totalH = 47;
    CGFloat arrowY = (totalH-arrowH)/2;
    CGFloat lbImgMargin = 5;
    CGFloat lbW = _k_w-lbX-rightMargin-arrowW-lbImgMargin;
    self.questionLB = [PPMAKE(PPMakeTypeLB) pp_make:^(PPMake *make) {
        make.intoView(self.contentView);
        make.font(kFontRegular(16));
        make.textColor(k_color_515151);
        make.frame(CGRectMake(lbX, 0, lbW, totalH));
    }];
    
    [PPMAKE(PPMakeTypeImgV) pp_make:^(PPMake *make) {
        make.intoView(self.contentView);
        make.frame(CGRectMake(_k_w-rightMargin-arrowW, arrowY, arrowW, arrowH));
        make.imageName(@"youyi");
        make.userInteractionEnabled(YES);
    }];
    
    [PPMAKE(PPMakeTypeView) pp_make:^(PPMake *make) {
        make.intoView(self.contentView);
        make.bgColor(kUIColorFromRGB(0xf2f2f2));
        make.frame(CGRectMake(lbX, totalH-1, _k_w-lbX, 1));
    }];
}

-(void)setupCellWithQuestion:(BBQuestion *)question
{
    if (question.question.length > 0) {
        self.questionLB.text = question.question;
    }
}

@end
