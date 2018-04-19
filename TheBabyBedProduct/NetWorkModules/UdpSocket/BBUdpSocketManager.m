//
//  BBUdpSocketManager.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/17.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBUdpSocketManager.h"
#import <CocoaAsyncSocket/GCDAsyncUdpSocket.h>
#import "CRC16.h"
#import "SocketMacros.h"
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
    
    _udpSocket = [[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:self.queue];
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
    
    Byte byteOne[4];
    unsigned char version = 0;    //版本
    unsigned char crypto = 0;     //加密类型
    short int checksum = 0;
    
    byteOne[0] = (((crypto << 4)&0xf0) | version);
    byteOne[1] = 0x04;
    byteOne[2] = ((checksum >> 8) & 0xff);
    byteOne[3] = (checksum & 0xff);
    NSMutableData * dataOne = [[NSMutableData alloc]initWithBytes:byteOne length:4];

    // 会话id ctrlAndExt
    Byte byteTwo[4];
    short int transID = 0;
    short int ctrlAndExt  = 0;

    byteTwo[0] = ((transID >> 8) & 0xff);
    byteTwo[1] = (transID  & 0xff);
    byteTwo[2] = ((ctrlAndExt >> 8) & 0xff);
    byteTwo[3] = (ctrlAndExt & 0xff);
    [self shortToBytes:7];
    [dataOne appendBytes:byteTwo length:4];

    // Frag Offset
    Byte byteThree[4];
    short int fragmentID = 0;
    short int fragOffset  = 0;
    byteThree[0] = ((fragmentID >> 8) & 0xff);
    byteThree[1] = (fragmentID  & 0xff);
    byteThree[2] = ((fragOffset >> 8) & 0xff);
    byteThree[3] = (fragOffset & 0xff);
    [dataOne appendBytes:byteThree length:4];

    Byte byteFour[4];
    short int dataLen = 0;
    short int reserved = 0;
    byteFour[0] = ((dataLen >> 8) & 0xff);
    byteFour[1] = (dataLen  & 0xff);
    byteFour[2] = ((reserved >> 8) & 0xff);
    byteFour[3] = (reserved & 0xff);
    [dataOne appendBytes:byteFour length:4];
    
    Byte byteFive[4];
    short int maslen = 8;
    byteFive[0] = 0x01;
    byteFive[1] = 0x00;
    byteFive[2] = ((maslen >> 8) & 0xff);
    byteFive[3] = (maslen & 0xff);
    [dataOne appendBytes:byteFive length:4];

    Byte bytesix[4];
    short int CRC = 0;
    short int random = 7;  //随机数
    bytesix[0] = ((CRC >> 8) & 0xff);
    bytesix[1] = (CRC  & 0xff);
    bytesix[2] = ((random >> 8) & 0xff);
    bytesix[3] = (random & 0xff);
    [dataOne appendBytes:bytesix length:4];
    
    NSData * bodyData = [self generateUdpBody];
    [dataOne appendData:bodyData];

    //YDAmaslen赋值；
    Byte headerByte[dataOne.length];
    Byte ctrlHeaderByte[dataOne.length - 16];
    [dataOne getBytes:headerByte length:dataOne.length];
    memcpy(ctrlHeaderByte, headerByte + 16, dataOne.length - 16);

    //DataLen
    short int yda_datalen = bodyData.length;
    headerByte[12] = ((yda_datalen >> 8) & 0xff);
    headerByte[13] = (yda_datalen  & 0xff);
    //
    short int yda_maslen = bodyData.length + 8;
    headerByte[18] = ((yda_maslen >> 8) & 0xff);
    headerByte[19] = (yda_maslen  & 0xff);
    
    short int num = (0x01 << 8) | 0x79;

//    CRC16* crcTwo = [[CRC16 alloc] initWithValue:0];
//    for (int it = 16; it < dataOne.length - 16; it++) {
//        [crcTwo update:headerByte[it]];
//    }
//    headerByte[20] = [crcTwo getByte1];
//    headerByte[21] = [crcTwo getByte2];
    
    unsigned short checksumOne = checksumAndCRC(headerByte, dataOne.length);
    headerByte[2] = ((checksumOne >> 8) & 0xff);
    headerByte[3] = (checksumOne  & 0xff);
    
    unsigned short checksumTwo = checksumAndCRC(ctrlHeaderByte, dataOne.length - 16);
    headerByte[20] = ((checksumTwo >> 8) & 0xff);
    headerByte[21] = (checksumTwo  & 0xff);
    
    NSData * resultData = [NSData dataWithBytes:headerByte length:dataOne.length];
    [self sendUdpData:resultData];
    
}

-(NSData *)generateUdpBody{
    
    NSMutableData * bodyData = [[self generateUdpBodyUnit:130 elementID:1 dataContent:nil] mutableCopy];
    [bodyData appendData: [self generateUdpBodyUnit:32 elementID:2 dataContent:nil]];
    [bodyData appendData: [self generateUdpBodyUnit:1 elementID:3 dataContent:nil]];
    [bodyData appendData: [self generateUdpBodyUnit:RSA_PUBLIC_KEY.length elementID:4 dataContent:RSA_PUBLIC_KEY]];
    return bodyData;
    
}

-(NSData *)generateUdpBodyUnit:(short int)length elementID:(short int)ID dataContent:(NSString *)dataContent {
    
    NSUInteger datalength = 2 + 2 + length;
    Byte bodyByte[datalength];
    short int elementID = ID;
    short int elementLength = length;
    bodyByte[0] = ((elementID >> 8) & 0xff);
    bodyByte[1] = (elementID  & 0xff);
    bodyByte[2] = ((elementLength >> 8) & 0xff);
    bodyByte[3] = (elementLength  & 0xff);
    if (dataContent != nil) {
//        NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(NSUTF16BigEndianStringEncoding);
//        NSData *data = [dataContent dataUsingEncoding:enc];
        NSData *rsaData = [dataContent dataUsingEncoding: NSUTF8StringEncoding];
        Byte * rsaDatabyte = (Byte *)[rsaData bytes];
        memcpy(bodyByte + 4, rsaDatabyte, length);
    }
    NSMutableData * bodyData = [[NSMutableData alloc]initWithBytes:bodyByte length:datalength];
    return bodyData;
}

#pragma mark - 基本数据类型转换

-(Byte *)shortToBytes: (short int ) value{
    Byte  * byte = (Byte  *)malloc(2);
    byte[0] = ((value >> 8) & 0xff);
    byte[1] = (value  & 0xff);
    return  byte;
}

// checksum 效验
unsigned short checksumAndCRC(unsigned short * buffer,int size)
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
