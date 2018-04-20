//
//  SendUdpMessage.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/19.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SendUdpMessage : NSObject



//寻址
-(NSData *)generateAddressingMessage;
-(NSData *)testGenerateAddressingMessage;
@end
