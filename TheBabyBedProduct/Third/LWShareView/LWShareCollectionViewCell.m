//
//  ArtShareCollectionViewCell.m
//  DesignBox
//
//  Created by WangYouming on 15/8/31.
//  Copyright (c) 2015年 GK. All rights reserved.
//

#import "LWShareCollectionViewCell.h"
#import "LWShareButton.h"

@implementation LWShareCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (LWShareButton *)shareBtn
{
    if (_shareBtn == nil) {
        LWShareButton *shareBtn = [[LWShareButton alloc] init];
        shareBtn.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:shareBtn];
        _shareBtn = shareBtn;
        [_shareBtn addTarget:self action:@selector(sharedAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}
-(void)sharedAction
{
    if (self.cellShareBlock) {
        self.cellShareBlock();
    }
}

@end
