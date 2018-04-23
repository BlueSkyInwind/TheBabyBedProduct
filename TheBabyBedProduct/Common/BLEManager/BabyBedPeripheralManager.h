//
//  BabyBedPeripheralManager.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/23.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BasePeripheralManager.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "BLEMacro.h"
@interface BabyBedPeripheralManager : NSObject<CBPeripheralDelegate>


@property(nonatomic,strong,readonly)CBPeripheral * curPeripheral;

-(id)initWithPeripheral:(CBPeripheral *)peripheral;

-(void)clean;

@end
