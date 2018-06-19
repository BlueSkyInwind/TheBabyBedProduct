//
//  ProvinceViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/6/19.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ProvinceViewController.h"
#import "CityListModel.h"
#import "CityViewController.h"

@interface ProvinceViewController ()<UITableViewDataSource,UITableViewDelegate>

/* */
@property(nonatomic,strong)UITableView  * provinceTableView;
@end

@implementation ProvinceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"省份";
    [self addBackItem];
    [self configureView];
}

-(void)configureView{
    
    self.provinceTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.provinceTableView.delegate = self;
    self.provinceTableView.dataSource = self;
    [self.view addSubview:_provinceTableView];
    [_provinceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    ProvinceListModel * model = _dataArr[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProvinceListModel * model = _dataArr[indexPath.row];
    CityViewController * vc = [[CityViewController alloc]init];
    vc.dataArr = model.citylist;
    [self.navigationController pushViewController:vc animated:true];
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
