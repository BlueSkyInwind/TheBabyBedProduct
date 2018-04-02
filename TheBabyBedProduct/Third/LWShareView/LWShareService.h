//
//  ArtShareService.h
//  LWShareView
//
//  Created by LeeWong on 2018/1/10.
//  Copyright © 2018年 LeeWong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define LWShareServices [LWShareService shared]
@interface LWShareService : NSObject

@property (nonatomic, copy) void (^shareBtnClickBlock)(NSIndexPath *index);

+ (instancetype)shared;

-(void)hidden;

- (void)showInViewController:(UIViewController *)viewController;
@end
