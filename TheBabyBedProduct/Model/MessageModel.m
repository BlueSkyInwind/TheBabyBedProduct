//
//  MessageModel.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/8.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel



@end

@implementation MessageInfoModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.message_id = value;
    }
}
- (void)setNilValueForKey:(NSString *)key{
    
}
@end

@implementation MessagePageInfoModel



@end


