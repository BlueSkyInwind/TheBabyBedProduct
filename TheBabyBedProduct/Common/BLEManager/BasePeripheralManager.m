//
//  BasePeripheralManager.m
//  BraHolter
//
//  Created by Mac on 11/10/15.
//  Copyright © 2015 tmholter. All rights reserved.
//

#import "BasePeripheralManager.h"

@implementation BasePeripheralManager{
    
}

-(id)initWithPeripheral:(CBPeripheral *)peripheral{
    if (self = [super init]) {
        //do something to init
        
    }
    return self;
}

-(void)startRealtimeTempNotify{}
-(void)stopRealtimeTempNotify{}

-(BOOL)hasHistoryData{
    return NO;
}
-(void)startHistoryReading{
    NSLog(@"BasePeripheralManager --- startHistoryReading");
}
-(void)getHistoryTotal{}

-(void)startUpdateFirmware:(NSString *)filePath{}
-(void)cancelUpdateFirmware{}

-(void)clean{}

@end
