//
//  CityViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/6/19.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "CityViewController.h"
#import "AreaViewController.h"
#import "CityListModel.h"

@interface CityViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView  * cityTableView;

@end

@implementation CityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleStr = @"市区";
    [self configureView];

}
-(void)configureView{
    
    self.cityTableView = [PPMAKE(PPMakeTypeTableVPlain) pp_make:^(PPMake *make) {
        make.intoView(self.view);
        make.frame(CGRectMake(0, PPDevice_navBarHeight, _k_w, _k_h-PPDevice_navBarHeight));
        make.delegate(self);
    }];
    
//    [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
//    self.cityTableView.delegate = self;
//    self.cityTableView.dataSource = self;
//    [self.view addSubview:_cityTableView];
//    [_cityTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }];
    
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
    CityListModel * model = _dataArr[indexPath.row];
    cell.textLabel.text = model.name;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityListModel * model = _dataArr[indexPath.row];
    AreaViewController * vc = [[AreaViewController alloc]init];
    vc.dataArr = model.arealist;
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
