//
//  BBIdentity.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/16.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBIdentity : NSObject
@property(nonatomic,copy) NSString *identityId;
@property(nonatomic,copy) NSString *identityName;
@end


@interface BBIdentityListResult : NSObject
@property(nonatomic,assign) NSInteger code;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,strong) NSMutableArray *data;
@end

/*

{
    code = 0;
    data =     (
                {
                    id = 06829f8937d54c25a0d415794ad2b410;
                    name = "爸爸";
                },
                {
                    id = 1;
                    name = "叔叔";
                },
                {
                    id = 11;
                    name = "奶奶";
                },
                {
                    id = 19b2a306d26d4e74b4b1454d239cdf2f;
                    name = "妈妈";
                },
                {
                    id = 2;
                    name = "婶婶";
                },
                {
                    id = 3;
                    name = "阿姨";
                },
                {
                    id = 4;
                    name = "舅舅";
                },
                {
                    id = 5;
                    name = "舅妈";
                },
                {
                    id = 6;
                    name = "外公";
                },
                {
                    id = 7;
                    name = "外婆";
                },
                {
                    id = b4133fe3e4a1429eb4c7527497bc8008;
                    name = "爷爷";
                }
                );
    msg = "请求成功";
}
 
 */
