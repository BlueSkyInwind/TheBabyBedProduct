//
//  BasePeripheralManager.h
//  BraHolter
//
//  Created by Mac on 11/10/15.
//  Copyright © 2015 tmholter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BLEMacro.h"


#define HI_UINT16(a) (((a) >> 8) & 0xff)
#define LO_UINT16(a) ((a) & 0xff)


@protocol BasePeripheralManagerDelegate <NSObject>

@optional
/*!
 *  @method onFinishedGettingInfoForPeripheral:
 *
 *  @param peripheral 周边
 *
 *  @discussion 设备基本信息读取完毕delegate方法。连接成功后SDK会自动读取设备信息。该delegate方法被触发之后，BasePeripheralManager对象的属性才会被赋值。
 *              如果未实现该delegate方法，也可订阅finishedGetDeviceInfo通知
 *
 */
-(void)onFinishedGettingInfoForPeripheral:(CBPeripheral *)peripheral;

/*!
 *  @method onHistoryTotalReceived:withPeripheral:
 *
 *  @param total 设备返回的历史数据总量的值
 *  @param peripheral 周边
 *
 *  @discussion 设备返回有total历史数据总量，参看getHistoryTotal方法
 *
 */
-(void)onHistoryTotalReceived:(int)total withPeripheral:(CBPeripheral *)peripheral;

/*!
 *  @method onHistoryDataReceived:withPeripheral:currentPercent:
 *
 *  @param dataArray 设备返回的历史数据
 *  @param peripheral 周边
 *  @param percent 当前同步历史数据的百分比
 *
 *  @discussion 在同步历史数据过程中该方法一直被调用直到同步完所有历史数据，参看startHistoryReading方法
 *
 */
-(void)onHistoryDataReceived:(NSArray *)dataArray withPeripheral:(CBPeripheral *)peripheral currentPercent:(float)percent;

/*!
 *  @method onHistoryDataFinishedWithinPeripheral:
 *
 *  @param peripheral 周边
 *
 *  @discussion 历史数据同步完成触发该delegate方法
 *              如果未实现该delegate方法，也可订阅finishedSyncHistory通知
 */
-(void)onHistoryDataFinishedWithinPeripheral:(CBPeripheral *)peripheral;

/*!
 *  @method onRealtimeDataReceived: withPeripheral:
 *
 *  @param dataDictionary 实时数据
 *  @param peripheral 周边
 *
 *  @discussion 连接成功后该方法会一直调用直到连接断开，每5秒钟返回一条实时数据
 *
 */
-(void)onRealtimeDataReceived:(NSDictionary *)dataDictionary withPeripheral:(CBPeripheral *)peripheral;

/*!
 *  @method onCheckFirmwareFile: withPeripheral:
 *
 *  @param result 文件校验结果，NO表示文件错误，YES表示正确
 *  @param peripheral 周边
 *
 *  @discussion 更新固件时，给SDK的固件文件是否校验通过的回调delegate方法，参看startUpdateFirmware:方法
 *
 */
-(void)onCheckFirmwareFile:(BOOL)result withPeripheral:(CBPeripheral *)peripheral;

/*!
 *  @method onUpdatingFirmwarePercentChanged: withPeripheral:
 *
 *  @param percent 更新固件的进度百分比
 *  @param peripheral 周边
 *
 *  @discussion 在更新固件的过程中该方法会一直被调用直到更新结束，在该过程中可使用cancelUpdateFirmware方法来取消固件更新
 *              可以订阅updateFirmwareSuccessful通知和updateFirmwareFailed通知来判断是否升级固件成功
 *
 */
-(void)onUpdatingFirmwarePercentChanged:(float)percent withPeripheral:(CBPeripheral *)peripheral;

@end


@interface BasePeripheralManager : NSObject

/*!
 *  @property curPeripheral
 *
 *  @discussion 当前连接成功的周边
 *
 */
@property(nonatomic,strong)CBPeripheral * curPeripheral;

/*!
 *  @property systemID
 *
 *  @discussion 设备的systemID，按字节翻转后就是设备的MAC地址
 *
 */
@property(nonatomic,strong)NSData * systemID;

/*!
 *  @property deviceMACAddress
 *
 *  @discussion 设备的MAC地址，是从systemID属性按字节翻转后得到的；
 *              在iOS这端，除非设备本身广播MAC地址，否则只能在连接后才能得到MAC,在扫描的时候，只能得到设备的UUID，并且同一个设备用不同的iOS设备扫描到的UUID是不同的。
 *
 */
@property(nonatomic,strong)NSString * deviceMACAddress;

/*!
 *  @property curFirmwareVersion
 *
 *  @discussion 设备的固件版本
 *
 */
@property(nonatomic,copy)NSString * curFirmwareVersion;

/*!
 *  @property curHardwareVersion
 *
 *  @discussion 设备的硬件版本
 *
 */
@property(nonatomic,copy)NSString * curHardwareVersion;

/*!
 *  @property batteryLevel
 *
 *  @discussion 设备的电池电量
 *
 */
@property(nonatomic)int batteryLevel;

/*!
 *  @property temperatureCalibration
 *
 *  @discussion 设备里面存储的温度校正值
 *
 */
@property(nonatomic)int temperatureCalibration;

/*!
 *  @property needUpdateFirmware
 *
 *  @discussion 是否需要更新固件
 *
 */
@property BOOL needUpdateFirmware;

/*!
 *  @property imgVersion
 *
 *  @discussion 标示当前的固件是A包还是B包
 *
 */
@property uint16_t imgVersion; //firmware part A/B

/*!
 *  @property delegate
 *
 *  @discussion 建议在连接成功后，立即遵从该delegate的协议。
 *
 */
@property (nonatomic,weak)id<BasePeripheralManagerDelegate> delegate;

/*!
 *  @method initWithPeripheral
 *
 *  @param peripheral
 *
 *  @discussion 初始化，该方法BaseCentralManager对象会在连接成功后自动调用，不建议App调用该初始化方法。
 *
 */
-(id)initWithPeripheral:(CBPeripheral *)peripheral;

/*!
 *  @method getHistoryTotal
 *
 *  @discussion 从设备读取一下设备的历史数据总量，连接成功后SDK会自动调用一次该方法。
 *              调用后，onHistoryTotalReceived: withPeripheral: delegate方法被触发
 *
 */
-(void)getHistoryTotal;

/*!
 *  @method hasHistoryData
 *
 *  @discussion 返回是否有历史数据，在调用该方法之前，建议调用getHistoryTotal从设备读取一下设备的历史数据总量。
 *              连接后SDK会自动调用一次getHistoryTotal来从设备读取一下设备的历史数据总量。
 *
 */
-(BOOL)hasHistoryData;

/*!
 *  @method startHistoryReading
 *
 *  @discussion 开始同步设备保存的历史数据，该方法会根据hasHistoryData方法的返回值判断是否有数据，如果没有数据会直接return掉
 *              同步完之后SDK会将设备历史数据总量置零，此时调用hasHistoryData返回NO。除非再手动调用一次getHistoryTotal
 *              调用后，相继触发 onHistoryDataReceived: withPeripheral: currentPercent: 和 onHistoryDataFinishedWithinPeripheral: delegate方法
 *
 */
-(void)startHistoryReading;

/*!
 *  @method startUpdateFirmware:
 *
 *  @param filePath 新固件的bin文件放置路径，一般需要首先从网络下载保存到本地
 *
 *  @discussion 开始更新设备固件，在这之前应该先去服务器检查是否有新固件
 *
 */
-(void)startUpdateFirmware:(NSString *)filePath;

/*!
 *  @method cancelUpdateFirmware
 *
 *  @discussion 取消固件更新，在固件升级过程中使用
 *
 */
-(void)cancelUpdateFirmware;

/*!
 *  @method clean
 *
 *  @discussion 该方法是BaseCentralManager对象在设备断开连接时调用的。不建议App层使用。
 *
 */
-(void)clean;

@end
