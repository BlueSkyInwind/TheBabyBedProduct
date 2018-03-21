//
//  BaseViewModel.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ReturnValueBlock)(id returnValue);
typedef void(^FaileBlock)(id error);

@interface BaseViewModel : NSObject

@property (nonatomic,copy) ReturnValueBlock returnBlock;
@property (nonatomic,copy) FaileBlock faileBlock;


@end
