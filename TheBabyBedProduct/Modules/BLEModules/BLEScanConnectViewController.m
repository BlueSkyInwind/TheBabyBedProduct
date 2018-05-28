//
//  BLEScanConnectViewController.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/4/23.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BLEScanConnectViewController.h"
#import "QRScanView.h"
#import "BLEPairingViewController.h"

@interface BLEScanConnectViewController (){
    CGRect qrFrame;
}
/* 扫描视图*/
@property(nonatomic,strong)QRScanView * scanView;
@end

@implementation BLEScanConnectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"扫一扫";
    [self addBackItem];
    [self configrueView];
}
-(void)configrueView{
    
    self.scanButton.layer.cornerRadius = self.scanButton.bounds.size.height / 2;
    self.scanButton.clipsToBounds = true;
    
}

-(void)viewDidLayoutSubviews{
    qrFrame = _qrScanView.frame;
    __weak typeof (self) weakSelf = self;
    if (_scanView) {
        return;
    }
    _scanView = [QRScanView defaultShareFrame:CGRectMake(0, 0, _qrScanView.frame.size.width, _qrScanView.frame.size.height) resultBlock:^(NSString *result) {
        [weakSelf.scanView stop];
        
    }];
    [self.qrScanView addSubview:_scanView];
}
- (void)reStartScan
{
    if (!_scanView) {
        return;
    }
    [_scanView start];
    if (!_scanView.is_AnmotionFinished) {
        [_scanView loopDrawLine];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self reStartScan];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_scanView) {
        [_scanView stop];
    }
}
- (IBAction)manualConnectBLEClick:(id)sender {
    BLEPairingViewController * blePairingVC = [[BLEPairingViewController alloc]init];
    [self.navigationController pushViewController:blePairingVC animated:true];
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
