//
//  BBHelpAndSuggestionViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBHelpAndSuggestionViewController.h"
#import "WSTableviewTree.h"
#import "UIButton+EasilyMake.h"
#import "UILabel+EasilyMake.h"
#import "BBSubmitSuggestionViewController.h"
@interface BBHelpAndSuggestionViewController ()<WSTableViewDelegate>
@property(nonatomic,strong) WSTableView *tableView;
@property(nonatomic,strong) NSArray *firstLevelTitles;
@property(nonatomic,strong) NSMutableArray<WSTableviewDataModel *> *dataModels;
@end

@implementation BBHelpAndSuggestionViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_color_vcBg;
    self.title = @"帮助及意见";
    for (NSString *title in self.firstLevelTitles) {
        WSTableviewDataModel *dataM = [[WSTableviewDataModel alloc]init];
        dataM.firstLevelStr = title;
        dataM.expandable = YES;
        [self.dataModels addObject:dataM];
    }
    
    [self creatUI];
}
-(void)creatUI
{
    self.tableView = [[WSTableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.WSTableViewDelegate = self;
    self.tableView.backgroundColor = k_color_vcBg;
    //去掉多余的分割线
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
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
-(void)topItmeAction:(QMUIButton *)bt
{
    if (bt.tag == 111) {
        //意见反馈
        BBSubmitSuggestionViewController *submitSuggestionVC = [[BBSubmitSuggestionViewController alloc]init];
        [self.navigationController pushViewController:submitSuggestionVC animated:YES];
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataModels.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WSTableviewDataModel *dataModel = self.dataModels[indexPath.row];
    static NSString *CellIdentifier = @"WSTableViewCell";
    WSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
      cell = [[WSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = dataModel.firstLevelStr;
    cell.expandable = dataModel.expandable;

    return cell;
}
-(NSInteger)tableView:(WSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath
{
    return 3;
}
-(CGFloat)tableView:(WSTableView *)tableView heightForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UITableViewCell *)tableView:(WSTableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"WSTableViewCell34";
    WSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell){
        cell = [[WSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld--%ld--%ld",(long)indexPath.section,(long)indexPath.row,(long)indexPath.subRow];
    
    return cell;
}
-(NSArray *)firstLevelTitles
{
    if (!_firstLevelTitles) {
        _firstLevelTitles = @[
                              @"不能扫码连接",
                              @"视频无法直接观看",
                              @"传感器连接"
                              ];
    }
    return _firstLevelTitles;
}
-(NSMutableArray<WSTableviewDataModel *> *)dataModels
{
    if (!_dataModels) {
        _dataModels = [NSMutableArray array];
    }
    return _dataModels;
}
@end
