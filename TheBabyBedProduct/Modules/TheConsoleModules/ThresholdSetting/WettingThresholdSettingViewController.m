//
//  WettingThresholdSettingViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "WettingThresholdSettingViewController.h"
#import "ThresholdTableViewCell.h"
#import "ForecastValuesModel.h"
#import "UIImageView+WebCache.h"

@interface WettingThresholdSettingViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    
    NSArray<NSString *> * titleArr;
    NSArray<NSString *> * imageArr;
    ForecastValuesInfo * forecastValuesinfo;
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
    __weak typeof (self) weakSelf = self;
    [self getCryingThresholdValueComplication:^(BOOL isSuccess, ForecastValuesInfo *info) {
        if (isSuccess) {
            self.contentTextField.text = info.maxVal;
            forecastValuesinfo = info;
            [weakSelf.displayTableView reloadData];
        }
    }];
}

-(void)configureView{
    
    self.view.backgroundColor = kUIColorFromRGB(0xF7F9FB);
    self.displayTableView.backgroundColor = kUIColorFromRGB(0xF7F9FB);
    self.contentTextField.delegate = self;
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
    switch (indexPath.section) {
        case 0:{
            if (forecastValuesinfo.qw_niao == nil) {
                self.thresholdTableViewCell.diaplayImageView.image = [UIImage imageNamed:imageArr[indexPath.section]];
            }else{
                [self.thresholdTableViewCell.diaplayImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",K_Url_GetImg,forecastValuesinfo.qw_niao]] placeholderImage:nil];
            }
        }
            break;
        case 1:{
            if (forecastValuesinfo.zd_niao == nil) {
                self.thresholdTableViewCell.diaplayImageView.image = [UIImage imageNamed:imageArr[indexPath.section]];
            }else{
                [self.thresholdTableViewCell.diaplayImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",K_Url_GetImg,forecastValuesinfo.zd_niao]] placeholderImage:nil];
            }
        }
            break;
        case 2:{
            if (forecastValuesinfo.zdd_niao == nil) {
                self.thresholdTableViewCell.diaplayImageView.image = [UIImage imageNamed:imageArr[indexPath.section]];
            }else{
                [self.thresholdTableViewCell.diaplayImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",K_Url_GetImg,forecastValuesinfo.zdd_niao]] placeholderImage:nil];
            }
        }
            break;
        case 3:{
            if (forecastValuesinfo.gz_niao == nil) {
                self.thresholdTableViewCell.diaplayImageView.image = [UIImage imageNamed:imageArr[indexPath.section]];
            }else{
                [self.thresholdTableViewCell.diaplayImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",K_Url_GetImg,forecastValuesinfo.gz_niao]] placeholderImage:nil];
            }
        }
            break;
        default:
            break;
    }
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
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
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
-(void)getCryingThresholdValueComplication:(void(^)(BOOL isSuccess,ForecastValuesInfo * info))finish{
    [BBRequestTool GetThresholdValueDeviceType:@"3" deviceId:[BBUser bb_getUser].deviceId successBlock:^(EnumServerStatus status, id object) {
        ForecastValuesModel *resultM = [[ForecastValuesModel alloc] initWithDictionary:object error:nil];
        if (resultM.code == 0) {
            finish(true,resultM.data);
        }else{
            [QMUITips showWithText:resultM.msg inView:self.view hideAfterDelay:0.5];
            finish(false,nil);
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        finish(false,nil);
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
