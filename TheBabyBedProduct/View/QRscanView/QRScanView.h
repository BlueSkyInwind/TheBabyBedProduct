//
//  QRScanView.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/3.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScanResultBlock)(NSString * result);

@interface QRScanView : UIView


/* 扫描线*/
@property(nonatomic,strong)UIView * scanView;

/* <#Description#>*/
@property(nonatomic,assign)BOOL  is_AnmotionFinished;

/* 结果*/
@property(nonatomic,copy)ScanResultBlock scanResultBlock;

+(instancetype)defaultShareFrame:(CGRect)frame resultBlock:(ScanResultBlock)scanResult;

- (void)start;
- (void)stop;
-(void)loopDrawLine;

@end
