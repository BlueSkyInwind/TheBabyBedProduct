//
//  ArtShareSheetView.m
//  LWShareView
//
//  Created by LeeWong on 2018/1/9.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "LWShareSheetView.h"
#import "LWShareContentView.h"

@interface LWShareSheetView ()
@property (nonatomic, strong) LWShareContentView *contentView;

@end

@implementation LWShareSheetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self buildUI];
    }
    return self;
}


- (void)buildUI
{
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.height.equalTo(@50);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self.cancelBtn.mas_top).offset(-10);
    }];
}

- (void)setShareBtnClickBlock:(void (^)(NSIndexPath *))shareBtnClickBlock
{
    _shareBtnClickBlock = shareBtnClickBlock;
    self.contentView.shareBtnClickBlock = shareBtnClickBlock;
}

+ (NSInteger)sectionCount
{
    NSInteger count = 0;

    if ([LWShareSheetView bottomMenus].count > 0) {
        count += 1;
    }
    return count;
}

#pragma mark - Lazy Load


- (LWShareContentView *)contentView
{
    if (_contentView == nil) {
        _contentView = [[LWShareContentView alloc] init];
        _contentView.backgroundColor = kUIColorFromRGB(0xf0f0f0);
        _contentView.layer.cornerRadius = 12;
        _contentView.layer.masksToBounds = YES;
        _contentView.bottomMenus = [LWShareSheetView bottomMenus];
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.backgroundColor = kUIColorFromRGB(0xffffff);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:kUIColorFromRGB(0x666666) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _cancelBtn.layer.cornerRadius = 12;
        _cancelBtn.layer.masksToBounds = YES;
        [self addSubview:_cancelBtn];
    }
    return _cancelBtn;
}


+ (NSArray *)bottomMenus
{
    return @[@{kShareIcon:@"share_qq",kShareTitle:@"QQ好友"},
             @{kShareIcon:@"share_timeline",kShareTitle:@"微信朋友圈"},
             @{kShareIcon:@"share_wechat",kShareTitle:@"微信好友"},
             @{kShareIcon:@"share_weibo",kShareTitle:@"微博"}];
    
}


@end
