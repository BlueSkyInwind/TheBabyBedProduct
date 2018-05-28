//
//  BBRequestUrlMacros.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/6.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#ifndef BBRequestUrlMacros_h
#define BBRequestUrlMacros_h

#define BBIsAPPStore 0   //APPStore环境(正式1，测试0)
//http://tt1.jinzhibro.com:8788
#warning todo 记得修改baseURL
#if BBIsAPPStore
#define K_Url_BBBase            @"http://tt1.jinzhibro.com:8788"
#define K_Url_GetImg            @"http://tt1.jinzhibro.com:8081"
#define K_Url_BBUDP             @"114.55.129.5"   //47.91.220.187
#define K_port_BBUDP            9999
#define K_Url_BBBaseGCSDad      @"http://open.idaddy.cn"
#else
#define K_Url_BBBase            @"http://tt1.jinzhibro.com:8788"
#define K_Url_GetImg            @"http://tt1.jinzhibro.com:8081"
#define K_Url_BBUDP             @"47.91.220.187"
#define K_port_BBUDP            9999
#define K_Url_BBBaseGCSDad      @"http://open.idaddy.cn"
#endif


//登录 👌
#define K_Url_Login             @"/api/login"
//注册
#define K_Url_Regist            @"/api/reg"
//获取验证码
#define K_Url_GetCode           @"/api/sendCode"
//忘记密码
#define K_Url_ForgetPassword    @"/api/forgetpass"
//修改密码
#define K_Url_ModifyPassword    @"/api/user/cpass"
//获取用户信息 🆗
#define K_Url_GetUserInfo       @"/api/user/userInfo"
//编辑用户资料 👌
#define K_Url_EditUserInfo      @"/api/user/editinfo"
//意见反馈 🆗
#define K_Url_Suggestion        @"/api/user/sendSugister"
//上传图片 👌
#define K_Url_UploadImage       @"/api/upload"
//设备信息 👌
#define K_Url_DeviceInfo        @"/api/deviceInfo"
//帮助list
#define K_Url_HelpList          @"/api/help/list"

//签到
#define K_Url_SignIn            @"/api/user/signin"
//分享视频获取分钟奖励(有点问题)
#define K_Url_ShareVideo        @"/api/user/share"
//签到列表
#define K_Url_SignInList        @"/api/user/shareList"

//积分兑换
#define K_Url_Exchange          @"/api/user/exchange"


//消息列表
#define K_Url_MessageList        @"/api/msg/list"
//消息编辑
#define K_Url_MessageEidt        @"/api/msg/edit"
//阈值设定
#define K_Url_SetThreshold       @"api/waringsetting/setting"
//获取阈值  api/waringsetting/setting/{id}
#define K_Url_GetThreshold       @"api/waringsetting/setting"
//传感器数据获取  api/statistics/{deviceId}
#define K_Url_GetSensorData      @"api/statistics/"

//早教
#define K_Url_MusicList          @"/audio/v2/list"
//热门推荐（音乐）

#define K_Url_Refresh_Token     @"/audio/v2/refresh_device_token"


#endif /* BBRequestUrlMacros_h */
