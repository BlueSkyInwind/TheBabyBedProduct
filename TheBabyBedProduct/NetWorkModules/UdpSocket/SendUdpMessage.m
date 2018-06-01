//
//  SendUdpMessage.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/19.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//
//生成udp报文类，按照需求，以4个字节为一个单位进行生成


#import "SendUdpMessage.h"
#import "SocketMacros.h"

extern short int sendCount;
extern short int TransID;

NSString * const    Baby_Cry_State     =  @"Baby_Cry_State";
NSString * const    Baby_Kick_State     =  @"Baby_Kick_State";
NSString * const    Env_Temp_Value     =  @"Env_Temp_Value";
NSString * const    Env_Humidity_Value     =  @"Env_Humidity_Value";
NSString * const    Body_Temp_Value     =  @"Body_Temp_Value";
NSString * const    Baby_Urine_Value     =  @"Baby_Urine_Value";


NSString * const    aucYdaDevSn     =  @"aucYdaDevSn";
NSString * const    aucYdaDevName     =  @"aucYdaDevName";
NSString * const    aucYdaSwVer     =  @"aucYdaSwVer";
NSString * const    aucYdaHwVer     =  @"aucYdaHwVer";
NSString * const    aucYdaHwAddr     =  @"aucYdaHwAddr";



@implementation SendUdpMessage

//寻址
-(NSData *)generateAddressingMessage{
    
    NSMutableData * dataOne = [[self generatePreambleVersion:0 preambleCrypto:0 HLEN:0x04 YdaHeaderChecksum:0] mutableCopy];
    
    NSData * dataTwo = [self generateTransID:TransID ctrlAndExt:0];
    [dataOne appendData:dataTwo];
    
    NSData * dataThree = [self generateFragmentID:0 FragOffset:0];
    [dataOne appendData:dataThree];
    
    NSData * dataFour = [self generateDataLen:0 Reserved:0];
    [dataOne appendData:dataFour];
    
    NSData * dataFive = [self generateMsgType:0x01 SeqNum:sendCount MsgLen:8];
    [dataOne appendData:dataFive];
    
    NSData * dataSix = [self generateYdaCtrlHeaderChecksum:0 Random:7];
    [dataOne appendData:dataSix];
    
    NSData * bodyData = [self generateUdpBody];
    [dataOne appendData:bodyData];
    
    
    dataOne = [[self setYdaHeaderDatalen:dataOne.length  data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderMsglen:bodyData.length + 8 data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderChecksumData:dataOne] mutableCopy];
    dataOne = [[self setYdaHeaderChecksumData:dataOne] mutableCopy];
    
    return dataOne;
}

-(NSData *)generateUdpBody{
    
    NSData * payloadData = [self generateYDA_VSP_DEVICE_INFO:@{aucYdaDevSn:@"SN:LYDA20180210",aucYdaDevName:@"YDA398",aucYdaSwVer:@"V200R003C60B100",aucYdaHwVer:@"IMX6UL_PCBA0001",aucYdaHwAddr:@"2082c064c602"}];
    
    NSMutableData * bodyData = [[self generateUdpBodyUnit:134 elementID:1 dataContent:payloadData] mutableCopy];
    [bodyData appendData: [self generateUdpBodyUnit:36 elementID:2 dataContent:nil]];
    [bodyData appendData: [self generateUdpBodyUnit:1 elementID:3 dataContent:nil]];
    NSData *rsaData = [RSA_PUBLIC_KEY dataUsingEncoding: NSUTF8StringEncoding];
    [bodyData appendData: [self generateUdpBodyUnit:RSA_PUBLIC_KEY.length elementID:4 dataContent:rsaData]];
    return bodyData;
    
}
//发现
-(NSData *)generateDiscoverRequestMessage{
    
    NSMutableData * dataOne = [[self generatePreambleVersion:0 preambleCrypto:1 HLEN:0x04 YdaHeaderChecksum:0] mutableCopy];
    
    NSData * dataTwo = [self generateTransID:TransID ctrlAndExt:0];
    [dataOne appendData:dataTwo];
    
    NSData * dataThree = [self generateFragmentID:0 FragOffset:0];
    [dataOne appendData:dataThree];
    
    NSData * dataFour = [self generateDataLen:0 Reserved:0];
    [dataOne appendData:dataFour];
    
    NSData * dataFive = [self generateMsgType:0x03 SeqNum:sendCount MsgLen:8];
    [dataOne appendData:dataFive];
    
    NSData * dataSix = [self generateYdaCtrlHeaderChecksum:0 Random:12];
    [dataOne appendData:dataSix];
    
    NSData * bodyData = [self generateDiscoverRequestUdpBody];
    [dataOne appendData:bodyData];
    
    dataOne = [[self setYdaHeaderDatalen:dataOne.length  data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderMsglen:bodyData.length + 8 data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderChecksumData:dataOne] mutableCopy];
    dataOne = [[self setYdaHeaderChecksumData:dataOne] mutableCopy];
    
    return dataOne;
    
}
-(NSData *)generateDiscoverRequestUdpBody{
    NSMutableData * bodyData = [[self generateUdpBodyUnit:134 elementID:7 dataContent:nil] mutableCopy];
    NSData *rsaData = [RSA_PUBLIC_KEY dataUsingEncoding: NSUTF8StringEncoding];
    [bodyData appendData: [self generateUdpBodyUnit:185 elementID:8 dataContent:rsaData]];
    return bodyData;
}


//登录
-(NSData *)generateLoginRequestMessage{
    
    NSMutableData * dataOne = [[self generatePreambleVersion:0 preambleCrypto:1 HLEN:0x04 YdaHeaderChecksum:0] mutableCopy];
    
    NSData * dataTwo = [self generateTransID:TransID ctrlAndExt:0];
    [dataOne appendData:dataTwo];
    
    NSData * dataThree = [self generateFragmentID:0 FragOffset:0];
    [dataOne appendData:dataThree];
    
    NSData * dataFour = [self generateDataLen:0 Reserved:0];
    [dataOne appendData:dataFour];
    
    NSData * dataFive = [self generateMsgType:0x05 SeqNum:sendCount MsgLen:8];
    [dataOne appendData:dataFive];
    
    NSData * dataSix = [self generateYdaCtrlHeaderChecksum:0 Random:12];
    [dataOne appendData:dataSix];
    
    NSData * bodyData = [self generateLoginRequestUdpBody];
    [dataOne appendData:bodyData];
    
    dataOne = [[self setYdaHeaderDatalen:dataOne.length  data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderMsglen:bodyData.length + 8 data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderChecksumData:dataOne] mutableCopy];
    dataOne = [[self setYdaHeaderChecksumData:dataOne] mutableCopy];
    
    return dataOne;
}

-(NSData *)generateLoginRequestUdpBody{
    
    NSData * payloadData = [self generateYDA_VSP_DEVICE_INFO:@{aucYdaDevSn:@"SN:LYDA20180210",aucYdaDevName:@"YDA398",aucYdaSwVer:@"V200R003C60B100",aucYdaHwVer:@"IMX6UL_PCBA0001",aucYdaHwAddr:@"2082c064c602"}];
    NSMutableData * bodyData = [[self generateUdpBodyUnit:134 elementID:9 dataContent:payloadData] mutableCopy];
    return bodyData;
    
}

//心跳
-(NSData *)generateHeartbeatRequestMessage{
    
    NSMutableData * dataOne = [[self generatePreambleVersion:0 preambleCrypto:0 HLEN:0x04 YdaHeaderChecksum:0] mutableCopy];
    
    NSData * dataTwo = [self generateTransID:TransID ctrlAndExt:0];
    [dataOne appendData:dataTwo];
    
    NSData * dataThree = [self generateFragmentID:0 FragOffset:0];
    [dataOne appendData:dataThree];
    
    NSData * dataFour = [self generateDataLen:0 Reserved:0];
    [dataOne appendData:dataFour];
    
    NSData * dataFive = [self generateMsgType:0x07 SeqNum:sendCount MsgLen:0];
    [dataOne appendData:dataFive];
    
    NSData * dataSix = [self generateYdaCtrlHeaderChecksum:0 Random:15];
    [dataOne appendData:dataSix];
    
    dataOne = [[self setYdaHeaderDatalen:dataOne.length  data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderMsglen:8 data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderChecksumData:dataOne] mutableCopy];
    dataOne = [[self setYdaHeaderChecksumData:dataOne] mutableCopy];
    
    return dataOne;
}

/**
 事件通知请求

 @param valueDic 值的字典 包含 key如下：
                       Baby_Cry_State    1: Cry    0: Normal       //哭闹状态  2字节
                       Baby_Kick_State   1: Kick   0: Normal           //踢被状态  2字节
                       Env_Temp_Value    温度值 有符号  4字节
                       Env_Humidity_Value   湿度值，无符号4字节
                       Body_Temp_Value    //体温值 有符号4字节
                       Baby_Urine_Value    //尿湿值 无符号2字节
 @return 事情通知请求
 */
-(NSData *)generateEventNotificationRequestMessage:(NSDictionary *)valueDic{
    
    NSMutableData * dataOne = [[self generatePreambleVersion:0 preambleCrypto:0 HLEN:0x04 YdaHeaderChecksum:0] mutableCopy];
    
    NSData * dataTwo = [self generateTransID:TransID ctrlAndExt:0];
    [dataOne appendData:dataTwo];
    
    NSData * dataThree = [self generateFragmentID:0 FragOffset:0];
    [dataOne appendData:dataThree];
    
    NSData * dataFour = [self generateDataLen:0 Reserved:0];
    [dataOne appendData:dataFour];
    
    NSData * dataFive = [self generateMsgType:0x0b SeqNum:sendCount MsgLen:0];
    [dataOne appendData:dataFive];
    
    NSData * dataSix = [self generateYdaCtrlHeaderChecksum:0 Random:16];
    [dataOne appendData:dataSix];
    
    NSData * bodyData = [self generateEventNotificationRequestRequestUdpBody:valueDic];
    [dataOne appendData:bodyData];
    
    dataOne = [[self setYdaHeaderDatalen:dataOne.length  data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderMsglen:bodyData.length + 8 data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderChecksumData:dataOne] mutableCopy];
    dataOne = [[self setYdaHeaderChecksumData:dataOne] mutableCopy];
    
    return dataOne;
}
-(NSData *)generateEventNotificationRequestRequestUdpBody:(NSDictionary *)valueDic{
    
    NSData * contentData = [self generateEventNotificationData:valueDic datalength:12];
    NSMutableData * bodyData = [[self generateUdpBodyUnit:18 elementID:0x0D dataContent:contentData] mutableCopy];
    return bodyData;
    
}

-(NSData *)generateEventNotificationData:(NSDictionary *)dic datalength:(short int)datalength{
    
    Byte bodyByte[datalength];
    short int cryState = 0;
    short int kickState = 0;
    short int envtemp_Value = 0;
    short int  humidity_Value = 0;
    short int bodytemp_Value = 0;
    short int urine_Value = 0;

    if ([dic.allKeys containsObject:Baby_Cry_State]) {
        NSNumber * num = (NSNumber *)dic[Baby_Cry_State];
        cryState = num.shortValue;
    }
    if ([dic.allKeys containsObject:Baby_Kick_State]) {
        NSNumber * num = (NSNumber *)dic[Baby_Kick_State];
        kickState = num.shortValue;
    }
    if ([dic.allKeys containsObject:Env_Temp_Value]) {
        NSNumber * num = (NSNumber *)dic[Env_Temp_Value];
        envtemp_Value = num.shortValue;
    }
    if ([dic.allKeys containsObject:Env_Humidity_Value]) {
        NSNumber * num = (NSNumber *)dic[Env_Humidity_Value];
        humidity_Value = num.shortValue;
    }
    if ([dic.allKeys containsObject:Body_Temp_Value]) {
        NSNumber * num = (NSNumber *)dic[Body_Temp_Value];
        bodytemp_Value = num.shortValue;
    }
    if ([dic.allKeys containsObject:Baby_Urine_Value]) {
        NSNumber * num = (NSNumber *)dic[Baby_Urine_Value];
        urine_Value = num.shortValue;
    }
    //哭闹
    bodyByte[0] = ((cryState >> 8) & 0xff);
    bodyByte[1] = (cryState & 0xff);
    //踢被
    bodyByte[2] = ((kickState >> 8) & 0xff);
    bodyByte[3] = (kickState & 0xff);
    //环境温度
    bodyByte[4] = ((envtemp_Value >> 8) & 0xff);
    bodyByte[5] = (envtemp_Value & 0xff);
    //环境湿度
    bodyByte[6] = ((humidity_Value >> 8) & 0xff);
    bodyByte[7] = (humidity_Value & 0xff);

    //体温值
    bodyByte[8] = ((bodytemp_Value >> 8) & 0xff);
    bodyByte[9] = (bodytemp_Value & 0xff);

    //尿湿值
    bodyByte[10] = ((urine_Value >> 8) & 0xff);
    bodyByte[11] = (urine_Value & 0xff);
    NSData * data = [[NSData alloc]initWithBytes:bodyByte length:18];
    return data;
}

//设备管理报文
-(NSData *)generateEquipmentmanagementRequestMessage{
    
    NSMutableData * dataOne = [[self generatePreambleVersion:0 preambleCrypto:0 HLEN:0x04 YdaHeaderChecksum:0] mutableCopy];
    
    NSData * dataTwo = [self generateTransID:TransID ctrlAndExt:0];
    [dataOne appendData:dataTwo];
    
    NSData * dataThree = [self generateFragmentID:0 FragOffset:0];
    [dataOne appendData:dataThree];
    
    NSData * dataFour = [self generateDataLen:0 Reserved:0];
    [dataOne appendData:dataFour];
    
    NSData * dataFive = [self generateMsgType:0x0d SeqNum:sendCount MsgLen:0];
    [dataOne appendData:dataFive];
    
    NSData * dataSix = [self generateYdaCtrlHeaderChecksum:0 Random:19];
    [dataOne appendData:dataSix];
    
    dataOne = [[self setYdaHeaderDatalen:dataOne.length  data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderMsglen:8 data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderChecksumData:dataOne] mutableCopy];
    dataOne = [[self setYdaHeaderChecksumData:dataOne] mutableCopy];
    
    return dataOne;
}

//CFG设置报文
-(NSData *)generateCFGSettingRequestMessage{
    
    NSMutableData * dataOne = [[self generatePreambleVersion:0 preambleCrypto:0 HLEN:0x04 YdaHeaderChecksum:0] mutableCopy];
    
    NSData * dataTwo = [self generateTransID:TransID ctrlAndExt:0];
    [dataOne appendData:dataTwo];
    
    NSData * dataThree = [self generateFragmentID:0 FragOffset:0];
    [dataOne appendData:dataThree];
    
    NSData * dataFour = [self generateDataLen:0 Reserved:0];
    [dataOne appendData:dataFour];
    
    NSData * dataFive = [self generateMsgType:0x09 SeqNum:sendCount MsgLen:0];
    [dataOne appendData:dataFive];
    
    NSData * dataSix = [self generateYdaCtrlHeaderChecksum:0 Random:19];
    [dataOne appendData:dataSix];
    
    NSData * bodyData = [self generateCFGRequestUdpBody];
    [dataOne appendData:bodyData];
    
    dataOne = [[self setYdaHeaderDatalen:dataOne.length  data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderMsglen:bodyData.length + 8 data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderChecksumData:dataOne] mutableCopy];
    dataOne = [[self setYdaHeaderChecksumData:dataOne] mutableCopy];
    
    return dataOne;
}

-(NSData *)generateCFGRequestUdpBody{
    
    NSMutableData * bodyData = [[self generateUdpBodyUnit:6 elementID:0x0B dataContent:nil] mutableCopy];
    return bodyData;

}

#pragma mark - YDA HEAdER
/**
 生成 版本 payload加密部分
 
 @param version 版本
 @param crypto payload加密部分
 @param HLEN 单位
 @param checksum YDA header 校验和  先默认填充0
 @return 拼装Data
 */
-(NSData *)generatePreambleVersion:(unsigned char)version preambleCrypto:(unsigned char)crypto HLEN:(unsigned char)HLEN YdaHeaderChecksum:(short int)checksum{
    
    Byte byte[4];
    byte[0] = (((crypto << 4)&0xf0) | version);   //一个字节的高4位存储payload加密版本 ，低4位存储版本
    byte[1] = HLEN;
    byte[2] = ((checksum >> 8) & 0xff);
    byte[3] = (checksum & 0xff);
    NSData * data = [[NSData alloc]initWithBytes:byte length:4];
//    NSData * resultData = [self setYdaHeaderChecksumData:data];
    return data;
}

-(NSData *)generateTransID:(short int)transID ctrlAndExt:(short int)ctrlAndExt{
    
    Byte byte[4];
    byte[0] = ((transID >> 8) & 0xff);
    byte[1] = (transID  & 0xff);
    byte[2] = ((ctrlAndExt >> 8) & 0xff);
    byte[3] = (ctrlAndExt & 0xff);
    NSData * data = [[NSData alloc]initWithBytes:byte length:4];
    return data;
}

-(NSData *)generateFragmentID:(short int)fragmentID FragOffset:(short int)fragOffset{
    
    Byte byte[4];
    byte[0] = ((fragmentID >> 8) & 0xff);
    byte[1] = (fragmentID  & 0xff);
    byte[2] = ((fragOffset >> 8) & 0xff);
    byte[3] = (fragOffset & 0xff);
    NSData * data = [[NSData alloc]initWithBytes:byte length:4];
    return data;
}

-(NSData *)generateDataLen:(short int)dataLen Reserved:(short int)reserved{
    
    Byte byte[4];
    byte[0] = ((dataLen >> 8) & 0xff);
    byte[1] = (dataLen  & 0xff);
    byte[2] = ((reserved >> 8) & 0xff);
    byte[3] = (reserved & 0xff);
    NSData * data = [[NSData alloc]initWithBytes:byte length:4];
    return data;
}
-(NSData *)setYdaHeaderDatalen:(short int)dataLength data:(NSData *)data{
    
    Byte headerByte[data.length];
    [data getBytes:headerByte length:data.length];
    headerByte[12] = ((dataLength >> 8) & 0xff);
    headerByte[13] = (dataLength  & 0xff);
    NSData * resultData = [[NSData alloc]initWithBytes:headerByte length:data.length];
    return resultData;
    
}

#pragma mark - YDA CTRL HEADER

-(NSData *)generateMsgType:(unsigned char)msgType SeqNum:(unsigned char)seqNum MsgLen:(short int)msgLen{
    
    Byte byte[4];
    byte[0] = msgType;
    byte[1] = seqNum;
    byte[2] = ((msgLen >> 8) & 0xff);
    byte[3] = (msgLen & 0xff);
    NSData * resultData = [[NSData alloc]initWithBytes:byte length:4];
    return resultData;
    
}

-(NSData *)setYdaCtrlHeaderMsglen:(short int)Msglen data:(NSData *)data{
    
    Byte headerByte[data.length];
    [data getBytes:headerByte length:data.length];
    headerByte[18] = ((Msglen >> 8) & 0xff);
    headerByte[19] = (Msglen  & 0xff);
    NSData * resultData = [[NSData alloc]initWithBytes:headerByte length:data.length];
    return resultData;
    
}

-(NSData *)generateYdaCtrlHeaderChecksum:(short int)checksum Random:(short int)random{
    
    Byte byte[4];
    byte[0] = ((checksum >> 8) & 0xff);
    byte[1] = (checksum  & 0xff);
    byte[2] = ((random >> 8) & 0xff);
    byte[3] = (random & 0xff);
    NSData * resultData = [[NSData alloc]initWithBytes:byte length:4];
    return resultData;
}


#pragma mrak - 校验和
-(NSData *)setYdaHeaderChecksumData:(NSData *)data{
    NSData * resultData = [self setYdaChecksumData:data firstByteNum:2 secondByteNum:3];
    return resultData;
}

-(NSData *)setYdaCtrlHeaderChecksumData:(NSData *)data{
    
    Byte headerByte[data.length];
    Byte ctrlHeaderByte[data.length - YDA_HAEDER_LENGTH];
    [data getBytes:headerByte length:data.length];
    memcpy(ctrlHeaderByte, headerByte + YDA_HAEDER_LENGTH, data.length - YDA_HAEDER_LENGTH);
    unsigned short checksumOne = checksumAndCRC(ctrlHeaderByte, (int)(data.length - YDA_HAEDER_LENGTH));
    headerByte[20] = ((checksumOne >> 8) & 0xff);
    headerByte[21] = (checksumOne  & 0xff);
    NSData * resultData = [[NSData alloc]initWithBytes:headerByte length:data.length];
    return resultData;
}

-(NSData *)setYdaChecksumData:(NSData *)data firstByteNum:(int)firstByteNum secondByteNum:(int)secondByteNum{
    
    Byte headerByte[data.length];
    [data getBytes:headerByte length:data.length];
    unsigned short checksumOne = checksumAndCRC(headerByte, (int)data.length);
    headerByte[firstByteNum] = ((checksumOne >> 8) & 0xff);
    headerByte[secondByteNum] = (checksumOne  & 0xff);
    NSData * resultData = [[NSData alloc]initWithBytes:headerByte length:data.length];
    return resultData;
    
}
#pragma mrak - 生成报文的payload
-(NSData *)generateUdpBodyUnit:(short int)length elementID:(short int)ID dataContent:(NSData *)dataContent {
    
    NSUInteger datalength = 2 + 2 + length;
    Byte bodyByte[datalength];
    short int elementID = ID;
    short int elementLength = datalength;
    bodyByte[0] = ((elementID >> 8) & 0xff);
    bodyByte[1] = (elementID  & 0xff);
    bodyByte[2] = ((elementLength >> 8) & 0xff);
    bodyByte[3] = (elementLength  & 0xff);
    if(dataContent != nil) {
        Byte * rsaDatabyte = (Byte *)[dataContent bytes];
        memcpy(bodyByte + 4, rsaDatabyte, length);
    }
    NSMutableData * bodyData = [[NSMutableData alloc]initWithBytes:bodyByte length:datalength];
    return bodyData;
}

-(NSData *)generateYDA_VSP_DEVICE_INFO:(NSDictionary *)infoDic{
    
    Byte devSnByte[32];
    Byte devNameByte[32];
    Byte devSwVerByte[32];
    Byte devHwVerByte[32];
    Byte devHwAddrByte[6];

    if ([infoDic.allKeys containsObject:aucYdaDevSn]) {
        NSString * devSnStr = infoDic[aucYdaDevSn];
        NSData *data =[devSnStr dataUsingEncoding:NSUTF8StringEncoding];
        Byte * byte = (Byte*)[data bytes];
        memcpy(devSnByte, byte, data.length);
    }
    
    if ([infoDic.allKeys containsObject:aucYdaDevName]) {
        NSString * devSnStr = infoDic[aucYdaDevName];
        NSData *data =[devSnStr dataUsingEncoding:NSUTF8StringEncoding];
        Byte * byte = (Byte*)[data bytes];
        memcpy(devNameByte, byte, data.length);
    }
    
    if ([infoDic.allKeys containsObject:aucYdaHwVer]) {
        NSString * devSnStr = infoDic[aucYdaHwVer];
        NSData *data =[devSnStr dataUsingEncoding:NSUTF8StringEncoding];
        Byte * byte = (Byte*)[data bytes];
        memcpy(devHwVerByte, byte, data.length);
    }
    
    if ([infoDic.allKeys containsObject:aucYdaSwVer]) {
        NSString * devSnStr = infoDic[aucYdaSwVer];
        NSData *data =[devSnStr dataUsingEncoding:NSUTF8StringEncoding];
        Byte * byte = (Byte*)[data bytes];
        memcpy(devSwVerByte, byte, data.length);
    }
    
    if ([infoDic.allKeys containsObject:aucYdaHwAddr]) {
        NSString * devSnStr = infoDic[aucYdaHwAddr];
        NSData *data =[devSnStr dataUsingEncoding:NSUTF8StringEncoding];
        Byte * byte = (Byte*)[data bytes];
//        memcpy(devHwAddrByte, byte, data.length);
    }
    NSMutableData * dataOne = [[NSMutableData alloc]initWithBytes:devSnByte length:32];
    [dataOne appendData:[[NSData alloc]initWithBytes:devNameByte length:32]];
    [dataOne appendData:[[NSData alloc]initWithBytes:devSwVerByte length:32]];
    [dataOne appendData:[[NSData alloc]initWithBytes:devHwVerByte length:32]];
    [dataOne appendData:[[NSData alloc]initWithBytes:devHwAddrByte length:6]];
    return dataOne;
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


 -(NSData *)testGenerateAddressingMessage{
 
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
 
  short int num = (0x01 << 8) | 0x89;
 
     unsigned short checksumOne = checksumAndCRC(headerByte, (int)dataOne.length);
     headerByte[2] = ((checksumOne >> 8) & 0xff);
     headerByte[3] = (checksumOne  & 0xff);
 
     unsigned short checksumTwo = checksumAndCRC(ctrlHeaderByte, (int)(dataOne.length - 16));
     headerByte[20] = ((checksumTwo >> 8) & 0xff);
     headerByte[21] = (checksumTwo  & 0xff);
 
 NSData * resultData = [NSData dataWithBytes:headerByte length:dataOne.length];
     return resultData;
 
 }

@end
