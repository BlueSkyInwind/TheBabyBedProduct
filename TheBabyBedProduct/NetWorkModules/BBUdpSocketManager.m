//
//  BBUdpSocketManager.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/17.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBUdpSocketManager.h"
#import <CocoaAsyncSocket/GCDAsyncUdpSocket.h>

@interface BBUdpSocketManager()<GCDAsyncUdpSocketDelegate>{
    
    NSString * hostStr;
    uint16_t port;
    
    NSTimer * heartTimer;
    
}


/* <#Description#>*/
@property(nonatomic,strong)GCDAsyncUdpSocket * udpSocket;

/* <#Description#>*/
@property(nonatomic,strong)dispatch_queue_t  queue;

@end


@implementation BBUdpSocketManager

+(BBUdpSocketManager *)shareInstance{
    
    static BBUdpSocketManager * socketManeger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        socketManeger = [[BBUdpSocketManager alloc]init];
    });
    return socketManeger;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        hostStr = K_Url_BBUDP;
        port = K_port_BBUDP;
    }
    return self;
}

-(dispatch_queue_t)queue{
    if (_queue == nil){
        _queue = dispatch_queue_create("com.BB.Socket", NULL);
    }
    return _queue;
}

-(void)createAsyncUdpSocket{
    
    if(_udpSocket){
        return;
    }
    
    _udpSocket = [[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:_queue];
    NSError * error = nil;
    [_udpSocket bindToPort:K_port_BBUDP error:&error];
    if (error) {
        DLog(@"error:%@",error);
    }else {
        [_udpSocket beginReceiving:&error];
    }
    
    [self generateAddressingMessage];
}

#pragma mark - GCDAsyncUdpSocket delegate
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    DLog(@"发送信息成功");
}
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    DLog(@"发送信息失败");
}
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
    DLog(@"接收到%@的消息",address);
}
- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error
{
    DLog(@"udpSocket关闭");
    _udpSocket = nil;
}

-(void)sendUdpData:(NSData *)data{
    
    
    
    [_udpSocket sendData:data toHost:hostStr port:port withTimeout:-1 tag:1000];
    
}

-(void)createHeartData{
    heartTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(sendHeartData) userInfo:nil repeats:true];
}

-(void)sendHeartData{
    
    
    
}


-(void)generateAddressingMessage{
    
    Byte byteOne[2];
    unsigned char version = 0;    //版本
    unsigned char crypto = 0;     //加密类型
    byteOne[0] = version&0x0f;
    byteOne[0] = (crypto&0xf0) >> 4;
    byteOne[1] = 0x0c;
    
    NSMutableData * dataOne = [[NSMutableData alloc]initWithBytes:byteOne length:2];
    //checksum
    
    
    // 会话id ctrlAndExt
    Byte byteTwo[4];
    short int transID = 0;
    short int ctrlAndExt  = 0;
//    Byte transIDByte[2];
//    memcpy(&transIDByte,[self shortToBytes:transID], 2);
    byteTwo[0] = ((transID >> 8) & 0xff);
    byteTwo[1] = (transID  & 0xff);
    byteTwo[2] = ((ctrlAndExt >> 8) & 0xff);
    byteTwo[3] = (ctrlAndExt & 0xff);
    NSMutableData * dataTwo = [[NSMutableData alloc]initWithBytes:byteTwo length:4];

    
    
    // Frag Offset
    Byte byteThree[4];
    short int fragmentID = 0;
    short int fragOffset  = 0;
    byteThree[0] = ((fragmentID >> 8) & 0xff);
    byteThree[1] = (fragmentID  & 0xff);
    byteThree[2] = ((fragOffset >> 8) & 0xff);
    byteThree[3] = (fragOffset & 0xff);
    NSMutableData * dataThree = [[NSMutableData alloc]initWithBytes:byteThree length:4];

    
    //
    Byte byteFour[4];
    short int dataLen = 0;
    short int reserved = 0;
    byteFour[0] = ((dataLen >> 8) & 0xff);
    byteFour[1] = (dataLen  & 0xff);
    byteFour[2] = ((reserved >> 8) & 0xff);
    byteFour[3] = (reserved & 0xff);
    NSMutableData * datafour = [[NSMutableData alloc]initWithBytes:byteFour length:4];

    
    Byte byteFive[4];
    short int maslen = 8;
    byteFive[0] = 0x01;
    byteFive[1] = 0x00;
    byteFive[2] = ((maslen >> 8) & 0xff);
    byteFive[3] = (maslen & 0xff);
    NSMutableData * datafive = [[NSMutableData alloc]initWithBytes:byteFive length:4];

    
    
    Byte bytesix[4];
    short int CRC = 0;
    short int random = 7;  //随机数
    bytesix[0] = ((CRC >> 8) & 0xff);
    bytesix[1] = (CRC  & 0xff);
    bytesix[2] = ((random >> 8) & 0xff);
    bytesix[3] = (random & 0xff);
    NSMutableData * datasix = [[NSMutableData alloc]initWithBytes:bytesix length:4];

    
    
}

-(void)version:(unsigned char)version Crypto:(unsigned char)crypto{
    
    
    
    
}

#pragma mark - 基本数据类型转换

-(Byte)shortToBytes: (short int ) value{
    Byte byte[2];
    byte[0] = ((value >> 8) & 0xff);
    byte[1] = (value  & 0xff);
    return byte[2];
}

// checksum 效验
unsigned short checksum(unsigned short * buffer,int size)
{
    unsigned long cksum=0;
    while(size>1){
        cksum += * buffer++;
        size-=sizeof(unsigned short);
    }
    if(size){
        cksum+=*(unsigned char *)buffer;
    }
    while (cksum>>16)
        cksum=(cksum>>16)+(cksum &0xffff);
    return (unsigned short) (~cksum);
}














@end
