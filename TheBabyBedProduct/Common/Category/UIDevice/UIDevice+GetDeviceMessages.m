//
//  UIDevice+GetDeviceMessages.m
//  JRTianTong
//
//  Created by ╰莪呮想好好宠Nǐつ on 2017/11/7.
//  Copyright © 2017年 JinRi . All rights reserved.
//

#import "UIDevice+GetDeviceMessages.h"
//device getIP start
#import <sys/socket.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import "Reachability.h"
//device getIP end

@implementation UIDevice (GetDeviceMessages)
+ (NSString *)pp_device_ipAddress
{
    //参考：http://blog.csdn.net/magiczyj/article/details/52035231
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    struct sockaddr_in *s4;
    struct sockaddr_in6 *s6;
    char buf[64];
    int success = 0;
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus netStatus = [reach currentReachabilityStatus];
    
    //pdp_ip0 手机网络ip地址, en0 wifi 网络地址
    NSString *netType = @"en0";
    if (netStatus == ReachableViaWWAN) {
        netType = @"pdp_ip0";
    }
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:netType])//en1 on simulator if mac on wifi
                {
                    s4 = (struct sockaddr_in *)temp_addr->ifa_addr;
                    
                    if (inet_ntop(temp_addr->ifa_addr->sa_family, (void *)&(s4->sin_addr), buf, sizeof(buf)) == NULL)
                    {
                    }
                    else{
                        address = [NSString stringWithUTF8String:buf];
                    }
                    
                }
            } else if (temp_addr->ifa_addr->sa_family == AF_INET6) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:netType])
                {
                    s6 = (struct sockaddr_in6 *)(temp_addr->ifa_addr);
                    
                    if (inet_ntop(temp_addr->ifa_addr->sa_family, (void *)&(s6->sin6_addr), buf, sizeof(buf)) == NULL)
                    {
                    }
                    else{
                        address = [NSString stringWithUTF8String:buf];
                    }
                    
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}
+(BOOL)pp_device_iphone5
{
    return _k_h == 568 ? YES:NO;
}
+(BOOL)pp_device_iPhone6_6s_7_8
{
    return _k_h == 667 ? YES:NO;
}
+(BOOL)pp_device_iPhone6p_6sp_7p_8p
{
    return _k_h == 736 ? YES:NO;
}
+(BOOL)pp_device_iphoneX
{
    return [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO;
}
+(CGFloat)pp_device_statusBarHeight
{
    return PPDevice_isiPhoneX?44:20;
}
+(CGFloat)pp_device_navBarHeight
{
    return PPDevice_isiPhoneX?88:64;
}
@end

