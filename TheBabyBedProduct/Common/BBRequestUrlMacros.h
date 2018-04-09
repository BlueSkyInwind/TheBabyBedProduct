//
//  BBRequestUrlMacros.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/6.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#ifndef BBRequestUrlMacros_h
#define BBRequestUrlMacros_h

#define BBIsAPPStore 0    //APPStore环境(正式1，测试0)

#if BBIsAPPStore
#define K_Url_BBBase            @"http://114.55.129.5:8788"
#else
#define K_Url_BBBase            @"http://114.55.129.5:8788"
#endif

//登录
#define K_Url_Login             @"/api/login"
//注册
#define K_Url_Regist            @"/api/reg"
//获取验证码
#define K_Url_GetCode           @"/api/sendCode"
//忘记密码
#define K_Url_ForgetPassword    @"/api/forgetpass"
//修改密码
#define K_Url_ModifyPassword    @"/api/user/cpass"
//获取用户信息
#define K_Url_GetUserInfo       @"/api/user/userInfo"
//编辑用户资料
#define K_Url_EditUserInfo      @"api/user/editinfo"
//意见反馈
#define K_Url_Suggestion        @"/api/user/sendSugister"


//消息列表
#define K_Url_MessageList        @"/api/msg/list"
//消息编辑
#define K_Url_MessageEidt        @"/api/msg/edit"
//阈值设定
#define K_Url_SetThreshold       @"api/waringsetting/setting"
//获取阈值  api/waringsetting/setting/{id}
#define K_Url_GetThreshold       @"api/waringsetting/setting"
//传感器数据获取  api/statistics/{deviceId}
#define K_Url_GetSensorData       @"api/statistics/"



#endif /* BBRequestUrlMacros_h */
