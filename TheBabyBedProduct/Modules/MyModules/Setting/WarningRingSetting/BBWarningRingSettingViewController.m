//
//  BBWarningRingSettingViewController.m
//  TheBabyBedProduct
//
//  Created by ╰莪呮想好好宠Nǐつ on 2018/3/27.
//  Copyright © 2018年 Wangyongxin. All rights reserved.
//

#import "BBWarningRingSettingViewController.h"
#import "BBWarningRingListCell.h"
#import "UITableView+EasilyMake.h"
#import "UITableViewCell+EasilyMake.h"

@interface BBWarningRingSettingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSNumber *_selecteIndex;
}
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray<NSString *> *ringNames;
@end

@implementation BBWarningRingSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = rgb(247, 249, 251, 1);
    _selecteIndex = @0;
    [self creatTableVUI];
}
-(void)creatTableVUI
{
    self.tableView = [UITableView bb_tableVMakeWithSuperV:self.view frame:self.view.bounds delegate:self bgColor:rgb(247, 249, 251, 1) style:UITableViewStylePlain];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ringNames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BBWarningRingListCell *cell = [BBWarningRingListCell bb_cellMakeWithTableView:tableView];
    if (self.ringNames.count > indexPath.row) {
        BOOL isCurrent = (indexPath.row == [_selecteIndex integerValue]);
        [cell setupCellWithRingName:self.ringNames[indexPath.row] isSelected:isCurrent];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL isCurrent = (indexPath.row == [_selecteIndex integerValue]);
    if (isCurrent) {
        return;
    }
    _selecteIndex = [NSNumber numberWithInteger:indexPath.row];
#warning toDo
    //此处应该还要播放下选中的警告铃声
}

-(NSMutableArray<NSString *> *)ringNames
{
    if (!_ringNames) {
        _ringNames = [NSMutableArray array];
        [_ringNames addObjectsFromArray:@[
                                          @"铃声一",
                                          @"铃声二",
                                          @"铃声三",
                                          @"铃声四",
                                          @"铃声五"
                                          ]];
    }
    return _ringNames;
}

@end
