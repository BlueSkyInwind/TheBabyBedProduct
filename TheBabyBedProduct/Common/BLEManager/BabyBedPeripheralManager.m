//
//  BabyBedPeripheralManager.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/23.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//


// 疑问 ： 1、实时数据多长时间一次?  是中心设备写入得到，还是传感器主动通知
//   2、 蓝牙文档  3、断开怎么处理 ？是否需要主动重连？ 4、怎么调试 ? 5、上传后台的问题时那一部分

#import "BabyBedPeripheralManager.h"


static NSString * const BBReadValueCharacteristicUUID     = @"FFF0";
static NSString * const BBOpenNotifyCharacteristicUUID    = @"FFF7";
static NSString * const BBWritableCharacteristicUUID      = @"FFF6";

@interface BabyBedPeripheralManager(){

    

    
}
@property(nonatomic,strong)CBPeripheral * curPeripheral;

@end

@implementation BabyBedPeripheralManager



-(id)initWithPeripheral:(CBPeripheral *)peripheral{
    if (self = [super init]) {
        _curPeripheral = peripheral;
        _curPeripheral.delegate = self;
        [_curPeripheral discoverServices:nil];
    }
    return self;
}


-(void)parseRealtimeData:(NSData *)data peripheral:(CBPeripheral *)peripheral{
    Byte *byte = (Byte *)[data bytes];
    if ([peripheral.name isEqualToString:deviceNameOne]) {
        NSString * foreheadTem = [NSString stringWithFormat:@"%02d.%02d°C",byte[0],byte[1]];
        NSString * bodyTem = [NSString stringWithFormat:@"%02d.%02d°C",byte[2],byte[3]];
        DLog(@"额头温度 --- %@,腋下温度 --- %@",foreheadTem,bodyTem);
    }
    
    if ([peripheral.name isEqualToString:deviceNameTwo]) {
        NSString * humidityStr = [NSString stringWithFormat:@"%02d.%02d°C",byte[0],byte[1]];
        DLog(@"尿湿数值温度 --- %@",humidityStr);
    }
}

#pragma mark -CBPeripheralDelegate Function

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error{
    if (error) {
        NSLog(@"didDiscoverServices -- ERROR:%@--  %@",error,_curPeripheral.name);
    }else{
        for (CBService * service in peripheral.services) {
            [_curPeripheral discoverCharacteristics:nil forService:service];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(nullable NSError *)error{
    if (error) {
        NSLog(@"didDiscoverCharacteristicsForService -- ERROR:%@--  %@",error,_curPeripheral.name);
    }else{
        for (CBCharacteristic *character in service.characteristics)  {
            if ([character.UUID isEqual:[CBUUID UUIDWithString:BBWritableCharacteristicUUID]]) {
                //写入
                NSString * cmd = @"DF#SSOP";
                NSData * writeData = [cmd dataUsingEncoding:kCFStringEncodingUTF8];
                [peripheral writeValue:writeData forCharacteristic:character type:CBCharacteristicWriteWithoutResponse];
            }
            if ([character.UUID isEqual:[CBUUID UUIDWithString:BBOpenNotifyCharacteristicUUID]]) {
                [_curPeripheral setNotifyValue:YES forCharacteristic:character];
                NSLog(@"Set Indicatable Notify YES --- %@",_curPeripheral.name);
            }
            if ([character.UUID isEqual:[CBUUID UUIDWithString:BBReadValueCharacteristicUUID]]) {
                [_curPeripheral readValueForCharacteristic:character];
            }
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    if (error) {
        NSLog(@"didUpdateValueForCharacteristic -- ERROR:%@--  %@",error,_curPeripheral.name);
    }else{
        [self parseRealtimeData:characteristic.value peripheral:peripheral];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    if (error) {
        DLog(@"写入错误 -- %@ -- didWriteValueForCharacteristic %@",peripheral.name,error);
    }else{
        DLog(@"写入成功");
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error{
    if (error) {
        NSLog(@"didUpdateNotificationStateForCharacteristic -- ERROR:%@--  %@",error,_curPeripheral.name);
    }else{

    }
}


@end
