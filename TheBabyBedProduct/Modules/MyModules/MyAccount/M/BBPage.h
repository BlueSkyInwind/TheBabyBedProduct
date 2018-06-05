//
//  BBPage.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/6/1.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBPage : NSObject
@property(nonatomic,assign) NSInteger totalElements;
@property(nonatomic,assign) NSInteger totalPages;
@property(nonatomic,assign) NSInteger curretnPage;
@end

/*

page =     {
    content =         (
    );
    count = 19;
    first = 1;
    last = 0;
    number = 0;
    numberOfElements = 10;
    size = 10;
    totalElements = 19;
    totalPages = 2;
};
 
 */
