//
//  ReceiveUdpMessage.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/19.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ReceiveUdpMessage.h"
#import "SocketMacros.h"

@implementation ReceiveUdpMessage


-(void)receiveUdpMessage:(NSData *)data{
    
    Byte receiveByte[data.length];
    [data getBytes:receiveByte length:data.length];
    Byte ctrlHeaderByte[data.length - YDA_HAEDER_LENGTH];
    memcpy(ctrlHeaderByte, receiveByte + YDA_HAEDER_LENGTH, data.length - YDA_HAEDER_LENGTH);
    unsigned char msgType = ctrlHeaderByte[0];
    @try{
        if (msgType == 0x02) {
            //寻址相应报文
            DLog(@"寻址相应报文类型 ---- %c",msgType);
            NSData *ctrlData = [NSData dataWithBytes:ctrlHeaderByte length:data.length - YDA_HAEDER_LENGTH];
            [self analysisYDACtrlHeader:ctrlData];
        }
    }@catch (NSException * exception){
        DLog(@"解析报文出现异常%@",exception);
    }@finally{
        
    }
}


#pragma mark - 寻址相应报文解析
/**
 解析寻址响应的udp报文

 @param ctrlHeaderData 数据包
 */
-(void)analysisYDACtrlHeader:(NSData *)ctrlHeaderData{
    
    Byte receiveCtrlByte[ctrlHeaderData.length];
    Byte receivePayLoad[ctrlHeaderData.length - YDA_CTRL_HAEDER_LENGTH];
    [ctrlHeaderData getBytes:receiveCtrlByte length:ctrlHeaderData.length];
    memcpy(receivePayLoad, receiveCtrlByte + YDA_CTRL_HAEDER_LENGTH, ctrlHeaderData.length - YDA_CTRL_HAEDER_LENGTH);
    Byte receiveUdpAdressByte[104];
    memcpy(receiveUdpAdressByte, receivePayLoad + 8, 104);
    short int elementID = (receiveUdpAdressByte[0] << 8) + receiveUdpAdressByte[1];
    if (elementID == 5) {
        Byte receiveUdpAddressByte[100];
        memcpy(receiveUdpAddressByte, receiveUdpAdressByte + 4, 100);
        for (int i = 0; i < 5; i++) {
            Byte addressUnitByte[20];
            memcpy(addressUnitByte, receiveUdpAddressByte + (20 * i), 20);
            NSData * addressUnitData = [NSData dataWithBytes:addressUnitByte length:20];
            [self analysisAddress:addressUnitData];
        }
    }
}


/**
 解析udp请求的ip类型，ip地址，端口号

 @param addressData 地址数据包
 */
-(void)analysisAddress:(NSData *)addressData{
    Byte udpAddressInfoByte[20];
    [addressData getBytes:udpAddressInfoByte length:20];
    short int port = (udpAddressInfoByte[2] << 8) + udpAddressInfoByte[3];
    Byte udpAddressIPByte[16];
    memcpy(udpAddressIPByte, udpAddressInfoByte + 4, 16);
    NSData *ipData = [NSData dataWithBytes:udpAddressIPByte length:16];
    NSString * ipStr = [[NSString alloc]initWithData:ipData encoding:NSUTF8StringEncoding];
    DLog(@"%@:%d",ipStr,port);
}
















@end
