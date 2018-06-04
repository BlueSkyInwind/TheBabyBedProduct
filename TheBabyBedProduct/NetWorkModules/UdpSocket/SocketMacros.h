//
//  SocketMacros.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/4/19.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#ifndef SocketMacros_h
#define SocketMacros_h


UIKIT_EXTERN NSString * const Baby_Valid_Value;
UIKIT_EXTERN NSString * const Baby_Cry_State;
UIKIT_EXTERN NSString * const Baby_Kick_State;
UIKIT_EXTERN NSString * const Env_Temp_Value;
UIKIT_EXTERN NSString * const Env_Humidity_Value; //干爽:  < 10,  轻度尿湿:  10 > 检测值 > 50,  需更换:  > 50
UIKIT_EXTERN NSString * const Body_Temp_Value;
UIKIT_EXTERN NSString * const Baby_Urine_Value;


UIKIT_EXTERN NSString * const    VideoPlayrStatus;
UIKIT_EXTERN NSString * const    VideoClarityStatus;
UIKIT_EXTERN NSString * const    Video_Address;


#define  RSA_PUBLIC_KEY @"MFwwDQYJKoZIhvcNAQEBBQADSwAwSAJBANXiHjAdUiuliqK80/aePb6WxLlp+LCykHiTyA1ButlQ416YfGNKjLQC/QX34RzR/vg7huNyU+36NrYrumrk4SECAwEAAQ=="

#define RSA_PRIVATE_KEY @"MIIBOgIBAAJBANXiHjAdUiuliqK80/aePb6WxLlp+LCykHiTyA1ButlQ416YfGNKjLQC/QX34RzR/vg7huNyU+36NrYrumrk4SECAwEAAQJAYzZASpFPTG+9nz94Ey3T9lR5bIh7k3tBCK2EXqHeym6h3xO5gwGsBlVGLaFtsORs2fm0A3MW4ynLcgJDN1enAQIhAPBrMxP675CYL398ckr7syxG1Fdu8aVtPM/TQhErDmt7AiEA476quZjmtw5XbVgk4oFwfhd6eDypa3xsKtQ+59I0hRMCIDn3Dqydjs8E8kbBgWj0wKFHPoEKHbbt3ICbBc3P3L0rAiEAl+F+BcxcgNQFphxUbOIZ3V1XBXyfF9mgYWeuk/dxoxUCIAnI1G4xcmEgOdaNLQOi7RrAzPZBOzzanSU24QuFPnrL"

#define YDA_HAEDER_LENGTH 16
#define YDA_CTRL_HAEDER_LENGTH 8

#define YDA_EVENT_NOTIFICATION @"YDA_EVENT_NOTIFICATION"






#endif /* SocketMacros_h */
