//
//  WettingThresholdSettingViewController.m
//  TheBabyBedProduct
//
//  Created by Wangyongxin on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "WettingThresholdSettingViewController.h"
#import "ThresholdTableViewCell.h"
#import "ForecastValuesModel.h"
#import "UIImageView+WebCache.h"

#import "TZImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZLocationManager.h"

#import "BBUploadImageResultModel.h"


@interface WettingThresholdSettingViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    NSArray<NSString *> * titleArr;
    NSArray<NSString *> * imageArr;
    NSMutableArray<NSString *> *imgIDs;
    ForecastValuesInfo * forecastValuesinfo;
    
    NSInteger currentImageIndex;
}
@property (nonatomic,strong)ThresholdTableViewCell * thresholdTableViewCell;
@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property(nonatomic,strong) BBUploadImageResultData *aUploadImageRD;
@end

@implementation WettingThresholdSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"预值设定";
    [self addBackItem];

    [self configureView];
    __weak typeof (self) weakSelf = self;
    [self getCryingThresholdValueComplication:^(BOOL isSuccess, ForecastValuesInfo *info) {
        if (isSuccess) {
            self.contentTextField.text = info.maxVal;
            forecastValuesinfo = info;
            [weakSelf.displayTableView reloadData];
        }
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)configureView{
    
    imgIDs = [NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
    self.view.backgroundColor = kUIColorFromRGB(0xF7F9FB);
    self.displayTableView.backgroundColor = kUIColorFromRGB(0xF7F9FB);
    self.contentTextField.delegate = self;
    titleArr = @[@"轻微尿湿图片",@"中度尿湿图片",@"严重尿湿图片",@"干燥图片"];
    imageArr = @[@"babycrying_Icon",@"babycrying_Icon",@"babycrying_Icon",@"babycrying_Icon"];
    
    self.saveButton.layer.cornerRadius = self.saveButton.frame.size.height / 2;
    self.saveButton.clipsToBounds = true;
    
    self.displayTableView.delegate = self;
    self.displayTableView.dataSource = self;
    self.displayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.displayTableView registerNib:[UINib nibWithNibName:NSStringFromClass([ThresholdTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"ThresholdTableViewCell"];
}

- (IBAction)saveButtonClick:(id)sender {
    [self SetWettingThresholdValueComplication:^(BOOL isSuccess) {
        if (isSuccess) {
            [self.navigationController popViewControllerAnimated:true];
        }
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     return  42;
}
                 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
                 
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
                 
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    self.thresholdTableViewCell = [tableView dequeueReusableCellWithIdentifier:@"ThresholdTableViewCell" forIndexPath:indexPath];
    self.thresholdTableViewCell.titleLabel.text = titleArr[indexPath.section];
    switch (indexPath.section) {
        case 0:{
            if (forecastValuesinfo.qw_niao == nil) {
                self.thresholdTableViewCell.diaplayImageView.image = [UIImage imageNamed:imageArr[indexPath.section]];
            }else{
                [self.thresholdTableViewCell.diaplayImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",K_Url_GetImg,forecastValuesinfo.qw_niao]] placeholderImage:nil];
            }
        }
            break;
        case 1:{
            if (forecastValuesinfo.zd_niao == nil) {
                self.thresholdTableViewCell.diaplayImageView.image = [UIImage imageNamed:imageArr[indexPath.section]];
            }else{
                [self.thresholdTableViewCell.diaplayImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",K_Url_GetImg,forecastValuesinfo.zd_niao]] placeholderImage:nil];
            }
        }
            break;
        case 2:{
            if (forecastValuesinfo.zdd_niao == nil) {
                self.thresholdTableViewCell.diaplayImageView.image = [UIImage imageNamed:imageArr[indexPath.section]];
            }else{
                [self.thresholdTableViewCell.diaplayImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",K_Url_GetImg,forecastValuesinfo.zdd_niao]] placeholderImage:nil];
            }
        }
            break;
        case 3:{
            if (forecastValuesinfo.gz_niao == nil) {
                self.thresholdTableViewCell.diaplayImageView.image = [UIImage imageNamed:imageArr[indexPath.section]];
            }else{
                [self.thresholdTableViewCell.diaplayImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",K_Url_GetImg,forecastValuesinfo.gz_niao]] placeholderImage:nil];
            }
        }
            break;
        default:
            break;
    }
    return self.thresholdTableViewCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //设置头像
    [self configureAvatar];
    currentImageIndex = indexPath.section;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = kUIColorFromRGB(0xF7F9FB);
    return view;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:NUM] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [string isEqualToString:filtered];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- 网络请求 ----
//qw_niao  轻微尿湿 图片id   qw_niao  轻微尿湿 图片id  qw_niao  轻微尿湿 图片id  qw_niao  轻微尿湿 图片id
-(void)SetWettingThresholdValueComplication:(void(^)(BOOL isSuccess))finish{
    [BBRequestTool SetThresholdValueDeviceType:@"3" minValue:@"" maxValue:self.contentTextField.text deviceId:BBUserHelpers.deviceId img:imgIDs successBlock:^(EnumServerStatus status, id object) {
        BaseResultModel *resultM = [[BaseResultModel alloc] initWithDictionary:object error:nil];
        if (resultM.code == 0) {
            finish(true);
        }else{
            [QMUITips showWithText:resultM.msg inView:self.view hideAfterDelay:0.5];
            finish(false);
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        finish(false);
    }];
}
-(void)getCryingThresholdValueComplication:(void(^)(BOOL isSuccess,ForecastValuesInfo * info))finish{
    [BBRequestTool GetThresholdValueDeviceType:@"3" deviceId:[BBUser bb_getUser].deviceId successBlock:^(EnumServerStatus status, id object) {
        ForecastValuesModel *resultM = [[ForecastValuesModel alloc] initWithDictionary:object error:nil];
        if (resultM.code == 0) {
            finish(true,resultM.data);
        }else{
            [QMUITips showWithText:resultM.msg inView:self.view hideAfterDelay:0.5];
            finish(false,nil);
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        finish(false,nil);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
    
    ThresholdTableViewCell *cell = (ThresholdTableViewCell *)[self.displayTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:currentImageIndex]];
    cell.diaplayImageView.image = photos[0];
    
#pragma mark --- 上传头像(此处注意data是个数组)
    [BBRequestTool bb_requestUploadImageWithImage:photos[0] successBlock:^(EnumServerStatus status, id object) {
        NSLog(@"upload imag success %@",object);
        BBUploadImageResultModel *uploadImgRM = [BBUploadImageResultModel mj_objectWithKeyValues:object];
        if (uploadImgRM.code == 0) {
            self.aUploadImageRD = [uploadImgRM.data firstObject];
            [imgIDs replaceObjectAtIndex:currentImageIndex withObject:self.aUploadImageRD.imgId];
            [QMUITips showSucceed:@"图片上传成功,记得保存哦~"];
        }else{
            [QMUITips showError:@"图片上传失败"];
        }
    } failureBlock:^(EnumServerStatus status, id object) {
        NSLog(@"upload imag error %@",object);
        [QMUITips showError:@"图片上传失败"];
    }];
}

@end
