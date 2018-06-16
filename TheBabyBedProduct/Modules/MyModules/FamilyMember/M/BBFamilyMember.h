//
//  BBFamilyMember.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/2.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BBPage;

@interface BBFamilyMember : NSObject
@property(nonatomic,assign) BBApplyStatus applyStatus;
@property(nonatomic,assign) BBApplyType applyType;
@property(nonatomic,strong) NSNumber *createTime;
@property(nonatomic,copy) NSString *memberID;
@property(nonatomic,copy) NSString *identity;
@property(nonatomic,copy) NSString *name;
/** 头像 */
@property(nonatomic,copy) NSString *avatar;
/** 是否是管理者 0 no, 1 yes*/
@property(nonatomic,assign) BOOL manager;
/** 是否有观看视频的权限 0 no, 1 yes*/
@property(nonatomic,assign) BOOL videoAuth;
@end

@interface BBFamilyMemberListResult : NSObject
@property(nonatomic,assign) NSInteger code;
@property(nonatomic,assign) NSInteger count;
@property(nonatomic,strong) NSMutableArray *data;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,strong) BBPage *page;
@end

/*
bind list {
    code = 0;
    count = 2;
    data =     (
                {
                    applyStatus = 1;
                    applyType = 1;
                    createTime = 1527756488;
                    id = 318131819af0409bbd06f03fb2daaa01;
                    identity = "爸爸";
                    manager = 1;
                    name = "宝宝";
                },
                {
                    applyStatus = 1;
                    applyType = 1;
                    createTime = 1527755974;
                    id = 339800740c564899be475e75d8968c1e;
                    identity = "爸爸";
                    manager = 1;
                    name = "杨";
                    videoAuth = 1;
                }
                );
    msg = "请求成功";
    page =     {
        content =         (
                           {
                               "$ref" = "$.data[0]";
                           },
                           {
                               "$ref" = "$.data[1]";
                           }
                           );
        count = 2;
        first = 1;
        last = 1;
        number = 0;
        numberOfElements = 2;
        size = 10;
        totalElements = 2;
        totalPages = 1;
    };
}
 
 */
 
