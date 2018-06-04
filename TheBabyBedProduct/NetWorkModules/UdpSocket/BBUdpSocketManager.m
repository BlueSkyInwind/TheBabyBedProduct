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
    
    NSInteger heartNoResponseCount;   //未收到心跳的计数，上限为3次，未收到发起重连
    
}


/* <#Description#>*/
@property(nonatomic,strong)GCDAsyncUdpSocket * udpSocket;

/* <#Description#>*/
@property(nonatomic,strong)dispatch_queue_t  queue;

/* */
@property(nonatomic,strong)dispatch_queue_t  heartQueue;

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

-(dispatch_queue_t)heartQueue{
    if (_heartQueue == nil){
        _heartQueue = dispatch_queue_create("com.BB.heart", NULL);
    }
    return _heartQueue;
}

-(void)createAsyncUdpSocket{
    
    if(_udpSocket){
        return;
    }
    sendCount = 2;
    TransID = 2;
    heartNoResponseCount = 4;

    _udpSocket = [[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:self.queue];
    NSError * error = nil;
    [_udpSocket bindToPort:K_port_BBUDP error:&error];
    if (error) {
        DLog(@"error:%@",error);
    }else {
        [_udpSocket beginReceiving:&error];
    }
    
    [self sendAddressMessage];

}

#pragma mark - GCDAsyncUdpSocket delegate
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    sendCount ++;
    if (tag == 1004) {
        heartNoResponseCount ++;
    }
    DLog(@"发送信息成功 %ld",tag);
}
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    DLog(@"发送信息失败");
}
- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext
{
    DLog(@"接收到%@的消息",address);
    [ReceiveUdpMessage initReceiveData:data complecation:^(ReceiveUdpMessageType type, int errCode,id result) {
        [self receiveMessageData:type errcode:errCode result:result];
    }];
}
- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error
{
    DLog(@"udpSocket关闭");
    _udpSocket = nil;
}

-(void)sendUdpData:(NSData *)data tag:(long)tag{
    [_udpSocket sendData:data toHost:hostStr port:port withTimeout:-1 tag:tag];
}

-(void)createHeartData{
    dispatch_async(self.heartQueue, ^{
        heartTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(sendHeartData) userInfo:nil repeats:true];
        [[NSRunLoop currentRunLoop] addTimer:heartTimer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
    });
}
-(void)sendHeartData{
    //如果超过三次为收到心跳确认，重新发起上线请求
    if (heartNoResponseCount > 3) {
        [self sendDiscoverRequestMessage];
        [heartTimer invalidate];
        heartTimer = nil;
        return;
    }
    [self sendHeartbeatRequestMessage];
}
#pragma mrak - 报文发送
-(void)sendAddressMessage{
    
    SendUdpMessage * sendMessage = [[SendUdpMessage alloc]init];
    NSData * addressData = [sendMessage generateAddressingMessage];
    [self sendUdpData:addressData tag:1001];
    
}
-(void)sendDiscoverRequestMessage{
    
    SendUdpMessage * sendMessage = [[SendUdpMessage alloc]init];
    NSData * discoverRequestData = [sendMessage generateDiscoverRequestMessage];
    [self sendUdpData:discoverRequestData tag:1002];
    
}
-(void)sendLoginRequestMessage{
    
    SendUdpMessage * sendMessage = [[SendUdpMessage alloc]init];
    NSData * LoginRequestData = [sendMessage generateLoginRequestMessage];
    [self sendUdpData:LoginRequestData tag:1003];
    
}
-(void)sendHeartbeatRequestMessage{
    
    SendUdpMessage * sendMessage = [[SendUdpMessage alloc]init];
    NSData * discoverRequestData = [sendMessage generateHeartbeatRequestMessage];
    [self sendUdpData:discoverRequestData tag:1004];
    
}
-(void)sendCFGSettingRequestMessage:(NSDictionary *)dic{
    
    SendUdpMessage * sendMessage = [[SendUdpMessage alloc]init];
    NSData * CFGSettingRequestData = [sendMessage generateCFGSettingRequestMessage:dic];
    [self sendUdpData:CFGSettingRequestData tag:1007];
    
}

-(void)sendEventNotificationRequestMessage:(NSDictionary *)eventDic{
    
    SendUdpMessage * sendMessage = [[SendUdpMessage alloc]init];
    NSData * discoverRequestData = [sendMessage generateEventNotificationRequestMessage:@{Env_Temp_Value:@(24)}];
    [self sendUdpData:discoverRequestData tag:1005];
    
}
-(void)sendEquipmentmanagementRequestMessage{
    
    SendUdpMessage * sendMessage = [[SendUdpMessage alloc]init];
    NSData * discoverRequestData = [sendMessage generateEquipmentmanagementRequestMessage];
    [self sendUdpData:discoverRequestData tag:1006];
    
}
#pragma mrak - 报文接收处理
-(void)receiveMessageData:(ReceiveUdpMessageType)type errcode:(int)errCode result:(id)result{
    
    switch (type) {
        case AddressingMessageType:{
            if (errCode == 0) {
                [self sendDiscoverRequestMessage];
            }else{
                [self sendAddressMessage];
            }
        }
            break;
        case DiscoverMessageType:{
            if (errCode == 0) {
                [self sendLoginRequestMessage];
            }else{
                [self sendDiscoverRequestMessage];
            }
        }
            break;
        case LoginMessageType:{
            if (errCode == 0) {
                heartNoResponseCount = 0;
                [self createHeartData];
            }else{
                
            }
        }
            break;
        case HeartMessageType:{
            heartNoResponseCount = heartNoResponseCount > 0 ? heartNoResponseCount -= 1 : 0;
        }
            break;
        case NotificationType:{
            if (errCode == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary * dic = (NSDictionary *)result;
                    [[NSNotificationCenter defaultCenter] postNotificationName:YDA_EVENT_NOTIFICATION object:self userInfo:dic];
                });
            }
        }
            break;
        case CFGMessageType:{
            if (errCode == 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDictionary * dic = (NSDictionary *)result;
                    [[NSNotificationCenter defaultCenter] postNotificationName:YDA_EVENT_NOTIFICATION object:self userInfo:dic];
                });
            }
        }
            break;
        default:
            break;
    }
    
    
}












@end
