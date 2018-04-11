//
//  MessageViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/28.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageModel.h"


@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    BOOL isedit;
    int page;
    NSMutableArray * messageLists;
    NSMutableArray * selectMessageList;
    
}

@property (nonatomic,strong)UITableView * messageTableView;

@property (nonatomic,strong)MessageTableViewCell * messageCell;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息中心";
    [self addBackItem];
    page = 1;
    [self configureview];
}

-(void)configureview{
    
    isedit = false;
    messageLists = [NSMutableArray array];
    selectMessageList = [NSMutableArray array];
    
    UIButton * rightEditButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightEditButton setTitle:@"编辑" forState:UIControlStateNormal];
        [rightEditButton setTitle:@"完成" forState:UIControlStateSelected];
    [rightEditButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [rightEditButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithCustomView:rightEditButton];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    _messageTableView = [[UITableView alloc]init];
    _messageTableView.delegate = self;
    _messageTableView.dataSource = self;
    [self.view addSubview:_messageTableView];
    [_messageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _messageTableView.tableFooterView =  [[UIView alloc]initWithFrame:CGRectZero];
    [self setupMJRefreshTableView];
}
-(void)rightButtonClick:(id)sender{
    UIButton * button = sender;
    button.selected = !button.selected;
    isedit = button.selected;
    [self.messageTableView reloadData];
}
-(void)deleteButtonClick:(id)sender{
    
    if (selectMessageList.count == 0) {
        [QMUITips showWithText:@"请选择消息" inView:self.view hideAfterDelay:0.5];
        return;
    }
    
    NSString * ids = @"";
    for (NSNumber * num in selectMessageList) {
        MessageInfoModel * model = messageLists[num.intValue];
        [ids stringByAppendingString:[NSString stringWithFormat:@",%@",model.message_id]];
    }
    
    [self editMessageStatus:@"0" messageIds:ids finish:^(BOOL isSuccess) {
        if (isSuccess) {
            [self.messageTableView reloadData];
        }
    }];
}

#pragma mark - tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return messageLists.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 63;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * cellStr = [NSString stringWithFormat:@"MessageTableViewCell%ld%ld",(long)indexPath.row,(long)indexPath.section];
    [_messageTableView registerNib:[UINib nibWithNibName:NSStringFromClass([MessageTableViewCell class]) bundle:nil] forCellReuseIdentifier:cellStr];
    _messageCell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    MessageInfoModel * messageInfo = messageLists[indexPath.row];
    _messageCell.titleLabel.text = messageInfo.title;
    _messageCell.contentLabel.text = messageInfo.msg;
    _messageCell.dateLabel.text = [GlobalTool timestampToTime:[messageInfo.createTime doubleValue]];
    _messageCell.timeLabel.text = [GlobalTool timestampTo24HTime:[messageInfo.createTime doubleValue]];;
//    _messageCell.titleLabel.text = @"设备详情";
//    _messageCell.contentLabel.text = @"埃及附件我放假我发";
//    _messageCell.dateLabel.text = @"2018-03-30";
//    _messageCell.timeLabel.text = @"18:00:00";
    [_messageCell isEidtMode:isedit];

    return _messageCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    MessageTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if (isedit) {
        cell.selelctBtn.selected = !cell.selelctBtn.selected;
        if (cell.selelctBtn.selected) {
            [selectMessageList addObject:@(indexPath.row)];
        }else{
            if ([selectMessageList containsObject:@(indexPath.row)]) {
                [selectMessageList removeObject:@(indexPath.row)];
            }
        }
    }else{
        //正常状态点击
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(isedit){
        return 90;
    }else{
        return 0 ;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UIButton * editButton = [UIButton buttonWithType:UIButtonTypeCustom];
    editButton.frame = CGRectMake(0, 0, _k_w - 60, 45);
    editButton.center = CGPointMake(_k_w / 2, 45);
    [editButton setTitle:@"删除" forState:UIControlStateNormal];
    editButton.backgroundColor = rgb(255, 206, 0, 1);
    editButton.layer.cornerRadius = editButton.frame.size.height / 2;
    editButton.clipsToBounds = true;
    [editButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:editButton];
    return view;
}

#pragma mark ----------设置列表的可刷新性----------
-(void)setupMJRefreshTableView
{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    //    header.automaticallyChangeAlpha = YES;
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header beginRefreshing];
    self.messageTableView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    footer.automaticallyChangeAlpha = YES;
    footer.mj_origin = CGPointMake(0, _k_h);
    self.messageTableView.mj_footer = footer;
    
}
-(void)headerRereshing
{
    //以下两种方法
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.messageTableView.mj_header endRefreshing];
    });
    page = 1;
    [self obtainMessageList:page];
}

-(void)footerRereshing
{
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.messageTableView.mj_footer endRefreshing];
    });
    page += 1;
    [self obtainMessageList:page];
}

#pragma mark ----------网络请求----------
-(void)obtainMessageList:(int)page{
    
    [BBRequestTool getMessageListWith:page successBlock:^(EnumServerStatus status, id object) {
        MessageModel * model = [[MessageModel alloc] initWithDictionary:(NSDictionary *)object error:nil];
        if (model.code == 0) {
            if (messageLists.count > 0 && page == 1) {
                [messageLists removeAllObjects];
            }
            for (MessageInfoModel * infoModel in model.data) {
                [messageLists addObject:infoModel];
            }
            [self.messageTableView reloadData];
        }else{
            [QMUITips showWithText:model.msg inView:self.view hideAfterDelay:0.5];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        
    }];
}

-(void)editMessageStatus:(NSString *)operationType messageIds:(NSString *)messageIds finish:(void(^)(BOOL isSuccess))finish{
    [BBRequestTool editMessageListWith:operationType messageIds:messageIds successBlock:^(EnumServerStatus status, id object) {
        BaseResultModel *resultM = [[BaseResultModel alloc] initWithDictionary:object error:nil];
        if (resultM.code == 0) {
            finish(true);
            [self.messageTableView reloadData];
        }else{
            finish(false);
            [QMUITips showWithText:resultM.msg inView:self.view hideAfterDelay:0.5];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        finish(false);
    }];

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
