//
//  BBUploadImageResultModel.h
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/4/10.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BaseResultModel.h"

@interface BBUploadImageResultData : NSObject
/** 扩展名 */
@property(nonatomic,copy) NSString *extension;
/** 图片原始名称 */
@property(nonatomic,copy) NSString *fileName;
/** 图片对应id */
@property(nonatomic,copy) NSString *imgId;
/** 原图路径 */
@property(nonatomic,copy) NSString *imgPath;
/** 0.6 倍图路径 */
@property(nonatomic,copy) NSString *mutSix;
@property(nonatomic,copy) NSString *mutThree;

@end

@interface BBUploadImageResultModel : BaseResultModel
@property(nonatomic,strong) NSMutableArray *data;
@end


/*
 {
 code = 0;
 data =     (
 {
    extension = ".jpg";
    fileName = "file.jpg";
    id = c2ed6a3b28e44782ae8cde441ff4acf0;
    imgPath = "/2018/04/10/5/2/1523375351610.jpg";
    mutSix = "/2018/04/10/13/13/1523375351610@0.6.jpg";
    mutThree = "/2018/04/10/10/5/1523375351610@0.3.jpg";
 }
 );
 msg = "\U8bf7\U6c42\U6210\U529f";
 }
 */
