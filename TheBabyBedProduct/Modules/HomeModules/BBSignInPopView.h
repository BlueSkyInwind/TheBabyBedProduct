//
//  BBSignInPopView.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/16.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBSignInPopView : UIView

+(instancetype)signInPopViewWithSignInBlock:(void(^)(BBSignInPopView *popV))signInBlock;
-(void)show;
-(void)hidden;
-(void)signInSuccess;
@end
