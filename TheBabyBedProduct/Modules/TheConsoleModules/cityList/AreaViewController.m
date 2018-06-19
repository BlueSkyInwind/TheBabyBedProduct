//
//  AreaViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/6/19.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "AreaViewController.h"
#import "AreaViewController.h"
#import "CityListModel.h"
#import "ConsoleRoomTemperatureViewController.h"

@interface AreaViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView  * areaTableView;

@end

@implementation AreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"地区";
    [self addBackItem];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)configureView{
    
    self.areaTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.areaTableView.delegate = self;
    self.areaTableView.dataSource = self;
    [self.view addSubview:_areaTableView];
    [_areaTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * cellStr = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
    }
    AreaListModel * model = _dataArr[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AreaListModel * model = _dataArr[indexPath.row];
    NSDictionary * dic = [model toDictionary];
    [GlobalTool saveUserDefaul:dic Key:@"city_Name"];
    for (UIViewController * vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[ConsoleRoomTemperatureViewController class]]) {
            [self.navigationController popToViewController:vc animated:true];
        }
    }

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
