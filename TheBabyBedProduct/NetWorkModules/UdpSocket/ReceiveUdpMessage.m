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

extern short int TransID;
NSString * const    Video_Address     =  @"Video_Address";

@implementation ReceiveUdpMessage

+(instancetype)initReceiveData:(NSData *)data complecation:(ReceiveUdpMessageResult)result{
    ReceiveUdpMessage * message = [[ReceiveUdpMessage alloc]init];
    message.responseResult = result;
    [message receiveUdpMessage:data];
    return message;
}

//加密报文进行先解密
-(void)rsaDecryptUdpMessage:(NSData *)MessageData{
    
    
}

//未加密报文解析或者解密过的报文解析
-(void)receiveUdpMessage:(NSData *)data{
    
    Byte receiveByte[data.length];
    [data getBytes:receiveByte length:data.length];
    unsigned char crypto = (receiveByte[1] & 0xf0) >> 4;
    TransID = (receiveByte[4] << 8) + receiveByte[5];
    //取出控制报文
    Byte ctrlHeaderByte[data.length - YDA_HAEDER_LENGTH];
    memcpy(ctrlHeaderByte, receiveByte + YDA_HAEDER_LENGTH, data.length - YDA_HAEDER_LENGTH);
    if (crypto == 1) {
        NSData * encryptData = [[NSData alloc]initWithBytes:ctrlHeaderByte length:data.length - YDA_HAEDER_LENGTH];
        NSData * resultData = [RSA decryptData:encryptData privateKey:RSA_PRIVATE_KEY];
        [encryptData getBytes:ctrlHeaderByte length:resultData.length];
    }
    unsigned char msgType = ctrlHeaderByte[0];
    NSData * ctrlData = [NSData dataWithBytes:ctrlHeaderByte length:data.length - YDA_HAEDER_LENGTH];
    @try{
        if (msgType == 0x02) {
            //寻址相应报文
            DLog(@"寻址相应报文类型 ---- %c",msgType);
            [self analysisAddressYDACtrlHeader:ctrlData complication:self.responseResult];
        }else if(msgType == 0x04){
            //发现相应报文
            DLog(@"发现相应报文类型 ---- %c",msgType);
            [self analysisDiscoverYDACtrlHeader:ctrlData complication:self.responseResult];
        }else if(msgType == 0x06){
            //登录相应报文
            DLog(@"登陆相应报文类型 ---- %c",msgType);
            [self analysisLoginYDACtrlHeader:ctrlData complication:self.responseResult];
        }else if(msgType == 0x08){
            //心跳相应报文
            DLog(@"心跳相应报文类型 ---- %c",msgType);
            self.responseResult(HeartMessageType,0,nil);
        }else if(msgType == 0x0b){
            //事件相应报文
            DLog(@"事件相应报文类型 ---- %c",msgType);
             [self analysisEventYDACtrlHeader:ctrlData complication:self.responseResult];
        }else if(msgType == 0x0e){
            //设备管理相应报文
            DLog(@"设备管理相应报文类型 ---- %c",msgType);
            [self analysisEventYDACtrlHeader:ctrlData complication:self.responseResult];
        }else if(msgType == 0x0a){
            //CFG相应报文
            DLog(@"设备管理相应报文类型 ---- %c",msgType);
            [self analysisCFGYDACtrlHeader:ctrlData complication:self.responseResult];
        }
    }@catch (NSException * exception){
        DLog(@"解析报文出现异常%@",exception);
    }@finally{
        
    }
}

#pragma mark - 寻址相应报文解析
/**
 解析寻址响应的udp报文

 */
-(void)analysisAddressYDACtrlHeader:(NSData *)ctrlHeaderData complication:(ReceiveUdpMessageResult)messageResult{
    
    NSMutableArray * adressArr = [NSMutableArray array];
    unsigned int errCode = 0;
    Byte receiveCtrlByte[ctrlHeaderData.length];
    Byte receivePayLoad[ctrlHeaderData.length - YDA_CTRL_HAEDER_LENGTH];
    [ctrlHeaderData getBytes:receiveCtrlByte length:ctrlHeaderData.length];
    memcpy(receivePayLoad, receiveCtrlByte + YDA_CTRL_HAEDER_LENGTH, ctrlHeaderData.length - YDA_CTRL_HAEDER_LENGTH);
    
    Byte receiveUdpAddressErrByte[4];
    memcpy(receiveUdpAddressErrByte, receivePayLoad + 4, 4);
    short int elementErrID = (receivePayLoad[0] << 8) + receivePayLoad[1];
    if (elementErrID == 0) {
        errCode = receiveUdpAddressErrByte[0] + (receiveUdpAddressErrByte[1] << 8) + (receiveUdpAddressErrByte[2] << 16) + (receiveUdpAddressErrByte[3] << 24);
    }
    
    Byte receiveUdpAdressByte[104];
    memcpy(receiveUdpAdressByte, receivePayLoad + 8, 104);
    short int elementID = (receiveUdpAdressByte[0] << 8) + receiveUdpAdressByte[1];
    if (elementID == 4) {
        Byte receiveUdpAddressByte[100];
        memcpy(receiveUdpAddressByte, receiveUdpAdressByte + 4, 100);
        for (int i = 0; i < 5; i++) {
            Byte addressUnitByte[20];
            memcpy(addressUnitByte, receiveUdpAddressByte + (20 * i), 20);
            NSData * addressUnitData = [NSData dataWithBytes:addressUnitByte length:20];
            NSDictionary * dic = [self analysisAddress:addressUnitData];
            [adressArr addObject:dic];
        }
    }
    messageResult(AddressingMessageType,errCode,adressArr);
}


/**
 解析udp请求的ip类型，ip地址，端口号

 @param addressData 地址数据包
 */
-(NSDictionary *)analysisAddress:(NSData *)addressData{
    NSMutableDictionary * resultDic = [NSMutableDictionary dictionary];
    Byte udpAddressInfoByte[20];
    [addressData getBytes:udpAddressInfoByte length:20];
    short int ipType = (udpAddressInfoByte[0] << 8) + udpAddressInfoByte[1];
    short int port = (udpAddressInfoByte[2] << 8) + udpAddressInfoByte[3];
    [resultDic setObject:@(port) forKey:@"port"];
    Byte udpAddressIPByte[16];
    memcpy(udpAddressIPByte, udpAddressInfoByte + 4, 16);
    //ipType 为 1是 ipv6 ， 为2 是ipv4
    if (ipType == 1) {
        NSData *ipData = [NSData dataWithBytes:udpAddressIPByte length:16];
        NSString * ipv6Str = [[NSString alloc]initWithData:ipData encoding:NSUTF8StringEncoding];
        [resultDic setObject:ipv6Str forKey:@"ipAddress"];
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
        [resultDic setObject:ipv4Str forKey:@"ipAddress"];
    }
    return resultDic;
}

#pragma mark - 发现相应报文解析
-(void)analysisDiscoverYDACtrlHeader:(NSData *)ctrlHeaderData complication:(ReceiveUdpMessageResult)messageResult{
    
    unsigned int errCode;
    Byte receiveCtrlByte[ctrlHeaderData.length];
    Byte receivePayLoad[ctrlHeaderData.length - YDA_CTRL_HAEDER_LENGTH];
    [ctrlHeaderData getBytes:receiveCtrlByte length:ctrlHeaderData.length];
    memcpy(receivePayLoad, receiveCtrlByte + YDA_CTRL_HAEDER_LENGTH, ctrlHeaderData.length - YDA_CTRL_HAEDER_LENGTH);
    Byte receiveUdpDiscoverByte[4];
    memcpy(receiveUdpDiscoverByte, receivePayLoad + 4, 4);
    short int elementID = (receivePayLoad[0] << 8) + receivePayLoad[1];
    if (elementID == 0) {
        errCode = receiveUdpDiscoverByte[0] + (receiveUdpDiscoverByte[1] << 8) + (receiveUdpDiscoverByte[2] << 16) + (receiveUdpDiscoverByte[3] << 24);
    }
    messageResult(DiscoverMessageType,errCode,nil);
}

#pragma mark - 登录相应报文解析
-(void)analysisLoginYDACtrlHeader:(NSData *)ctrlHeaderData complication:(ReceiveUdpMessageResult)messageResult{
    
    unsigned int errCode = 0;
    Byte receiveCtrlByte[ctrlHeaderData.length];
    Byte receivePayLoad[ctrlHeaderData.length - YDA_CTRL_HAEDER_LENGTH];
    [ctrlHeaderData getBytes:receiveCtrlByte length:ctrlHeaderData.length];
    memcpy(receivePayLoad, receiveCtrlByte + YDA_CTRL_HAEDER_LENGTH, ctrlHeaderData.length - YDA_CTRL_HAEDER_LENGTH);
    Byte receiveUdpLoginByte[4];
    memcpy(receiveUdpLoginByte, receivePayLoad + 4, 4);
    short int elementID = (receivePayLoad[0] << 8) + receivePayLoad[1];
    if (elementID == 0) {
        errCode = receiveUdpLoginByte[0] + (receiveUdpLoginByte[1] << 8) + (receiveUdpLoginByte[2] << 16) + (receiveUdpLoginByte[3] << 24);
    }
    messageResult(LoginMessageType,errCode,nil);
}
#pragma mark - 事件报文相应报文解析
-(void)analysisEventYDACtrlHeader:(NSData *)ctrlHeaderData complication:(ReceiveUdpMessageResult)messageResult{
    
    unsigned int errCode;
    NSDictionary * eventDic;
    Byte receiveCtrlByte[ctrlHeaderData.length];
    Byte receivePayLoad[ctrlHeaderData.length - YDA_CTRL_HAEDER_LENGTH];
    [ctrlHeaderData getBytes:receiveCtrlByte length:ctrlHeaderData.length];
    memcpy(receivePayLoad, receiveCtrlByte + YDA_CTRL_HAEDER_LENGTH, ctrlHeaderData.length - YDA_CTRL_HAEDER_LENGTH);
    Byte receiveUdpEventByte[12];
    memcpy(receiveUdpEventByte, receivePayLoad + 4, 12);
    short int elementID = (receivePayLoad[0] << 8) + receivePayLoad[1];
    if (elementID == 0x0D) {
        errCode = 0;
       eventDic = [self analysisEventMessageData:[[NSData alloc]initWithBytes:receiveUdpEventByte length:12]];
    }
    messageResult(NotificationType,errCode,eventDic);
}
    
-(NSDictionary *)analysisEventMessageData:(NSData *)data{
    
    Byte receiveUdpEventByte[data.length];
    [data getBytes:receiveUdpEventByte length:data.length];
    
    short int cryState = 0;
    short int kickState = 0;
    short int envtemp_Value = 0;
    short int  humidity_Value = 0;
    short int bodytemp_Value = 0;
    short int urine_Value = 0;
    
    cryState = (receiveUdpEventByte[0] << 8 ) +  receiveUdpEventByte[1];
    kickState = (receiveUdpEventByte[2] << 8 ) +  receiveUdpEventByte[3];
    envtemp_Value = (receiveUdpEventByte[4] << 8)  + receiveUdpEventByte[5] ;
    humidity_Value = (receiveUdpEventByte[6] << 8)+ receiveUdpEventByte[7] ;
    bodytemp_Value = (receiveUdpEventByte[8] << 8) + receiveUdpEventByte[9];
    urine_Value = (receiveUdpEventByte[10] << 8 ) +  receiveUdpEventByte[11];
    
    NSDictionary * eventDic = @{Baby_Cry_State:@(cryState),Baby_Kick_State:@(kickState),Env_Temp_Value:@(envtemp_Value),Env_Humidity_Value:@(humidity_Value),Body_Temp_Value:@(bodytemp_Value),Baby_Urine_Value:@(urine_Value)};
    return eventDic;
}

#pragma mark - CFG相应报文解析
-(void)analysisCFGYDACtrlHeader:(NSData *)ctrlHeaderData complication:(ReceiveUdpMessageResult)messageResult{
    
    unsigned int errCode;
    NSDictionary * CFGDic;
    Byte receiveCtrlByte[ctrlHeaderData.length];
    Byte receivePayLoad[ctrlHeaderData.length - YDA_CTRL_HAEDER_LENGTH];
    [ctrlHeaderData getBytes:receiveCtrlByte length:ctrlHeaderData.length];
    memcpy(receivePayLoad, receiveCtrlByte + YDA_CTRL_HAEDER_LENGTH, ctrlHeaderData.length - YDA_CTRL_HAEDER_LENGTH);
    Byte receiveUdpCFGErrByte[8];
    memcpy(receivePayLoad, receivePayLoad, 8);
    short int elementID = (receivePayLoad[0] << 8) + receivePayLoad[1];
    if (elementID == 0) {
        errCode = receiveUdpCFGErrByte[4] + (receiveUdpCFGErrByte[5] << 8) + (receiveUdpCFGErrByte[6] << 16) + (receiveUdpCFGErrByte[7] << 24);
    }
    
    Byte receiveUdpCFGAddressheaderByte[4];
    memcpy(receiveUdpCFGAddressheaderByte, receivePayLoad + 8, 4);
    short int elementTwoID = (receiveUdpCFGAddressheaderByte[0] << 8) + receiveUdpCFGAddressheaderByte[1];
    if (elementTwoID == 0x0c) {
        short int addressLength = (receiveUdpCFGAddressheaderByte[2] << 8) + receiveUdpCFGAddressheaderByte[3];
        Byte receiveUdpCFGAddressByte[addressLength];
        memcpy(receiveUdpCFGAddressByte, receivePayLoad + 12, addressLength);
        NSData * addressData = [[NSData alloc]initWithBytes:receiveUdpCFGAddressheaderByte length:addressLength];
        CFGDic = [self analysisCFGVideoAdress:addressData];
    }

    messageResult(CFGMessageType,errCode,CFGDic);
    
}
-(NSDictionary * )analysisCFGVideoAdress:(NSData *)addressData{
    
    Byte addressByte [addressData.length];
    short int option = 0;
    short int value = 0;
    NSData * resultData = [[NSData alloc]initWithBytes:(addressByte + 4) length:addressData.length - 4];
    NSString * addressStr = [[NSString alloc]initWithData:resultData encoding:NSUTF8StringEncoding];
    NSDictionary * addressDic = @{Video_Address:addressStr};
    return addressDic;
}








@end
