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

#if JRIsAPPStore
#define K_Url_BBBase        @"http://114.55.129.5:8788"
#else
#define K_Url_BBBase        @"http://114.55.129.5:8788"
#endif

//登录
#define K_Url_Login         @"/api/login"

#endif /* BBRequestUrlMacros_h */
