//
//  HomeTableViewCell.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureView];
    }
    return self;
}

-(void)configureView{
    
    _iconImageView = [[UIImageView alloc]init];
    _iconImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(15);
        make.centerY.equalTo(self.mas_centerY);
        make.height.width.equalTo(@24);
    }];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = rgb(51, 51, 51, 1);
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).with.offset(51);
    }];
    
    UIView * bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = rgb(229, 229, 229, 1);
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.left.equalTo(_titleLabel.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.equalTo(@1);
    }];
    
    UIImageView * rightImageView = [[UIImageView alloc]init];
    rightImageView.image = [UIImage imageNamed:@"home_right_Icon"];
    [self addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.width.equalTo(@7);
        make.height.equalTo(@13);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.textColor = rgb(102, 102, 102, 1);
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(rightImageView.mas_left).with.offset(-10);
        make.centerY.equalTo(self.mas_centerY);
    }];

}

-(void)setIcon:(NSString *)imageName title:(NSString *)title content:(NSString *)content{
    
    UIImage * image = [UIImage imageNamed:imageName];
//    CGSize size = image.size;
//    CGFloat height = 24;
//    CGFloat width = 24 * size.width / size.height;
//    [_iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@(width));
//        make.height.equalTo(@(height));
//        make.left.equalTo(self.mas_left).with.offset(15);
//        make.centerY.equalTo(self.mas_centerY);
//    }];
    
    self.iconImageView.image = image;
    self.titleLabel.text = title;
    self.contentLabel.text = content;
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
