//
//  HistoryTemperatureListViewController.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/4/10.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "HistoryTemperatureListViewController.h"
#import "MessageTableViewCell.h"

@interface HistoryTemperatureListViewController ()<UITableViewDelegate,UITableViewDataSource>{
    NSMutableArray * listsArr;
}

/**<#Description#>*/
@property (nonatomic,strong)UITableView  * listTableView;
@property (nonatomic,strong)MessageTableViewCell * listCell;

@end

@implementation HistoryTemperatureListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

-(void)configureView{
    
    listsArr  = [NSMutableArray array];
    
    _listTableView = [[UITableView alloc]init];
    _listTableView.delegate = self;
    _listTableView.dataSource = self;
    [self.view addSubview:_listTableView];
    [_listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return listsArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 63;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellStr = [NSString stringWithFormat:@"MessageTableViewCell%ld%ld",(long)indexPath.row,(long)indexPath.section];
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MessageTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellStr];
    _listCell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    
//    MessageInfoModel * messageInfo = messageLists[indexPath.row];
//    _messageCell.titleLabel.text = messageInfo.title;
//    _messageCell.contentLabel.text = messageInfo.msg;
//    _messageCell.dateLabel.text = [GlobalTool timestampToTime:[messageInfo.createTime doubleValue]];
//    _messageCell.timeLabel.text = [GlobalTool timestampTo24HTime:[messageInfo.createTime doubleValue]];;
    
    return _listCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
