//
//  QRScanView.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/3.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "QRScanView.h"
#import <AVFoundation/AVFoundation.h>
@interface QRScanView()<AVCaptureMetadataOutputObjectsDelegate>{
    
    AVCaptureSession * session;

}

@end


@implementation QRScanView

+(instancetype)defaultShareFrame:(CGRect)frame resultBlock:(ScanResultBlock)scanResult{
    QRScanView * scanView = [[QRScanView alloc]initWithFrame:frame];
    scanView.is_AnmotionFinished = NO;
    [scanView loopDrawLine];
    scanView.backgroundColor = [UIColor clearColor];
    scanView.scanResultBlock = scanResult;
    return scanView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self instanceScanDevice];
    }
    return self;
}

-(void)instanceScanDevice{
    
    //获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    //创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];
    //设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    output.rectOfInterest = CGRectMake(0, 0, 1, 1);
    
    //初始化链接对象
    session = [[AVCaptureSession alloc]init];
    //高质量采集率
    [session setSessionPreset:AVCaptureSessionPresetHigh];
    if (input) {
        [session addInput:input];
    }
    if (output) {
        [session addOutput:output];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        NSMutableArray *a = [[NSMutableArray alloc] init];
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeQRCode]) {
            [a addObject:AVMetadataObjectTypeQRCode];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN13Code]) {
            [a addObject:AVMetadataObjectTypeEAN13Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeEAN8Code]) {
            [a addObject:AVMetadataObjectTypeEAN8Code];
        }
        if ([output.availableMetadataObjectTypes containsObject:AVMetadataObjectTypeCode128Code]) {
            [a addObject:AVMetadataObjectTypeCode128Code];
        }
        output.metadataObjectTypes=a;
    }
    
    AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:session];
    layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
    layer.frame=self.layer.bounds;
    [self.layer insertSublayer:layer atIndex:0];
    
    //开始捕获
    _is_AnmotionFinished = NO;
    [session startRunning];

}

- (void)start
{
    _is_AnmotionFinished = NO;
    [session startRunning];
}

- (void)stop
{
    _is_AnmotionFinished = true;
    [session stopRunning];
}

#pragma mark - 扫描结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects && metadataObjects.count>0) {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
        //输出扫描字符串
        if (self.scanResultBlock) {
            //播放扫描二维码的声音
            SystemSoundID soundID;
            NSString *strSoundFile = [[NSBundle mainBundle] pathForResource:@"noticeMusic" ofType:@"wav"];
            if (strSoundFile) {
                AudioServicesCreateSystemSoundID((__bridge  CFURLRef)[NSURL fileURLWithPath:strSoundFile],&soundID);
            }
            AudioServicesPlaySystemSound(soundID);
            
            self.scanResultBlock(metadataObject.stringValue);
        }
    }
}
-(void)loopDrawLine
{
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, 2);
    if (_scanView) {
        _scanView.alpha = 1;
        _scanView.frame = rect;
    }
    else{
        _scanView = [[UIView alloc] initWithFrame:rect];
        _scanView.backgroundColor = UI_MAIN_COLOR;
        [self addSubview:_scanView];
    }
    
    [UIView animateWithDuration:1.5 animations:^{
        //修改fream的代码写在这里
        _scanView.frame =CGRectMake(0, self.bounds.size.height, self.bounds.size.width, 2);
    } completion:^(BOOL finished) {
        if (!_is_AnmotionFinished) {
            [self loopDrawLine];
        }
    }];
}
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    
    CGFloat x,y,width,height;
    
    x = (CGRectGetHeight(readerViewBounds)-CGRectGetHeight(rect))/2/CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds)-CGRectGetWidth(rect))/2/CGRectGetWidth(readerViewBounds);
    width = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    
    return CGRectMake(x, y, width, height);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
