//
//  UdpSocketManeger.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/17.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface BBUdpSocketManager : NSObject{
    

}

+(BBUdpSocketManager *)shareInstance;

-(void)createAsyncUdpSocket;
    
-(void)sendAddressMessage;
/**
 事件通知请求
 
 @param eventDic 值的字典 包含 key如下：
 Baby_Cry_State    1: Cry    0: Normal       //哭闹状态  2字节
 Baby_Kick_State   1: Kick   0: Normal           //踢被状态  2字节
 Env_Temp_Value    温度值 有符号  4字节
 Env_Humidity_Value   湿度值，无符号4字节
 Body_Temp_Value    //体温值 有符号4字节
 Baby_Urine_Value    //尿湿值 无符号2字节
 */
-(void)sendEventNotificationRequestMessage:(NSDictionary *)eventDic;
/**
 //CFG设置报文
 
 @param dic  VideoPlayrStatus ： 1、开始播放  2、暂停播放
 VideoClarityStatus ： 1、标清  2、高清
 */
-(void)sendCFGSettingRequestMessage:(NSDictionary *)dic;

@end
