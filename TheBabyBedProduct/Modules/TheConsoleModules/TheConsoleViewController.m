//
//  TheConsoleViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/20.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "TheConsoleViewController.h"
#import "ConsoleHeaderView.h"
#import "ConsoleBodyView.h"
#import "ConsoleRateViewController.h"
#import "ConsoleTemperatureViewController.h"
#import "ConsoleRoomTemperatureViewController.h"
#import "ConsoleVideoViewController.h"

@interface TheConsoleViewController ()<BMKLocationServiceDelegate>

@property (nonatomic,strong)ConsoleHeaderView * headerView;
@property (nonatomic,strong)ConsoleBodyView * bodyView;

@property (strong, nonatomic) BMKLocationService * locService;//定位

@end

@implementation TheConsoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = true;
    if  (BBUserHelpers.hasLogined) {
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
        [_locService startUserLocationService];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = false;
}

-(void)configureView{
    
    CGFloat headerHeight = 190;
    if (UI_IS_IPHONE6P) {
        headerHeight = 220;
    }
    
    _headerView = [[NSBundle mainBundle]loadNibNamed:@"ConsoleHeaderView" owner:self options:nil].lastObject;
    _headerView.backBtn.hidden = true;
    _headerView.settingBtn.hidden = true;
    _headerView.statusLabel.hidden = true;
    [self.view addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@(headerHeight));
    }];
    
    _bodyView = [[NSBundle mainBundle]loadNibNamed:@"ConsoleBodyView" owner:self options:nil].lastObject;
    _bodyView.backgroundColor = rgb(247, 248, 251, 1);
    [self.view addSubview:_bodyView];
    [_bodyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.headerView.mas_bottom).with.offset(10);
        make.height.equalTo(@(_k_h - headerHeight));
    }];
    
    __weak typeof (self) weakSelf = self;
    _bodyView.bobyTemperatureBtnClick = ^(UIButton *button) {
        [weakSelf pushLoginAndregister];
        ConsoleTemperatureViewController * temVC = [[ConsoleTemperatureViewController alloc]init];
        [weakSelf.navigationController pushViewController:temVC animated:true];
    };
    
    _bodyView.roomTemperatureBtnClick = ^(UIButton *button) {
        [weakSelf pushLoginAndregister];
        ConsoleRoomTemperatureViewController * consoleRoomTemperature = [[ConsoleRoomTemperatureViewController alloc]init];
        [weakSelf.navigationController pushViewController:consoleRoomTemperature animated:true];
    };
    
    _bodyView.cryingBtnClick = ^(UIButton *button) {
        [weakSelf pushLoginAndregister];
        ConsoleRateViewController * rateVC = [[ConsoleRateViewController alloc]init];
        rateVC.rateType = BabyCryType;
        [weakSelf.navigationController pushViewController:rateVC animated:true];
    };
    
    _bodyView.wettingBtnClick = ^(UIButton *button) {
        [weakSelf pushLoginAndregister];
        ConsoleRateViewController * rateVC = [[ConsoleRateViewController alloc]init];
        rateVC.rateType = BabyWetType;
        [weakSelf.navigationController pushViewController:rateVC animated:true];
    };
    
    _bodyView.qulitBtnClick = ^(UIButton *button) {
        [weakSelf pushLoginAndregister];
        ConsoleRateViewController * rateVC = [[ConsoleRateViewController alloc]init];
        rateVC.rateType = BabyKickType;
        [weakSelf.navigationController pushViewController:rateVC animated:true];
    };
    
    _bodyView.videoBtnClick = ^(UIButton *button) {
        [weakSelf pushLoginAndregister];
        ConsoleVideoViewController *videoVC = [[ConsoleVideoViewController alloc]init];
        [weakSelf.navigationController pushViewController:videoVC animated:YES];
    };
}

-(void)pushLoginAndregister{
    if  (BBUserHelpers.hasLogined == false) {
        [self bb_goLoginRegistVC:^(BOOL isSuccess) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    NSLog(@"方向更新%f  %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"定位失败%@",error);
}


/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //定位当前城市
    BMKCoordinateRegion region;
    region.center.latitude  = userLocation.location.coordinate.latitude;
    region.center.longitude = userLocation.location.coordinate.longitude;
    region.span.latitudeDelta = 0;
    region.span.longitudeDelta = 0;
    NSLog(@"当前的坐标是:%f,%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            if (placemark != nil) {
                NSString *city = placemark.locality;
                NSLog(@"当前城市名称------%@",city);
                BMKOfflineMap * _offlineMap = [[BMKOfflineMap alloc] init];
                // _offlineMap.delegate = self;//可以不要
                NSArray* records = [_offlineMap searchCity:city];
                BMKOLSearchRecord* oneRecord = [records objectAtIndex:0];
                //城市编码如:北京为131
                NSInteger cityId = oneRecord.cityID;
                NSLog(@"当前城市编号-------->%zd",cityId);
                NSLog(@"当前城市的 哪个区------%@ ",placemark.subLocality);
                //找到了当前位置城市后就关闭服务
                 [_locService stopUserLocationService];
            }
        }
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
