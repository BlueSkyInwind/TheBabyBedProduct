//
//  SendUdpMessage.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/19.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReceiveUdpMessage.h"

UIKIT_EXTERN NSString * const Baby_Cry_State;
UIKIT_EXTERN NSString * const Baby_Kick_State;
UIKIT_EXTERN NSString * const Env_Temp_Value;
UIKIT_EXTERN NSString * const Env_Humidity_Value;
UIKIT_EXTERN NSString * const Body_Temp_Value;
UIKIT_EXTERN NSString * const Baby_Urine_Value;



@interface SendUdpMessage : NSObject

//寻址
-(NSData *)generateAddressingMessage;
-(NSData *)testGenerateAddressingMessage;
//发现
-(NSData *)generateDiscoverRequestMessage;
//登陆
-(NSData *)generateLoginRequestMessage;
//心跳
-(NSData *)generateHeartbeatRequestMessage;
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
-(NSData *)generateEventNotificationRequestMessage:(NSDictionary *)valueDic;
//设备管理报文
-(NSData *)generateEquipmentmanagementRequestMessage;
@end
