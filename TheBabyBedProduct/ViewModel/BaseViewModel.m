//
//  BaseViewModel.m
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/21.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (void) setBlockWithReturnBlock:(ReturnValueBlock)returnBlock WithFaileBlock:(FaileBlock)faileBlock
{
    _returnBlock = returnBlock;
    _faileBlock = faileBlock;
}

@end
