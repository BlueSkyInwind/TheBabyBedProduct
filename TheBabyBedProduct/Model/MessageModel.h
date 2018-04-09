//
//  MessageModel.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/8.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BaseResultModel.h"
@class MessagePageInfoModel;

@protocol MessageInfoModel <NSObject>

@end

@interface MessageModel : BaseResultModel

@property (nonatomic, strong) NSArray<MessageInfoModel,Optional> *data;
@property (nonatomic, strong) MessagePageInfoModel<Optional> * page;
@property (nonatomic, strong) NSString<Optional> *count;

@end


@interface MessageInfoModel : JSONModel

@property (nonatomic, strong)NSString<Optional> * message_id;
@property (nonatomic, strong)NSString<Optional> * read;
@property (nonatomic, strong)NSString<Optional> * msg;
@property (nonatomic, strong)NSString<Optional> * title;
@property (nonatomic, strong)NSString<Optional> * type;
@property (nonatomic, strong)NSString<Optional> * createTime;

@end


@interface MessagePageInfoModel : JSONModel

@property (nonatomic, strong)NSArray<Optional> * content;
@property (nonatomic, strong)NSString<Optional> * first;
@property (nonatomic, strong)NSString<Optional> * count;
@property (nonatomic, strong)NSString<Optional> * last;
@property (nonatomic, strong)NSString<Optional> * number;
@property (nonatomic, strong)NSString<Optional> * numberOfElements;
@property (nonatomic, strong)NSString<Optional> * size;
@property (nonatomic, strong)NSString<Optional> * sort;
@property (nonatomic, strong)NSString<Optional> * totalElements;
@property (nonatomic, strong)NSString<Optional> * totalPages;

@end





