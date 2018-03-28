//
//  BBSubmitSuggestionViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBSubmitSuggestionViewController.h"

@interface BBSubmitSuggestionViewController ()<QMUITextViewDelegate>
@property(nonatomic,strong) QMUITextView *textView;
@property(nonatomic,strong) QMUIFillButton *submitBT;

@end

@implementation BBSubmitSuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_color_vcBg;
    self.title = @"意见反馈";

    [self creatUI];
}

-(void)creatUI
{
    self.textView = [[QMUITextView alloc] init];
    self.textView.delegate = self;
    self.textView.placeholder = @"请填写您遇到的问题或者对我们想说的话，最多300个字哦！";
    self.textView.placeholderColor = k_color_153153153; // 自定义 placeholder 的颜色
    self.textView.autoResizable = YES;
    self.textView.textContainerInset = UIEdgeInsetsMake(10, 7, 10, 7);
    self.textView.returnKeyType = UIReturnKeySend;
    self.textView.enablesReturnKeyAutomatically = YES;
    self.textView.typingAttributes = @{NSFontAttributeName: UIFontMake(12),
                                       NSForegroundColorAttributeName: k_color_153153153,
                                       NSParagraphStyleAttributeName: [NSMutableParagraphStyle qmui_paragraphStyleWithLineHeight:20]};
    // 限制可输入的字符长度
    self.textView.maximumTextLength = 200;
    
    self.textView.layer.borderWidth = PixelOne;
    self.textView.layer.borderColor = UIColorSeparator.CGColor;
    self.textView.layer.cornerRadius = 4;
    [self.view addSubview:self.textView];
    
    self.textView.frame = CGRectFlatMake(20, 64+30, _k_w-40, 180);
    
    //登录
    self.submitBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:self.submitBT];
    self.submitBT.titleLabel.font = [UIFont systemFontOfSize:18];
    self.submitBT.fillColor = rgb(255, 236, 183, 0.5);
    self.submitBT.titleTextColor = k_color_515151;
    [self.submitBT setTitle:@"提  交" forState:UIControlStateNormal];
    self.submitBT.frame = CGRectMake(40, self.textView.bottom+90, _k_w-80, 44);
    self.submitBT.userInteractionEnabled = NO;
    [self.submitBT addTarget:self action:@selector(submitAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)submitAction
{
#warning to
    DLog(@"点击去提交意见");
}

- (void)textView:(QMUITextView *)textView didPreventTextChangeInRange:(NSRange)range replacementText:(NSString *)replacementText {
    [QMUITips showWithText:[NSString stringWithFormat:@"文字不能超过 %@ 个字符", @(textView.maximumTextLength)] inView:self.view hideAfterDelay:2.0];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
@end