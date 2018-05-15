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

@implementation SendUdpMessage

//寻址
-(NSData *)generateAddressingMessage{
    
    NSMutableData * dataOne = [[self generatePreambleVersion:0 preambleCrypto:0 HLEN:0x04 YdaHeaderChecksum:0] mutableCopy];
    
    NSData * dataTwo = [self generateTransID:0 ctrlAndExt:0];
    [dataOne appendData:dataTwo];
    
    NSData * dataThree = [self generateFragmentID:0 FragOffset:0];
    [dataOne appendData:dataThree];
    
    NSData * dataFour = [self generateDataLen:0 Reserved:0];
    [dataOne appendData:dataFour];
    
    NSData * dataFive = [self generateMsgType:0x01 SeqNum:0x00 MsgLen:8];
    [dataOne appendData:dataFive];
    
    NSData * dataSix = [self generateYdaCtrlHeaderChecksum:0 Random:7];
    [dataOne appendData:dataSix];
    
    NSData * bodyData = [self generateUdpBody];
    [dataOne appendData:bodyData];
    
    dataOne = [[self setYdaHeaderDatalen:bodyData.length + 8 data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderMsglen:bodyData.length + 8 data:dataOne] mutableCopy];
    dataOne = [[self setYdaHeaderChecksumData:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderChecksumData:dataOne] mutableCopy];
    
    return dataOne;
}

-(NSData *)generateUdpBody{
    
    NSMutableData * bodyData = [[self generateUdpBodyUnit:134 elementID:1 dataContent:nil] mutableCopy];
    [bodyData appendData: [self generateUdpBodyUnit:36 elementID:2 dataContent:nil]];
    [bodyData appendData: [self generateUdpBodyUnit:1 elementID:3 dataContent:nil]];
    [bodyData appendData: [self generateUdpBodyUnit:RSA_PUBLIC_KEY.length elementID:4 dataContent:RSA_PUBLIC_KEY]];
    return bodyData;
    
}
//发现
-(NSData *)generateDiscoverRequestMessage{
    
    NSMutableData * dataOne = [[self generatePreambleVersion:0 preambleCrypto:1 HLEN:0x04 YdaHeaderChecksum:0] mutableCopy];
    
    NSData * dataTwo = [self generateTransID:0 ctrlAndExt:0];
    [dataOne appendData:dataTwo];
    
    NSData * dataThree = [self generateFragmentID:0 FragOffset:0];
    [dataOne appendData:dataThree];
    
    NSData * dataFour = [self generateDataLen:0 Reserved:0];
    [dataOne appendData:dataFour];
    
    NSData * dataFive = [self generateMsgType:0x03 SeqNum:0x00 MsgLen:8];
    [dataOne appendData:dataFive];
    
    NSData * dataSix = [self generateYdaCtrlHeaderChecksum:0 Random:12];
    [dataOne appendData:dataSix];
    
    NSData * bodyData = [self generateDiscoverRequestUdpBody];
    [dataOne appendData:bodyData];
    
    dataOne = [[self setYdaHeaderDatalen:bodyData.length + 8 data:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderMsglen:bodyData.length + 8 data:dataOne] mutableCopy];
    dataOne = [[self setYdaHeaderChecksumData:dataOne] mutableCopy];
    dataOne = [[self setYdaCtrlHeaderChecksumData:dataOne] mutableCopy];
    
    return dataOne;
    
}
-(NSData *)generateDiscoverRequestUdpBody{
    
    NSMutableData * bodyData = [[self generateUdpBodyUnit:134 elementID:7 dataContent:nil] mutableCopy];
    [bodyData appendData: [self generateUdpBodyUnit:185 elementID:8 dataContent:RSA_PUBLIC_KEY]];
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
    NSData * data = [[NSData alloc]initWithBytes:byte length:4];
    NSData * resultData = [self setYdaHeaderChecksumData:data];
    return resultData;
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

-(NSData *)generateUdpBodyUnit:(short int)length elementID:(short int)ID dataContent:(NSString *)dataContent {
    
    NSUInteger datalength = 2 + 2 + length;
    Byte bodyByte[datalength];
    short int elementID = ID;
    short int elementLength = datalength;
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
