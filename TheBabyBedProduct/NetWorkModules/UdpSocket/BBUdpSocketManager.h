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
    
-(void)sendEventNotificationRequestMessage:(NSDictionary *)eventDic;
    
@end
