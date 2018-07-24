//
//  ConsoleRoomTemperatureViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ConsoleRoomTemperatureViewController.h"
#import "ConsoleHeaderView.h"
#import "RoomIndicatorView.h"
#import "RoomTemperatureChartViewController.h"
#import "CityListModel.h"
#import "ProvinceViewController.h"

@interface ConsoleRoomTemperatureViewController ()<BMKLocationServiceDelegate>{
    
    
    
}


@property (nonatomic,strong)ConsoleHeaderView * headerView;
@property (nonatomic,strong)RoomIndicatorView * indicatorView;
@property (nonatomic,strong)NSString * outdoorValue;
@property (nonatomic,strong)NSString * indoorValue;
@property (strong, nonatomic) BMKLocationService * locService;//定位


@end

@implementation ConsoleRoomTemperatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleStr = @"环境温度";
    [self configureView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(sensorDataUpdates:) name:YDA_EVENT_NOTIFICATION object:nil ];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = true;
    __weak typeof (self) weakSelf = self;
    NSDictionary * cityDic = [GlobalTool getContentWithKey:@"city_Name"];
    if (cityDic) {
        AreaListModel * model = [[AreaListModel alloc]initWithDictionary:cityDic error:nil];
        _headerView.locationLabel.text = model.name;
        [self obainWeatherInfo:model.en complication:^(NSString *temp) {
            weakSelf.outdoorValue = temp;
        }];
    }else{
        _headerView.locationLabel.text = @"获取中..";
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate = self;
        [_locService startUserLocationService];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = false;
}
-(void)setOutdoorValue:(NSString *)outdoorValue{
    _outdoorValue = outdoorValue;
    [_indicatorView setOutDoorIndcatorScale:outdoorValue.floatValue];
}
-(void)setIndoorValue:(NSString *)indoorValue{
    _indoorValue = indoorValue;
    [_indicatorView setOutDoorIndcatorScale:indoorValue.floatValue];

}

-(void)configureView{
    
    __weak typeof (self) weakSelf = self;
    _headerView = [[NSBundle mainBundle]loadNibNamed:@"ConsoleHeaderView" owner:self options:nil].lastObject;
    _headerView.titleLabel.text = self.title;
    _headerView.statusLabel.text = @"室内体温比较舒适";
    [_headerView resetConsoleSettingBtn:20];
    [_headerView.settingBtn setImage:[UIImage imageNamed:@"location_Icon"] forState:UIControlStateNormal];
    _headerView.locationLabel.text = @"";
    [self.view addSubview:_headerView];
    _headerView.backButtonClick = ^(UIButton *button) {
        [weakSelf.navigationController popViewControllerAnimated:true];
    };
    _headerView.settingButtonClick = ^(UIButton *button) {
        ProvinceViewController * vc = [[ProvinceViewController alloc]init];
        vc.dataArr = [weakSelf parseCityJsonData];
        [weakSelf.navigationController pushViewController:vc animated:true];
    };
    
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@210);
    }];
    
    _indicatorView = [[NSBundle mainBundle]loadNibNamed:@"RoomIndicatorView" owner:self options:nil].lastObject;
    [self.view addSubview:_indicatorView];
    _indicatorView.roomTemperatureCurveClick = ^{
//    [weakSelf.indicatorView setInDoorIndcatorScale:0.3];
        RoomTemperatureChartViewController * roomTemPeratureChartVC = [[RoomTemperatureChartViewController alloc]init];
        roomTemPeratureChartVC.isOutside = false;
        [weakSelf.navigationController pushViewController:roomTemPeratureChartVC animated:true];
    };
    
    _indicatorView.outdoorTemperatureCurveClick = ^{
        RoomTemperatureChartViewController * roomTemPeratureChartVC = [[RoomTemperatureChartViewController alloc]init];
        roomTemPeratureChartVC.isOutside = false;
        [weakSelf.navigationController pushViewController:roomTemPeratureChartVC animated:true];
    };
    
    [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(self.headerView.mas_bottom).with.offset(5);
        make.height.equalTo(@(_k_h - 210));
    }];
}
#pragma mark - 传感器数据通知状态
-(void)sensorDataUpdates:(NSNotification *)notification{
    NSDictionary * valueDic = notification.userInfo;
    DLog(@"%@",valueDic);
    NSNumber * indoorAndOutdoorTemperature = valueDic[Env_Temp_Value];
    self.indoorValue = [NSString stringWithFormat:@"%@",indoorAndOutdoorTemperature];
    NSString * State = @"室内体温比较舒适";
    _headerView.statusLabel.text = State;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


-(NSArray *)parseCityJsonData{
    
    NSMutableArray * cityArray = [NSMutableArray array];
    //JSON文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bbCityList.json" ofType:nil];
    //加载JSON文件
    NSData *data = [NSData dataWithContentsOfFile:path];
    //将JSON数据转为NSArray或NSDictionary
    NSArray *dictArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dic in dictArray) {
        ProvinceListModel * model = [[ProvinceListModel alloc]initWithDictionary:dic error:nil];
        [cityArray addObject:model];
    }
    return cityArray;
}
-(void)obainWeatherInfo:(NSString *)en complication:(void(^)(NSString * temp))finish{
    
    [BBRequestTool applyCityWeatherInfo:en successBlock:^(EnumServerStatus status, id object) {
        NSDictionary * dic = object;
        if ([dic.allKeys containsObject:@"HeWeather6"]) {
            NSArray * arr = dic[@"HeWeather6"];
            NSDictionary * infoDic = arr[0];
            if ([infoDic.allKeys containsObject:@"now"]) {
                NSDictionary * tempDic = infoDic[@"now"];
                NSString * value = tempDic [@"tmp"];
                finish(value);
            }
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
    }];
    
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
                _headerView.locationLabel.text = placemark.subLocality;
                __weak typeof (self) weakSelf = self;
                [self obainWeatherInfo:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.latitude] lon:[NSString stringWithFormat:@"%f",userLocation.location.coordinate.longitude] complication:^(NSString *temp) {
                    weakSelf.outdoorValue = temp;
                }];
            }
        }
    }];
}

-(void)obainWeatherInfo:(NSString *)lat lon:(NSString *)lon  complication:(void(^)(NSString * temp))finish{
    
    [BBRequestTool applyCityWeatherInfo:lat lon:lon successBlock:^(EnumServerStatus status, id object) {
        NSDictionary * dic = object;
        if ([dic.allKeys containsObject:@"HeWeather6"]) {
            NSArray * arr = dic[@"HeWeather6"];
            NSDictionary * infoDic = arr[0];
            if ([infoDic.allKeys containsObject:@"now"]) {
                NSDictionary * tempDic = infoDic[@"now"];
                NSString * value = tempDic [@"tmp"];
                finish(value);
            }
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        DLog(@"%@",object);
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
