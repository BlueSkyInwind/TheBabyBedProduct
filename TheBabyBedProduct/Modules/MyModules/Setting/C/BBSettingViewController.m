//
//  BBSettingViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/25.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBSettingViewController.h"
#import "BBMyListCell.h"
#import "BBMyListSubTitleCell.h"
#import "BBMyListOnlySubtitleCell.h"
#import "BBUser.h"
#import "BBNotificationSettingViewController.h"
#import "BBAboutUsViewController.h"
#import "BBAccountNumberViewController.h"

@interface BBSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *tableView;
@end

@implementation BBSettingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = k_color_vcBg;
    self.title = @"设置";
    [self creatUI];
    
}
-(void)creatUI
{
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:self.view.bounds delegate:self bgColor:k_color_vcBg style:UITableViewStylePlain];
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (!BBUserHelpers.hasLogined && section == 1){
        return 200;
    }
    return 0.001;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (!BBUserHelpers.hasLogined && section == 1) {
        UIView *foterV = [[UIView alloc]initWithFrame:CGRectFlatMake(0, 50, _k_w, 200)];
        foterV.backgroundColor = [UIColor clearColor];
        return foterV;
    }
    return [UIView new];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    }
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _k_w, 10)];
    v.backgroundColor = [UIColor clearColor];
    return v;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BBMyListCell *cell = [BBMyListCell bb_cellMakeWithTableView:tableView];
            [cell setupCellWithImgName:@"setmine" title:@"账户信息"];
            return cell;
        }else{
            BBMyListOnlySubtitleCell *cell = [BBMyListOnlySubtitleCell bb_cellMakeWithTableView:tableView];
            [cell setupCellWithImgName:@"setupgrade" title:@"固件升级" subTitle:@"检测"];
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            BBMyListCell *cell = [BBMyListCell bb_cellMakeWithTableView:tableView];
            [cell setupCellWithImgName:@"setinform" title:@"通知设置"];
            return cell;
        }else if (indexPath.row == 1){
            BBMyListSubTitleCell *cell = [BBMyListSubTitleCell bb_cellMakeWithTableView:tableView];
            [cell setupCellWithImgName:@"setsweep" title:@"清理缓存" subTitle:[self getFolderSize]];
            return cell;
        }else{
            BBMyListCell *cell = [BBMyListCell bb_cellMakeWithTableView:tableView];
            [cell setupCellWithImgName:@"setmine" title:@"关于我们"];
            return cell;
        }
    }
}
// 缓存大小
- (NSString *)getFolderSize{
    
    CGFloat folderSize = 0.0;
    
    //获取路径
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)firstObject];
    
    //获取所有文件的数组
    NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",files.count);
    
    for(NSString *path in files) {
        
        NSString*filePath = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",path]];
        
        //累加
        folderSize += [[NSFileManager defaultManager]attributesOfItemAtPath:filePath error:nil].fileSize;
    }
    //转换为M为单位
    CGFloat sizeM = folderSize /1024.0/1024.0;
    
    return [NSString stringWithFormat:@"%.2fMB",sizeM];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        //账户设置
        if (indexPath.row == 0) {
            if (BBUserHelpers.hasLogined) {
                BBAccountNumberViewController *accountNumberVC = [[BBAccountNumberViewController alloc]init];
                [self.navigationController pushViewController:accountNumberVC animated:YES];
            }else{
                [self goLoginRegistVc];
            }
        }
    }else{
        if (indexPath.row == 0) {
            if (BBUserHelpers.hasLogined) {
                BBNotificationSettingViewController *notificationSettingVC = [[BBNotificationSettingViewController alloc]init];
                [self.navigationController pushViewController:notificationSettingVC animated:YES];
            }else{
                [self goLoginRegistVc];
            }
        }else if (indexPath.row == 1){
            BBMyListSubTitleCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
            if ([cell.subTitle isEqualToString:@"0.00MB"]) {
                [QMUITips showWithText:@"没有缓存可清除" inView:self.view hideAfterDelay:1.5];
                return;
            }else{
                //清理缓存
                [self removeCache];
            }
            
        }else if (indexPath.row == 2){
            BBAboutUsViewController *aboutUsVC = [[BBAboutUsViewController alloc]init];
            [self.navigationController pushViewController:aboutUsVC animated:YES];
        }
    }
    
}

- (void)removeCache
{
    //===============清除缓存==============
    //获取路径
    NSString*cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES)objectAtIndex:0];
    
    //返回路径中的文件数组
    NSArray*files = [[NSFileManager defaultManager]subpathsAtPath:cachePath];
    
    NSLog(@"文件数：%ld",[files count]);
    for(NSString *p in files){
        NSError*error;
        
        NSString*path = [cachePath stringByAppendingString:[NSString stringWithFormat:@"/%@",p]];
        
        if([[NSFileManager defaultManager]fileExistsAtPath:path])
        {
            BOOL isRemove = [[NSFileManager defaultManager]removeItemAtPath:path error:&error];
            if(isRemove) {
                NSLog(@"清除成功");
                //这里发送一个通知给外界，外界接收通知，可以做一些操作（比如UIAlertViewController）
                [QMUITips showWithText:@"缓存清理成功" inView:self.view hideAfterDelay:1.5];
                BBMyListSubTitleCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
                [cell setupCellWithImgName:@"setsweep" title:@"清理缓存" subTitle:@"0.00MB"];

            }else{
                [QMUITips showWithText:@"清除失败" inView:self.view hideAfterDelay:1.5];
            }
        }
    }
}


@end
