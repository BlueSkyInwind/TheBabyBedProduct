//
//  MessageModel.h
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/4/8.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BaseResultModel.h"

@protocol MessageInfoModel <NSObject>

@end
@protocol MessagePageInfoModel <NSObject>

@end

@interface MessageModel : BaseResultModel

@property (nonatomic, strong) NSArray<MessageInfoModel,Optional> *data;
@property (nonatomic, strong) NSDictionary<MessagePageInfoModel,Optional> *page;
@property (nonatomic, strong) NSString<Optional> *count;

@end


@interface MessageInfoModel : JSONModel

@property (nonatomic, strong)NSString<Optional> * _id;
@property (nonatomic, strong)NSString<Optional> * read;
@property (nonatomic, strong)NSString<Optional> * msg;
@property (nonatomic, strong)NSString<Optional> * title;
@property (nonatomic, strong)NSString<Optional> * type;

@end


@interface MessagePageInfoModel : JSONModel

@property (nonatomic, strong)NSArray<Optional> * content;
@property (nonatomic, strong)NSString<Optional> * first;
@property (nonatomic, strong)NSString<Optional> * last;
@property (nonatomic, strong)NSString<Optional> * number;
@property (nonatomic, strong)NSString<Optional> * numberOfElements;
@property (nonatomic, strong)NSString<Optional> * size;
@property (nonatomic, strong)NSString<Optional> * sort;
@property (nonatomic, strong)NSString<Optional> * totalElements;
@property (nonatomic, strong)NSString<Optional> * totalPages;

@end





