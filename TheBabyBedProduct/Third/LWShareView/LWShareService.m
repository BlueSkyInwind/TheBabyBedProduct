//
//  ArtShareService.m
//  LWShareView
//
//  Created by LeeWong on 2018/1/10.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import "LWShareService.h"
#import "LWShareSheetView.h"


@interface LWShareService ()
@property (nonatomic, strong) LWShareSheetView *sheetView;
@property (nonatomic, assign) BOOL isShowing;
@property (nonatomic, strong) UIView *maskView;
@end

@implementation LWShareService
+ (instancetype)shared
{
    static dispatch_once_t onceToken;
    static LWShareService* service;
    dispatch_once(&onceToken, ^{
        service = [[LWShareService alloc] init];
    });
    return service;
}

- (void)showInViewController:(UIViewController *)viewController
{
    [self showShareSheetView:viewController];
}

- (void)showShareSheetView:(UIViewController *)viewController
{
    if (self.isShowing) {return;}
    self.isShowing = YES;
    UIWindow *keyWindow = viewController.view.window;
    
    // 添加maskView
    UIView *maskView = [[UIView alloc] init];
    [keyWindow addSubview:maskView];
    self.maskView = maskView;
    maskView.backgroundColor = [UIColor colorWithRed:36/255.0 green:41/255.0 blue:46/255.0 alpha:0.6];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(keyWindow);
    }];
    
    [maskView layoutIfNeeded];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideSheetView)];
    [maskView addGestureRecognizer:tap];
    
    LWShareSheetView *shareSheetView = [[LWShareSheetView alloc] init];
    [viewController.view.window addSubview:shareSheetView];
    self.sheetView = shareSheetView;
    CGFloat height = [LWShareSheetView sectionCount] == 2?314:([LWShareSheetView sectionCount] == 1?220:106);
    self.sheetView.frame = CGRectMake(10, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width-20, height);
    CGRect frame = self.sheetView.frame;
    [UIView animateWithDuration:0.6 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:3 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGFloat y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
        self.sheetView.frame = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
    
    
    self.sheetView.shareBtnClickBlock = self.shareBtnClickBlock;
    @weakify(self)
    [[self.sheetView.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self hideSheetView];
    }];
}
-(void)hidden
{
    [self hideSheetView];
}

- (void)hideSheetView
{
    CGRect frame = self.sheetView.frame;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        CGFloat y = [UIScreen mainScreen].bounds.size.height ;
        self.sheetView.frame = CGRectMake(frame.origin.x, y, frame.size.width, frame.size.height);
        self.maskView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.sheetView removeFromSuperview];
        self.sheetView = nil;
        self.isShowing = NO;
        [self.maskView removeFromSuperview];
    }];
}


#pragma mark - Lazy Load

- (LWShareSheetView *)sheetView
{
    if (_sheetView == nil) {
        _sheetView = [[LWShareSheetView alloc] init];
        
    }
    return _sheetView;
}
@end
