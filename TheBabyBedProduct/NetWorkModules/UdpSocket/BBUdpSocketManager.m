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
#import "SendUdpMessage.h"
#import "ReceiveUdpMessage.h"

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

short int sendCount;
short int TransID;

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
    sendCount = 2;
    TransID = 2;
    _udpSocket = [[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:self.queue];
    NSError * error = nil;
    [_udpSocket bindToPort:K_port_BBUDP error:&error];
    if (error) {
        DLog(@"error:%@",error);
    }else {
        [_udpSocket beginReceiving:&error];
    }
    
    [self sendAddressMessage];
//    [self sendDiscoverRequestMessage];
}

#pragma mark - GCDAsyncUdpSocket delegate
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    sendCount ++;
    DLog(@"发送信息成功");
}
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    DLog(@"发送信息失败");
}
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
    DLog(@"接收到%@的消息",address);
    [ReceiveUdpMessage initReceiveData:data complecation:^(ReceiveUdpMessageType type, id result) {
        [self receiveMessageData:type result:result];
    }];
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
    dispatch_async(_queue, ^{
        heartTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(sendHeartData) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop] addTimer:heartTimer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
    });
}
-(void)sendHeartData{
    [self sendHeartbeatRequestMessage];
}
#pragma mrak - 报文发送
-(void)sendAddressMessage{
    
    SendUdpMessage * sendMessage = [[SendUdpMessage alloc]init];
    NSData * addressData = [sendMessage generateAddressingMessage];
    [self sendUdpData:addressData];
    
}
-(void)sendDiscoverRequestMessage{
    
    SendUdpMessage * sendMessage = [[SendUdpMessage alloc]init];
    NSData * discoverRequestData = [sendMessage generateDiscoverRequestMessage];
    [self sendUdpData:discoverRequestData];
    
}
-(void)sendLoginRequestMessage{
    
    SendUdpMessage * sendMessage = [[SendUdpMessage alloc]init];
    NSData * discoverRequestData = [sendMessage generateLoginRequestMessage];
    [self sendUdpData:discoverRequestData];
    
}
-(void)sendHeartbeatRequestMessage{
    
    SendUdpMessage * sendMessage = [[SendUdpMessage alloc]init];
    NSData * discoverRequestData = [sendMessage generateHeartbeatRequestMessage];
    [self sendUdpData:discoverRequestData];
    
}
#pragma mrak - 报文接收处理
-(void)receiveMessageData:(ReceiveUdpMessageType)type result:(id)result{
    
    switch (type) {
        case AddressingMessageType:{
            [self sendDiscoverRequestMessage];
        }
            break;
        case DiscoverMessageType:{
            int errCode = [result intValue];
            if (errCode == 0) {
                [self sendLoginRequestMessage];
            }else{
                
            }
            break;
        }
        case LoginMessageType:{
            int errCode = [result intValue];
            if (errCode == 0) {
                [self sendHeartbeatRequestMessage];
            }else{
                
            }
            break;
        }
        default:
            break;
    }
    
    
}












@end
