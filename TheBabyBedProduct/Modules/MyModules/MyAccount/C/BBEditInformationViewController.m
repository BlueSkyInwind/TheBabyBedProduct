//
//  BBEditInformationViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/30.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBEditInformationViewController.h"
#import "BBEditInfoAvatarCell.h"
#import "BBNotificationSettingListCell.h"

#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZLocationManager.h"

#import "BaseResultModel.h"
#import "BBUploadImageResultModel.h"
#import "BBEditUserInfoItem.h"

#import "BRPickerView.h"
#import "BBIdentity.h"

@interface BBEditInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSArray<NSString *> *titles;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property(nonatomic,strong) BBUploadImageResultData *aUploadImageRD;
/** 记录当前页面用户资料信息的模型 */
@property(nonatomic,strong) BBEditUserInfoItem *aUserInfoItem;
@end

@implementation BBEditInformationViewController

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        if (iOS7Later) {
            _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        }
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
        
    }
    return _imagePickerVc;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_color_vcBg;
    self.titleStr = @"编辑资料";

    [self configureUserInfoItem];
    
    [self creatUI];
}
-(void)configureUserInfoItem
{
    BBUser *savedUser = [BBUser bb_getUser];
    self.aUserInfoItem = [[BBEditUserInfoItem alloc]init];
    self.aUserInfoItem.babyName = savedUser.nickName;
    self.aUserInfoItem.gender = savedUser.gender;
    self.aUserInfoItem.city = savedUser.city;
    self.aUserInfoItem.bothDate = [savedUser.both bb_dateFromTimestampForyyyyMMdd];
    self.aUserInfoItem.identity = savedUser.identity;
}

-(void)creatUI
{
    if (self.comesFrom == BBEditInformationVCComesFromRegistSuccess) {
        UIButton *skipBt = [UIButton bb_btMakeWithSuperV:nil bgColor:nil titleColor:k_color_appOrange titleFontSize:10 title:@"跳过"];
        skipBt.layer.masksToBounds = YES;
        skipBt.frame = CGRectMake(_k_w-40, PPDevice_statusBarHeight+7, 30, 30);
        skipBt.layer.cornerRadius = 15;
        skipBt.layer.borderWidth = 1.2;
        skipBt.layer.borderColor = k_color_appOrange.CGColor;
        [skipBt addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
        [self.navigationView addSubview:skipBt];
    }
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:CGRectMake(0, PPDevice_navBarHeight, _k_w, _k_h-PPDevice_navBarHeight) delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 60+87)];
    self.tableView.tableFooterView = v;
    v.backgroundColor = [UIColor clearColor];

    QMUIFillButton *saveBT = [QMUIFillButton buttonWithType:UIButtonTypeCustom];
    [v addSubview:saveBT];
    saveBT.frame = CGRectMake(40, 60+20, _k_w-80, 47);
    saveBT.titleLabel.font = [UIFont systemFontOfSize:18];
    saveBT.fillColor = rgb(255, 236, 183, 1);
    saveBT.titleTextColor = k_color_515151;
    [saveBT setTitle:@"保  存" forState:UIControlStateNormal];
    [saveBT addTarget:self action:@selector(saveAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)skipAction
{
    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.skipBlock) {
        self.skipBlock();
    }
}
-(void)saveAction
{
#warning todo
    BBUser *currentSavedUser = [BBUser bb_getUser];
    NSString *babyName = @"";
    if (![self.aUserInfoItem.babyName isEqualToString:currentSavedUser.nickName]) {
        babyName = self.aUserInfoItem.babyName;
    }
    NSString *genderStr = @"";
    if (self.aUserInfoItem.gender != currentSavedUser.gender) {
        genderStr = [NSString stringWithFormat:@"%ld",(long)self.aUserInfoItem.gender];
    }
    NSString *city = @"";
    if (![self.aUserInfoItem.city isEqualToString:currentSavedUser.city]) {
        city = self.aUserInfoItem.city;
    }
    NSString *birthday = @"";
    if (![self.aUserInfoItem.bothDate isEqualToString:[currentSavedUser.both bb_dateFromTimestampForyyyyMMdd]]) {
        birthday = self.aUserInfoItem.bothDate;
    }
    NSString *identity = @"";
    if (![self.aUserInfoItem.identity isEqualToString:currentSavedUser.identity]) {
        identity = self.aUserInfoItem.identity;
    }
    if (!self.aUploadImageRD) {
        self.aUploadImageRD = [BBUploadImageResultData new];
    }
    
    [BBRequestTool bb_requestEditUserInfoWithAvatarId:self.aUploadImageRD.imgId babyName:babyName gender:genderStr city:city birthday:birthday identity:identity password:nil rePassword:nil successBlock:^(EnumServerStatus status, id object) {
        BaseResultModel *editUserInfoRM = [BaseResultModel mj_objectWithKeyValues:object];
        if (editUserInfoRM.code == 0) {
            [QMUITips showSucceed:@"您的信息更改成功！"];
            [self getUserInfo];
            
        }else{
            [QMUITips showError:@"您的信息更改失败，请稍后再试！"];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        [QMUITips showError:@"您的信息更改失败，请稍后再试！"];

    }];
    
}
-(void)getUserInfo
{
    //只处理请求成功的情况
    [BBRequestTool bb_requestGetUserInfoWithSuccessBlock:^(EnumServerStatus status, id object) {
        BaseDictResultModel *resultM = [BaseDictResultModel mj_objectWithKeyValues:object];
        if (resultM.code == 0) {
            BBUser *savedUser = [BBUser bb_getUser];
            NSDictionary *savedUserDict = [savedUser mj_keyValues];
            NSMutableDictionary *mutDict = [[NSMutableDictionary alloc]initWithDictionary:savedUserDict];
            [mutDict addEntriesFromDictionary:resultM.data];

            BBUser *latestUser = [BBUser mj_objectWithKeyValues:mutDict];
            [BBUser bb_saveUser:latestUser];
        }
    } failureBlock:^(EnumServerStatus status, id object) {

    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 84;
    }
    return 47;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBUser *user = [BBUser bb_getUser];
    
    if (indexPath.row == 0) {
        BBEditInfoAvatarCell *cell = [BBEditInfoAvatarCell bb_cellMakeWithTableView:tableView];
        if (user && [user.avatar bb_isSafe]) {
            [cell setupCellAvatar:[K_Url_GetImg stringByAppendingString:user.avatar]];
        }
        return cell;
    }else{
        BBNotificationSettingListCell *cell = [BBNotificationSettingListCell bb_cellMakeWithTableView:tableView];
        if (self.titles.count > indexPath.row) {
            [cell setupCellStyle:BBNotificationSettingListCellStyleEditInformation title:self.titles[indexPath.row]];
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            //设置头像
            [self configureAvatar];
        }
            break;
            
        case 1:
        {
            //宝宝姓名
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"宝宝姓名" message:@"请填写您的宝宝的姓名" preferredStyle:UIAlertControllerStyleAlert];
            [alertC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.text = self.aUserInfoItem.babyName;
            }];
            UIAlertAction *cancelAlertAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *OKAlertAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                [self updateBabyName:alertC];
            }];
            
            [alertC addAction:cancelAlertAction];
            [alertC addAction:OKAlertAction];
            [self presentViewController:alertC animated:YES completion:nil];
        }
            break;
        case 2:
        {
            //性别
            BBNotificationSettingListCell *cell = (BBNotificationSettingListCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            [BRStringPickerView showStringPickerWithTitle:@"宝宝性别" dataSource:@[@"男", @"女", @"保密",@"未知"] defaultSelValue:cell.subTextLB.text resultBlock:^(id selectValue) {
                cell.subTextLB.text = selectValue;
                self.aUserInfoItem.gender = [BBUser bb_genderTypeWithStr:selectValue];
            }];
        }
            break;
        case 3:
        {
           //所在地
//            NSArray *defaultSelArr = [textField.text componentsSeparatedByString:@" "];
            NSArray *dataSource = [self getAddressDataSource];  //从外部传入地区数据源
            BBNotificationSettingListCell *cell = (BBNotificationSettingListCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            [BRAddressPickerView showAddressPickerWithShowType:BRAddressPickerModeArea dataSource:dataSource defaultSelected:nil isAutoSelect:YES themeColor:nil resultBlock:^(BRProvinceModel *province, BRCityModel *city, BRAreaModel *area) {
                NSString *areaStr = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
                cell.subTextLB.text = areaStr;
                self.aUserInfoItem.city = areaStr;
//                textField.text = self.infoModel.addressStr = [NSString stringWithFormat:@"%@ %@ %@", province.name, city.name, area.name];
                NSLog(@"省[%zi]：%@，%@", province.index, province.code, province.name);
                NSLog(@"市[%zi]：%@，%@", city.index, city.code, city.name);
                NSLog(@"区[%zi]：%@，%@", area.index, area.code, area.name);
                NSLog(@"--------------------");
            } cancelBlock:^{
                NSLog(@"点击了背景视图或取消按钮");
            }];
        }
            break;
        case 4:
        {
            //出生日期
            BBNotificationSettingListCell *cell = (BBNotificationSettingListCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
            NSDate *minDate = [NSDate setYear:1990 month:1 day:1];
            NSDate *maxDate = [NSDate date];
            [BRDatePickerView showDatePickerWithTitle:@"出生日期" dateType:BRDatePickerModeYMD defaultSelValue:[cell.subTextLB.text bb_safe] minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
                cell.subTextLB.text = selectValue;
                self.aUserInfoItem.bothDate = selectValue;
            } cancelBlock:^{
                
            }];
        }
            break;
        case 5:
        {
            //身份
            BBNotificationSettingListCell *cell = (BBNotificationSettingListCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
#warning pp605 设置身份数组
            NSDictionary *identityDict = [[NSUserDefaults standardUserDefaults] valueForKey:k_bb_saveIdentity];
            NSMutableArray *identifieries = [NSMutableArray array];
            if (identityDict) {
                BBIdentityListResult *result = [BBIdentityListResult mj_objectWithKeyValues:identityDict];
                if (result.code == 0) {
                    for (BBIdentity *identity in result.data) {
                        if (![identifieries containsObject:identity.identityName]) {
                            [identifieries addObject:identity.identityName];
                        }
                    }
                }
            }
            if (identifieries.count == 0) {
                [identifieries addObjectsFromArray:@[
                                                     @"爷爷",
                                                     @"奶奶",
                                                     @"爸爸",
                                                     @"妈妈"
                                                     ]];
            }
        
            [BRStringPickerView showStringPickerWithTitle:@"身份" dataSource:identifieries defaultSelValue:cell.subTextLB.text isAutoSelect:YES themeColor:nil resultBlock:^(id selectValue) {
                cell.subTextLB.text = selectValue;
                self.aUserInfoItem.identity = selectValue;
            } cancelBlock:^{
                
            }];
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - 获取地区数据源
- (NSArray *)getAddressDataSource
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"bbCityList.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *dataSource = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    return dataSource;
}
#pragma mark --- 设置头像
-(void)configureAvatar
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAA = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self takePhoto];
    }];
    
    UIAlertAction *photoAA = [UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self pushTZImagePickerController];
    }];
    
    UIAlertAction *cancelAA = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertC addAction:cameraAA];
    [alertC addAction:photoAA];
    [alertC addAction:cancelAA];
    
    [self presentViewController:alertC animated:YES completion:nil];
    
}
#pragma mark --- 相机
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if ((authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) && iOS7Later) {
        // 无相机权限 做一个友好的提示
        if (iOS8Later) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } else if (authStatus == AVAuthorizationStatusNotDetermined) {
        // fix issue 466, 防止用户首次拍照拒绝授权时相机页黑屏
        if (iOS7Later) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self takePhoto];
                    });
                }
            }];
        } else {
            [self takePhoto];
        }
        // 拍照之前还需要检查相册权限
    } else if ([TZImageManager authorizationStatus] == 2) { // 已被拒绝，没有相册权限，将无法保存拍的照片
        if (iOS8Later) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alert show];
        } else {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    } else if ([TZImageManager authorizationStatus] == 0) { // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            [self takePhoto];
        }];
    } else {
        [self pushImagePickerController];
    }
}

#pragma mark --- 调用相机
- (void)pushImagePickerController {
//    // 提前定位
//    __weak typeof(self) weakSelf = self;
//    [[TZLocationManager manager] startLocationWithSuccessBlock:^(NSArray<CLLocation *> *locations) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.location = [locations firstObject];
//    } failureBlock:^(NSError *error) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
//        strongSelf.location = nil;
//    }];
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerVc.sourceType = sourceType;
        if(iOS8Later) {
            _imagePickerVc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [self presentViewController:_imagePickerVc animated:YES completion:nil];
    } else {
        NSLog(@"模拟器中无法打开照相机,请在真机中使用");
    }
}
#pragma mark - TZImagePickerController

- (void)pushTZImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    // imagePickerVc.navigationBar.translucent = NO;
    
#pragma mark - 五类个性化设置，这些参数都可以不传，此时会走默认设置
//    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    
//    if (self.maxCountTF.text.integerValue > 1) {
//        // 1.设置目前已经选中的图片数组
//        imagePickerVc.selectedAssets = _selectedAssets; // 目前已经选中的图片数组
//    }
//    imagePickerVc.allowTakePicture = self.showTakePhotoBtnSwitch.isOn; // 在内部显示拍照按钮
    
    // imagePickerVc.photoWidth = 1000;
    
    // 2. Set the appearance
    // 2. 在这里设置imagePickerVc的外观
    // if (iOS7Later) {
    // imagePickerVc.navigationBar.barTintColor = [UIColor greenColor];
    // }
    // imagePickerVc.oKButtonTitleColorDisabled = [UIColor lightGrayColor];
    // imagePickerVc.oKButtonTitleColorNormal = [UIColor greenColor];
    // imagePickerVc.navigationBar.translucent = NO;
    
    // 3. Set allow picking video & photo & originalPhoto or not
    // 3. 设置是否可以选择视频/图片/原图
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = NO; // 是否可以多选视频
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;
    
    // imagePickerVc.minImagesCount = 3;
    // imagePickerVc.alwaysEnableDoneBtn = YES;
    
    // imagePickerVc.minPhotoWidthSelectable = 3000;
    // imagePickerVc.minPhotoHeightSelectable = 2000;
    
    /// 5. Single selection mode, valid when maxImagesCount = 1
    /// 5. 单选模式,maxImagesCount为1时才生效
//    imagePickerVc.maxImagesCount
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    imagePickerVc.needCircleCrop = YES;
    imagePickerVc.circleCropRadius = (_k_w-40)/2;
    // 设置竖屏下的裁剪尺寸
//    NSInteger left = 30;
//    NSInteger widthHeight = self.view.width - 2 * left;
//    NSInteger top = (self.view.height - widthHeight) / 2;
//    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    // 设置横屏下的裁剪尺寸
    // imagePickerVc.cropRectLandscape = CGRectMake((self.view.tz_height - widthHeight) / 2, left, widthHeight, widthHeight);
    /*
     [imagePickerVc setCropViewSettingBlock:^(UIView *cropView) {
     cropView.layer.borderColor = [UIColor redColor].CGColor;
     cropView.layer.borderWidth = 2.0;
     }];*/
    
    //imagePickerVc.allowPreview = NO;
    // 自定义导航栏上的返回按钮
    /*
     [imagePickerVc setNavLeftBarButtonSettingBlock:^(UIButton *leftButton){
     [leftButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
     [leftButton setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
     }];
     imagePickerVc.delegate = self;
     */
    
    // Deprecated, Use statusBarStyle
    // imagePickerVc.isStatusBarDefault = NO;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    
    // 设置首选语言 / Set preferred language
    // imagePickerVc.preferredLanguage = @"zh-Hans";
    
    // 设置languageBundle以使用其它语言 / Set languageBundle to use other language
    // imagePickerVc.languageBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"tz-ru" ofType:@"lproj"]];
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
// 这个照片选择器会自己dismiss，当选择器dismiss的时候，会执行下面的代理方法
// 如果isSelectOriginalPhoto为YES，表明用户选择了原图
// 你可以通过一个asset获得原图，通过这个方法：[[TZImageManager manager] getOriginalPhotoWithAsset:completion:]
// photos数组里的UIImage对象，默认是828像素宽，你可以通过设置photoWidth属性的值来改变它
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    
    BBEditInfoAvatarCell *cell = (BBEditInfoAvatarCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.avatarImgV.image = photos[0];
    
    #pragma mark --- 上传头像(此处注意data是个数组)
    [BBRequestTool bb_requestUploadImageWithImage:photos[0] successBlock:^(EnumServerStatus status, id object) {
        NSLog(@"upload imag success %@",object);
        BBUploadImageResultModel *uploadImgRM = [BBUploadImageResultModel mj_objectWithKeyValues:object];
        if (uploadImgRM.code == 0) {
            self.aUploadImageRD = [uploadImgRM.data firstObject];
            [QMUITips showSucceed:@"头像上传成功,记得保存哦~"];
        }else{
            [QMUITips showError:@"头像上传失败"];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"upload imag error %@",object);
        [QMUITips showError:@"头像上传失败"];
    }];
    
}
// 决定相册显示与否
- (BOOL)isAlbumCanSelect:(NSString *)albumName result:(id)result
{
    return YES;
}

// 决定asset显示与否
- (BOOL)isAssetCanSelect:(id)asset
{
    return YES;
}
-(void)updateBabyName:(UIAlertController *)alertC
{
    NSArray *tfs = alertC.textFields;
    if (tfs.count > 0) {
        UITextField *tf = tfs[0];
        BBNotificationSettingListCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        cell.subTextLB.text = tf.text;
        self.aUserInfoItem.babyName = tf.text;
    }
    
}

-(NSArray<NSString *> *)titles
{
    if (!_titles) {
        _titles = @[@"头像",@"宝宝姓名",@"性别",@"所在地",@"出生日期",@"身份"];
    }
    return _titles;
}

@end
