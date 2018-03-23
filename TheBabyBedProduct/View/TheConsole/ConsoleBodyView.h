//
//  ConsoleBodyView.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/23.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^BobyTemperatureBtnClick)(UIButton * button);
typedef void (^RoomTemperatureBtnClick)(UIButton * button);
typedef void (^CryingBtnClick)(UIButton * button);
typedef void (^WettingBtnClick)(UIButton * button);
typedef void (^QulitBtnClick)(UIButton * button);
typedef void (^VideoBtnClick)(UIButton * button);

@interface ConsoleBodyView : UIView

@property (weak, nonatomic) IBOutlet UIButton *bobyTemperatureBtn;

@property (weak, nonatomic) IBOutlet UIButton *roomTemperatureBtn;

@property (weak, nonatomic) IBOutlet UIButton *cryingBtn;

@property (weak, nonatomic) IBOutlet UIButton *wetBtn;

@property (weak, nonatomic) IBOutlet UIButton *quiltBtn;
@property (weak, nonatomic) IBOutlet UIButton *videoBtn;



@property (copy, nonatomic)BobyTemperatureBtnClick bobyTemperatureBtnClick;
@property (copy, nonatomic)RoomTemperatureBtnClick roomTemperatureBtnClick;
@property (copy, nonatomic)CryingBtnClick cryingBtnClick;
@property (copy, nonatomic)WettingBtnClick wettingBtnClick;
@property (copy, nonatomic)QulitBtnClick qulitBtnClick;
@property (copy, nonatomic)VideoBtnClick videoBtnClick;

@end
