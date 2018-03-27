//
//  CryingThresholdSettingViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "CryingThresholdSettingViewController.h"
#import "ThresholdTableViewCell.h"

@interface CryingThresholdSettingViewController ()<UITableViewDelegate,UITableViewDataSource>{
    
    NSArray<NSString *> * titleArr;
    NSArray<NSString *> * imageArr;
    
}


@property (nonatomic,strong)ThresholdTableViewCell * thresholdTableViewCell;
@end

@implementation CryingThresholdSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"阈值设定";
    [self configureView];
    
}

-(void)configureView{
    
    self.view.backgroundColor = kUIColorFromRGB(0xF7F9FB);
    self.displayTableView.backgroundColor = kUIColorFromRGB(0xF7F9FB);
    
    titleArr = @[@"哭闹图片",@"安静图片"];
    imageArr = @[@"babycrying_Icon",@"babycrying_normal_Icon"];
    
    self.saveButton.layer.cornerRadius = self.saveButton.frame.size.height / 2;
    self.saveButton.clipsToBounds = true;
    
    self.displayTableView.delegate = self;
    self.displayTableView.dataSource = self;
    self.displayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.displayTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ThresholdTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"ThresholdTableViewCell"];
    
}

- (IBAction)saveButtonClick:(id)sender {
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  42;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.thresholdTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ThresholdTableViewCell" forIndexPath:indexPath];
    self.thresholdTableViewCell.titleLabel.text = titleArr[indexPath.section];
    self.thresholdTableViewCell.diaplayImageView.image = [UIImage imageNamed:imageArr[indexPath.section]];
    return self.thresholdTableViewCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
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
