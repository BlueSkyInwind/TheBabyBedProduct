//
//  ReceiveUdpMessage.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/19.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,ReceiveUdpMessageType) {
    
    AddressingMessageType = 1001,      //寻址 报文
    DiscoverMessageType,                   //发现 报文
    LoginMessageType,                       //登录报文
    HeartMessageType,                       //心跳报文
    NotificationType,                           //通知报文
    DeviceManagerType                      //设备管理报文
    
};

typedef void(^ReceiveUdpMessageResult)(ReceiveUdpMessageType type,id result);

@interface ReceiveUdpMessage : NSObject

@property(nonatomic, copy)ReceiveUdpMessageResult responseResult;

+(instancetype)initReceiveData:(NSData *)data complecation:(ReceiveUdpMessageResult)result;
-(void)receiveUdpMessage:(NSData *)data;


@end
