//
//  MessageViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>{
    BOOL isedit;
}

@property (nonatomic,strong)UITableView * messageTableView;

@property (nonatomic,strong)MessageTableViewCell * messageCell;
@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息中心";
    [self configureview];
}

-(void)configureview{
    isedit = false;
    
    
    UIButton * editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [editButton setTitle:@"完成" forState:UIControlStateSelected];
    [editButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    _messageTableView = [[UITableView alloc]init];
    _messageTableView.delegate = self;
    _messageTableView.dataSource = self;
    [self.view addSubview:_messageTableView];
    [_messageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    


}
-(void)rightButtonClick:(id)sender{
    UIButton * button = sender;
    button.selected = !button.selected;
    isedit = button.selected;
    [self.messageTableView reloadData];
}
-(void)deleteButtonClick:(id)sender{
    
    
    [self.messageTableView reloadData];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 24;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 63;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellStr = [NSString stringWithFormat:@"MessageTableViewCell%ld%ld",(long)indexPath.row,(long)indexPath.section];
    [_messageTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MessageTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellStr];
    _messageCell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    _messageCell.titleLabel.text = @"设备信息";
    _messageCell.contentLabel.text = @"婴儿踢被了，请注意查看";
    _messageCell.dateLabel.text = @"2018-03-30";
    _messageCell.timeLabel.text = @"18:00:00";
    [_messageCell isEidtMode:isedit];

    return _messageCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];


}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(isedit){
        return 150;
    }else{
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UIButton * editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(0, 0, _k_w - 60, 45);
    editButton.center = CGPointMake(_k_w / 2, 75);
    [editButton setTitle:@"删除" forState:UIControlStateNormal];
    editButton.backgroundColor = rgb(255, 206, 0, 1);
    editButton.layer.cornerRadius = editButton.frame.size.height / 2;
    editButton.clipsToBounds = true;
    [editButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:editButton];
    return view;
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
