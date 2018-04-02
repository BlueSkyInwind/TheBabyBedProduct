//
//  BaseCentralManager.h
//  Thermometer
//
//  Created by Mac on 9/16/15.
//  Copyright (c) 2015 tmholter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BasePeripheralManager.h"

@protocol BaseCentralManagerDelegate <NSObject>

@optional
/*!
 *  @method onScanning:
 *
 *  @param peripheralArray 扫描到的所有指定名字的周边的数组，数组元素是字典，字典的键定义在BLEMacro.h里面。
 *
 *  @discussion 当调用了startScan方法后，每扫描到一次蓝牙设备就会触发该delegate方法，表示正在扫描中。
 *
 */
-(void)onScanning:(NSArray *)peripheralArray;

/*!
 *  @method onConnectingPeripheral:
 *
 *  @param peripheral 正在连接中的周边
 *
 *  @discussion 当调用了connectPeripheralWithIndex:方法后，立即触发该delegate方法，表示正在连接中，直到onConnectedPeripheral或者onDisconnectedPeripheral被触发。
 *
 */
-(void)onConnectingPeripheral:(CBPeripheral *)peripheral;

/*!
 *  @method onConnectedPeripheral:
 *
 *  @param peripheral 连接成功的周边
 *
 *  @discussion 当调用了connectPeripheralWithIndex:方法后，很短的时间内该delegate方法被触发，表示连接成功。
 *              连接成功后，connectedPeripheral属性被赋值，需立即遵从BasePeripheralManagerDelegate协议来接收设备的信息。
 *              可订阅deviceConnected通知
 *
 */
-(void)onConnectedPeripheral:(CBPeripheral *)peripheral;

/*!
 *  @method onDisconnectedPeripheral:
 *
 *  @param peripheral 已经断开连接的周边
 *
 *  @discussion 当调用了disconnect:方法后，触发该delegate方法，表示断开连接；或者当调用了connectPeripheralWithIndex:方法后，连接失败；或者由于其他原因的断开连接。
 *              断开连接后，connectedPeripheral属性被赋值为nil。
 *              可订阅deviceDisconnected通知
 *
 */
-(void)onDisconnectedPeripheral:(CBPeripheral *)peripheral;

@end



@interface BaseCentralManager : NSObject<CBCentralManagerDelegate>

/*!
 *  @property manager
 *
 *  @discussion 可以使用该对象查看手机蓝牙状态CBCentralManagerState，不建议使用该对象的其他方法
 *
 */
@property(nonatomic,strong)CBCentralManager * manager;

/*!
 *  @property connectedPeripheral
 *
 *  @discussion 连接成功的周边管理者对象，断开连接后为nil。可根据该属性是否为nil判断是否有连接。
 *
 */
@property(nonatomic,strong)BasePeripheralManager * connectedPeripheral;

/*!
 *  @property delegate
 *
 *  @discussion 建议在shareInstance拿到BaseCentralManager对象后，立即遵从该delegate的协议。
 *
 */
@property (nonatomic,weak)id<BaseCentralManagerDelegate> delegate;

/*!
 *  @method shareInstance
 *
 *  @discussion 获取单例对象
 *
 */
+(id)shareInstance;

/*!
 *  @method getVersion
 *
 *  @discussion 获取SDK版本号
 *
 */
-(NSString *)getVersion;

/*!
 *  @method startScan
 *
 *  @discussion 开始扫描，可以在调用该方法时使用delayPerformance或者NSTimer做个10秒左右的超时，来调用stopScan
 *
 */
-(void)startScan;

/*!
 *  @method stopScan
 *
 *  @discussion 停止扫描
 *
 */
-(void)stopScan;

/*!
 *  @method connectPeripheralWithIndex:
 *
 *  @param aindex 该数值是大于0并且小于onScanning:回调中数组的个数，否则该方法直接被return。
 *
 *  @discussion 将要连接某个已扫描到的设备时调用，建议使用delayPerformance或者NSTimer做个5秒左右的超时。
 *
 */
-(void)connectPeripheralWithIndex:(int)aindex;

/*!
 *  @method cancelConnecting
 *
 *  @discussion 取消正在连接的操作。建议在连接超时时调用该方法。
 *
 */
-(void)cancelConnecting;

/*!
 *  @method disconnect
 *
 *  @discussion 需要断开连接时调用
 *
 */
-(void)disconnect;

@end
