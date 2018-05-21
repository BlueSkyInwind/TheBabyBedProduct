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

//short int sendCount;

+(BBUdpSocketManager *)shareInstance;

-(void)createAsyncUdpSocket;

@end
