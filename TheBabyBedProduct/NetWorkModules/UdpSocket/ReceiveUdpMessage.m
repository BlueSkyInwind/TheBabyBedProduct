//
//  ReceiveUdpMessage.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/19.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "ReceiveUdpMessage.h"
#import "SocketMacros.h"
#import "RSA.h"

@implementation ReceiveUdpMessage

+(instancetype)initReceiveData:(NSData *)data complecation:(ReceiveUdpMessageResult)result{
    ReceiveUdpMessage * message = [[ReceiveUdpMessage alloc]init];
    message.responseResult = result;
    [message receiveUdpMessage:data];
    return message;
}

//加密报文进行先解密
-(void)rsaDecryptUdpMessage:(NSData *)MessageData{
    NSData * decryptData = [RSA decryptData:MessageData privateKey:RSA_PRIVATE_KEY];
    [self receiveUdpMessage:decryptData];
}

//未加密报文解析或者解密过的报文解析
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
           NSDictionary * dic = [self analysisAddress:addressUnitData];
           self.responseResult(AddressingMessageType, dic);
        }
    }
}

/**
 解析udp请求的ip类型，ip地址，端口号

 @param addressData 地址数据包
 */
-(NSDictionary *)analysisAddress:(NSData *)addressData{
    NSDictionary * resultDic = [NSDictionary dictionary];
    Byte udpAddressInfoByte[20];
    [addressData getBytes:udpAddressInfoByte length:20];
    short int ipType = (udpAddressInfoByte[0] << 8) + udpAddressInfoByte[1];
    short int port = (udpAddressInfoByte[2] << 8) + udpAddressInfoByte[3];
    [resultDic setValue:@(port) forKey:@"port"];
    Byte udpAddressIPByte[16];
    memcpy(udpAddressIPByte, udpAddressInfoByte + 4, 16);
    //ipType 为 1是 ipv6 ， 为2 是ipv4
    if (ipType == 1) {
        NSData *ipData = [NSData dataWithBytes:udpAddressIPByte length:16];
        NSString * ipv6Str = [[NSString alloc]initWithData:ipData encoding:NSUTF8StringEncoding];
        [resultDic setValue:ipv6Str forKey:@"ipAddress"];
        DLog(@"%@:%d",ipv6Str,port);
    }else{
        Byte udpAddressIPv4Byte[4];
        memcpy(udpAddressIPv4Byte, udpAddressIPByte, 4);
        NSData *ipData = [NSData dataWithBytes:udpAddressIPv4Byte length:4];
        NSString * ipv4Str;
        for (int i = 0;i < 4; i++){
            uint64_t length;
            [ipData getBytes:&length range:NSMakeRange(i, 1)];
            NSString * adrrStr = [NSString stringWithFormat:@"%llu.",length];
            if (i == 0) {
                ipv4Str = adrrStr;
            }else{
                ipv4Str =  [ipv4Str stringByAppendingString:adrrStr];
            }
        }
        ipv4Str = [ipv4Str substringToIndex:ipv4Str.length - 1];
        DLog(@"%@:%d",ipv4Str,port);
        [resultDic setValue:ipv4Str forKey:@"ipAddress"];
    }
    return resultDic;
}
















@end
