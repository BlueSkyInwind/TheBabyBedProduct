//
//  WettingThresholdSettingViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "WettingThresholdSettingViewController.h"
#import "ThresholdTableViewCell.h"

@interface WettingThresholdSettingViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray<NSString *> * titleArr;
    NSArray<NSString *> * imageArr;
    
}
@property (nonatomic,strong)ThresholdTableViewCell * thresholdTableViewCell;

@end

@implementation WettingThresholdSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"预值设定";
    [self addBackItem];

    [self configureView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getCryingThresholdValueComplication:^(BOOL isSuccess) {
        if (isSuccess) {
            
        }
    }];
}

-(void)configureView{
    
    self.view.backgroundColor = kUIColorFromRGB(0xF7F9FB);
    self.displayTableView.backgroundColor = kUIColorFromRGB(0xF7F9FB);
    
    titleArr = @[@"轻微尿湿图片",@"中度尿湿图片",@"严重尿湿图片",@"干燥图片"];
    imageArr = @[@"babycrying_Icon",@"babycrying_Icon",@"babycrying_Icon",@"babycrying_Icon"];
    
    self.saveButton.layer.cornerRadius = self.saveButton.frame.size.height / 2;
    self.saveButton.clipsToBounds = true;
    
    self.displayTableView.delegate = self;
    self.displayTableView.dataSource = self;
    self.displayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.displayTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ThresholdTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"ThresholdTableViewCell"];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return  42;
}
                 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
                 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
                 
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.thresholdTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ThresholdTableViewCell" forIndexPath:indexPath];
    self.thresholdTableViewCell.titleLabel.text = titleArr[indexPath.section];
    self.thresholdTableViewCell.diaplayImageView.image = [UIImage imageNamed:imageArr[indexPath.section]];
    return self.thresholdTableViewCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = kUIColorFromRGB(0xF7F9FB);
    return view;
}
                 
                
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- 网络请求 ----
-(void)SetWettingThresholdValueComplication:(void(^)(BOOL isSuccess))finish{
    [BBRequestTool SetThresholdValueDeviceType:@"3" minValue:@"" maxValue:self.contentTextField.text deviceId:BBUserHelpers.deviceId successBlock:^(EnumServerStatus status, id object) {
        BaseResultModel *resultM = [[BaseResultModel alloc] initWithDictionary:object error:nil];
        if (resultM.code == 0) {
            finish(true);
        }else{
            [QMUITips showWithText:resultM.msg inView:self.view hideAfterDelay:0.5];
            finish(false);
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        finish(false);
    }];
}
-(void)getCryingThresholdValueComplication:(void(^)(BOOL isSuccess))finish{
    [BBRequestTool GetThresholdValueDeviceType:@"3" deviceId:[BBUser bb_getUser].deviceId successBlock:^(EnumServerStatus status, id object) {
        BaseResultModel *resultM = [[BaseResultModel alloc] initWithDictionary:object error:nil];
        if (resultM.code == 0) {
            finish(true);
        }else{
            [QMUITips showWithText:resultM.msg inView:self.view hideAfterDelay:0.5];
            finish(false);
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        finish(false);
    }];
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
