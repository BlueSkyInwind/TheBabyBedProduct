//
//  BBHelpAndSuggestionViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBHelpAndSuggestionViewController.h"
#import "WSTableviewTree.h"
#import "BBSubmitSuggestionViewController.h"
#import "BBAboutUsViewController.h"
#import "BBQuestionListCell.h"
#import "BBQuestion.h"
#import "BBAboutUsViewController.h"

@interface BBHelpAndSuggestionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *questions;
@end

@implementation BBHelpAndSuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_color_vcBg;
    self.titleStr = @"帮助及意见";
    
    [self creatUI];
    
    [self getHelpListData];
}
-(void)creatUI
{
    self.tableView = [PPMAKE(PPMakeTypeTableVPlain) pp_make:^(PPMake *make) {
        make.intoView(self.view);
        make.delegate(self);
        make.frame(CGRectMake(0, PPDevice_navBarHeight, _k_w, _k_h-PPDevice_navBarHeight));
        make.bgColor(k_color_vcBg);
        make.hideAllSeparator(YES);
    }];
    
//    [[WSTableView alloc]initWithFrame:CGRectMake(0, PPDevice_navBarHeight, _k_w, _k_h-PPDevice_navBarHeight) style:UITableViewStylePlain];
//    [self.view addSubview:self.tableView];
//    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = k_color_vcBg;
//    //去掉多余的分割线
//    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    UIView *topV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 210)];
    [self.view addSubview:topV];
    topV.backgroundColor = [UIColor clearColor];
    
    NSArray *imgs = @[@"gshebei",@"feedback"];
    NSArray *titles = @[@"使用说明",@"意见反馈"];
    for (int i = 0; i<imgs.count; i++) {
        QMUIButton *bt = [[QMUIButton alloc]init];
        bt.backgroundColor = [UIColor whiteColor];
        bt.layer.masksToBounds = YES;
        bt.layer.cornerRadius = 4;
        bt.imagePosition = QMUIButtonImagePositionBottom;// 将图片位置改为在文字xia方
        bt.spacingBetweenImageAndTitle = 10;
        [topV addSubview:bt];
        bt.tag = 110+i;
        CGFloat btw = (_k_w-30)/2;
        bt.frame = CGRectMake(10+(btw+10)*i, 15, btw, 120);
        [bt bb_btSetTitle:titles[i]];
        [bt bb_btSetTitleColor:k_color_515151];
        [bt bb_btSetImageWithImgName:imgs[i]];
        bt.titleLabel.font = [UIFont systemFontOfSize:16];
        [bt addTarget:self action:@selector(topItmeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIView *commonQuestionV = [[UIView alloc]initWithFrame:CGRectMake(0, 155, _k_w, 40)];
    [topV addSubview:commonQuestionV];
    commonQuestionV.backgroundColor = [UIColor whiteColor];
    UILabel *commonQuestionLB = [UILabel bb_lbMakeWithSuperV:commonQuestionV fontSize:14 alignment:NSTextAlignmentLeft textColor:k_color_515151];
    commonQuestionLB.text = @"常见问题";
    commonQuestionLB.frame = CGRectFlatMake(10, 0, _k_w-20, 40);
    
    self.tableView.tableHeaderView = topV;
    
}
-(void)getHelpListData
{
#warning todo
    //此处把每页数据放大，就不考虑分页了，个人开发包括平时使用别的APP都没遇到过常见问题还有分页的，所以到底是设计不合理还是我留的一个坑？如果你发现是一个坑，I'm sorry.😜。
    [BBRequestTool bb_requestGetHelpListWithPageNo:0 pageSize:40 successBlock:^(EnumServerStatus status, id object) {
        NSLog(@"help success %@",object);
        BBQuestionListRequestResult *requestResult = [BBQuestionListRequestResult mj_objectWithKeyValues:object];
        if (requestResult.code == 0) {
            [self.questions addObjectsFromArray:requestResult.data];
            [self.tableView reloadData];
        }else{
            [QMUITips showWithText:requestResult.msg inView:self.view hideAfterDelay:1.2];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"%@",object);
    }];
}
-(void)topItmeAction:(QMUIButton *)bt
{
    if (bt.tag == 111) {
        //意见反馈
        BBSubmitSuggestionViewController *submitSuggestionVC = [[BBSubmitSuggestionViewController alloc]init];
        [self.navigationController pushViewController:submitSuggestionVC animated:YES];
    }else{
        //使用说明
        BBAboutUsViewController *introVC = [[BBAboutUsViewController alloc]init];
        introVC.h5Title = @"使用说明";
        introVC.webUrl = [NSString stringWithFormat:@"%@%@",K_Url_BBBase,K_Url_HelpUse];
        [self.navigationController pushViewController:introVC animated:YES];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.questions.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    BBQuestionListCell *questionListCell = [BBQuestionListCell bb_cellMakeWithTableView:tableView];
    if (self.questions.count > indexPath.row) {
        [questionListCell setupCellWithQuestion:self.questions[indexPath.row]];
    }
    return questionListCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BBQuestion *question = self.questions[indexPath.row];
    BBAboutUsViewController *helpDetailWebVC = [[BBAboutUsViewController alloc]init];
    helpDetailWebVC.h5Title = @"问题详情";
    helpDetailWebVC.webUrl = [NSString stringWithFormat:@"%@api/help/%@",K_Url_BBBase,question.questionId];
    [self.navigationController pushViewController:helpDetailWebVC animated:YES];
}

@end
