//
//  BaseCentralManager.m
//  Thermometer
//
//  Created by Mac on 9/16/15.
//  Copyright (c) 2015 tmholter. All rights reserved.
//

#import "BaseCentralManager.h"
//#import "WeChatPeripheralManager.h"
#import "BasePeripheralManager.h"

#define selfVersionCode @"1.0.0"


@interface BaseCentralManager(){
    
    NSMutableArray * peripheralDictionaryArray;
    
    CBPeripheral * theConnectingPeripheral; //strong hold object, for [CBCentralManager connectPeripheral...] function.
    
    BOOL isConnectting;
    
}

@property(nonatomic,copy,readwrite)CentralManagerStatusBlock  statusBlock;
@property(nonatomic,copy,readwrite)BOOL    managerStatus;

@end

@implementation BaseCentralManager


@synthesize manager,connectedPeripheral;

static BaseCentralManager * controller;

+(id)shareInstance{
    //has been rewrite "allocWithZone" and "copy"
    @synchronized(self){
        if (controller == nil) {
            controller = [[BaseCentralManager alloc] init];
        }
    }
    return controller;
}

//rewrite this method, whatever you call how many init, this class return only same one object
+(instancetype)allocWithZone:(struct _NSZone *)zone{

    if (controller == nil) {
        controller = [super allocWithZone:zone];
    }
    
    return controller;
}

//rewrite this method, whatever you call how many init, this class return only same one object
-(id)copy{
    return controller;
}

-(id)init{
    if (self = [super init]) {
        //do something to init
        manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
        peripheralDictionaryArray = [[NSMutableArray alloc] init];
        isConnectting = NO;
        NSLog(@"MH80NManager Version:%@",selfVersionCode);
    }
    return self;
}

-(NSString *)getVersion{
    return selfVersionCode;
}

-(void)startScan{
    [peripheralDictionaryArray removeAllObjects];
    [manager stopScan];
    [manager scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey: @NO}];
    NSLog(@"Start Scan!!");
}
-(void)stopScan{
    NSLog(@"Stop Scan!!");
    [manager stopScan];
}

-(void)connectPeripheralWithIndex:(int)aindex{
    
    if (isConnectting == YES) {
        NSLog(@"is Connectting, return!");
        return;
    }
    
    if (aindex >= peripheralDictionaryArray.count || aindex < 0) {
        return;
    }
    
    [self stopScan];
    NSMutableDictionary * tmpDict = [peripheralDictionaryArray objectAtIndex:aindex];
    CBPeripheral * p = tmpDict[thePeripheral];
    
    if (connectedPeripheral != nil) {
        if ([p.name isEqualToString:deviceNameOne]) {
            NSLog(@"Has been connected a device!!!");
            return;
        }
    }
    
    isConnectting = YES;
    [manager connectPeripheral:p options:nil];
    theConnectingPeripheral = p;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onConnectingPeripheral:)]) {
        [self.delegate onConnectingPeripheral:p];
    }
    NSLog(@"Connect!!!");
}

-(void)cancelConnecting{
    if (theConnectingPeripheral) {
        [manager cancelPeripheralConnection:theConnectingPeripheral];
        theConnectingPeripheral = nil;
    }
}

-(void)disconnect{
    isConnectting=NO;
    
    [self stopScan];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:deviceDisconnected object:nil];
    if (connectedPeripheral && connectedPeripheral.curPeripheral) {
        [manager cancelPeripheralConnection:connectedPeripheral.curPeripheral];
        if (self.delegate && [self.delegate respondsToSelector:@selector(onDisconnectedPeripheral:)]) {
            [self.delegate onDisconnectedPeripheral:connectedPeripheral.curPeripheral];
        }
//        [connectedPeripheral clean];
        connectedPeripheral = nil;
    }
    NSLog(@"Disconnect!!!");
}


#pragma mark -CBCentralManagerDelegate Function
//蓝牙连接状态
- (void)centralManagerDidUpdateState:(CBCentralManager *)central{
    switch (central.state) {
        case CBCentralManagerStateUnknown:
        
            NSLog(@"蓝牙---CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
            
            NSLog(@"蓝牙---CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            
            NSLog(@"蓝牙---CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            
            NSLog(@"蓝牙---CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStatePoweredOff:
            self.managerStatus = false;
            [self disconnect];
            NSLog(@"关闭蓝牙---CBCentralManagerStatePoweredOff！");
            break;
        case CBCentralManagerStatePoweredOn:
            self.managerStatus = true;
            NSLog(@"打开蓝牙------CBCentralManagerStatePoweredOn！！");
            break;
        default:
            break;
    }
    [self setManagerStatus];
}
-(BOOL)setManagerStatus{
    [GlobalTool saveUserDefaul:[NSString stringWithFormat:@"%@",@(_managerStatus)] Key:BLE_POWER_NOTIFI];
    return _managerStatus;
}

-(void)getCentralManagerStatus:(CentralManagerStatusBlock)managerStatus{
    self.statusBlock = managerStatus;
}

//发现设备
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)aPeripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    //NSLog(@"Peripheral:%@",aPeripheral);
    
    if (![aPeripheral.name hasPrefix:deviceNameP]) {
        return;
    }
    
    NSString * identifier = [NSString stringWithFormat:@"%@",aPeripheral.identifier.UUIDString];
    NSLog(@"Scanned device ID:%@",identifier);
    
    NSMutableDictionary * peripheralDictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:aPeripheral,thePeripheral,aPeripheral.name,thePeripheralName,identifier,theIdentifier,RSSI,theRSSI, nil];
    
    NSMutableDictionary * tmpDict;
    for (int i = 0; i < peripheralDictionaryArray.count; i++) {
        tmpDict = [peripheralDictionaryArray objectAtIndex:i];
        if ([tmpDict[theIdentifier] isEqualToString:identifier]) {
            //if the same identifier peripheral has been exist, replace it with latest dictionary with new RSSI.
            [peripheralDictionaryArray replaceObjectAtIndex:i withObject:peripheralDictionary];
            if (self.delegate && [self.delegate respondsToSelector:@selector(onScanning:)]) {
               [self.delegate onScanning:peripheralDictionaryArray];
            }
            return;
        }
    }
    
    // if there are no replacement, directily add dictionary to array.
    [peripheralDictionaryArray addObject:peripheralDictionary];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(onScanning:)]) {
        [self.delegate onScanning:peripheralDictionaryArray];
    }
}

//已连接设备
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)aPeripheral{
    NSLog(@"didConnectPeripheral:%@",aPeripheral);
    
    if ([aPeripheral.name isEqualToString:deviceNameOne]) {
        connectedPeripheral = [[BabyBedPeripheralManager alloc] initWithPeripheral:aPeripheral];
    }

    isConnectting = NO;
    if (self.delegate && [self.delegate respondsToSelector:@selector(onConnectedPeripheral:)]) {
        [self.delegate onConnectedPeripheral:aPeripheral];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:deviceConnected object:aPeripheral];
}
//连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)aPeripheral error:(NSError *)error{
    NSLog(@"didFailToConnectPeripheral: --ERROR:%@  ---Peripheral:%@",error,aPeripheral);
    if (self.delegate && [self.delegate respondsToSelector:@selector(onDisconnectedPeripheral:)]) {
        [self.delegate onDisconnectedPeripheral:aPeripheral];
    }
    isConnectting = NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:deviceDisconnected object:aPeripheral];
}
//已经断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)aPeripheral error:(NSError *)error{
    NSLog(@"didDisconnectPeripheral: ---ERROR:%@  ----Peripheral:%@",error,aPeripheral);
    
    if (connectedPeripheral) {
        connectedPeripheral = nil;
    }

    if (self.delegate && [self.delegate respondsToSelector:@selector(onDisconnectedPeripheral:)]) {
        [self.delegate onDisconnectedPeripheral:aPeripheral];
    }
    isConnectting = NO;

    [[NSNotificationCenter defaultCenter] postNotificationName:deviceDisconnected object:aPeripheral];
}

@end
