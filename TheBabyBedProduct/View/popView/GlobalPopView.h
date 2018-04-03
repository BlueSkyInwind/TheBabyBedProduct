//
//  GlobalPopView.h
//  TheBabyBedProduct
//
//  Created by admin on 2018/3/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^GlobalPopViewClick)(NSInteger index);

@interface GlobalPopView : UIView

+(instancetype)initWithTitle:(NSString *)title content:(NSString *)content cancelTitle:(NSString *)cancelTitle sureTitle:(NSString *)sureTitle clickcompletion:(GlobalPopViewClick)globalPopClickBlock;

-(void)show;

-(void)dismiss;

@end
