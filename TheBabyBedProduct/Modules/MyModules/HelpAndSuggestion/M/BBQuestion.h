//
//  BBQuestion.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/7/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBQuestion : NSObject
@property(nonatomic,copy) NSString *questionId;
@property(nonatomic,copy) NSString *question;
@property(nonatomic,copy) NSString *answer;
@end



@interface BBQuestionListRequestResult : NSObject
@property(nonatomic,assign) NSInteger code;
@property(nonatomic,copy) NSString *msg;
@property(nonatomic,strong) NSMutableArray *data;
@end
