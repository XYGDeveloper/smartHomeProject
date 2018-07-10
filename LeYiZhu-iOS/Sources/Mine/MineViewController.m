//
//  MineViewController.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/21.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "MineViewController.h"
#import "CustomCell.h"
#import "UserInfo.h"
#import "ContentIconCell.h"
#import "ColorSpaceCell.h"
#import "LYZMineHeadCell.h"
#import "LoginManager.h"
#import "ChanagePhoneViewController.h"
#import "MixCellsViewController.h"
#import "MyCollectionViewController.h"
#import "YaoQingController.h"
#import "NormalProblemViewController.h"
#import "LYZMyOrderViewController.h"
#import "LoginController.h"
#import "SetViewController.h"
#import "ContactViewController.h"
#import "UserInfo.h"
#import "UIImageView+WebCache.h"
#import "LYZPhoneCall.h"
#import "LYZFeedBackViewController.h"

@interface MineViewController ()<UITableViewDelegate, UITableViewDataSource, CustomCellDelegate>

@property(nonatomic,strong) UserInfo * userInfo;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic ,strong) id data;

@end

@implementation MineViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    [self createDataSource];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"我的";
    [self createTableViewAndRegisterCells];
    [self createDataSource];
    [self.tableView reloadData];
    
}

- (void)createTableViewAndRegisterCells {
    
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - 64 -49)];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    
    [LYZMineHeadCell registerToTableView:self.tableView];
    [ContentIconCell registerToTableView:self.tableView];
    [ColorSpaceCell  registerToTableView:self.tableView];
}
#pragma mark - Data source.

- (void)createDataSource {
    if (!self.adapters) {
         self.adapters = [NSMutableArray array];
    }
    if (self.adapters.count) {
        [self.adapters removeAllObjects];
    }

    [self.adapters addObject:[LYZMineHeadCell dataAdapterWithData: [LoginManager  instance].userInfo cellHeight:LYZMineHeadCell.cellHeight]];
    [self.adapters addObject:[ContentIconCell dataAdapterWithData:@{@"icon" : @"",   @"title" : @"我的订单"}  cellHeight:50.f]];
    [self.adapters addObject:[self lineType:kShortType height:0.5f]];
    [self.adapters addObject:[ContentIconCell dataAdapterWithData:@{@"icon" : @"", @"title" : @"常用入住人"} cellHeight:50.f]];
    [self.adapters addObject:[self lineType:kShortType height:0.5f]];
    [self.adapters addObject:[ContentIconCell dataAdapterWithData:@{@"icon" : @"", @"title" : @"我的收藏"}  cellHeight:50.f]];
    [self.adapters addObject:[self lineType:kShortType height:0.5f]];
    [self.adapters addObject:[ContentIconCell dataAdapterWithData:@{@"icon" : @"", @"title" : @"邀请好友"}  cellHeight:50.f]];
    [self.adapters addObject:[self lineType:kSpace height:20.0f]];
    [self.adapters addObject:[ContentIconCell dataAdapterWithData:@{@"icon" : @"", @"title" : @"常见问题"}  cellHeight:50.f]];
    [self.adapters addObject:[self lineType:kShortType height:0.5f]];
    [self.adapters addObject:[ContentIconCell dataAdapterWithData:@{@"icon" : @"", @"title" : @"意见反馈"}  cellHeight:50.f]];
    [self.adapters addObject:[self lineType:kShortType height:0.5f]];
    [self.adapters addObject:[ContentIconCell dataAdapterWithData:@{@"icon" : @"", @"title" : @"客服电话" ,@"content":CustomerServiceNum}  cellHeight:50.f]];
    [self.adapters addObject:[self lineType:kLongType height:0.5f]];
    [self.adapters addObject:[self lineType:kSpace height:50]];
    [self.tableView reloadData];
    
}

- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {
    
    if (type == kSpace) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : LYZTheme_BackGroundColor} cellHeight:height];
        
    } else if (type == kLongType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor} cellHeight:0.5f];
        
    } else if (type == kShortType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor, @"leftGap" : @(20.f)} cellHeight:0.5f];
        
    } else {
        
        return nil;
    }
}

#pragma mark - UITableView related.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _adapters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellDataAdapter *adapter = _adapters[indexPath.row];
    CustomCell      *cell    = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter         = adapter;
    cell.data                = adapter.data;
    cell.indexPath           = indexPath;
    cell.tableView           = tableView;
    cell.controller           =self;
    cell.delegate            = self;
    [cell loadContent];
     return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
    UINavigationController *nav = self.tabBarController.viewControllers[2];
    if (indexPath.row == 1) {
        
        if ([LoginManager instance].isLogin) {
            LYZMyOrderViewController *vc = [[LYZMyOrderViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:vc animated:YES];
        }else{
            [[LoginManager instance] userLogin:^{
                LYZMyOrderViewController *vc = [[LYZMyOrderViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [nav pushViewController:vc animated:YES];
            }];
        }
        
    }else if (indexPath.row == 3){
        //常用入住人
        if ([LoginManager instance].isLogin) {
            //设置
            ContactViewController *vc = [[ContactViewController alloc] init];
            vc.title = @"常用入住人";
            vc.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:vc animated:YES];
        }else{
            [[LoginManager instance] userLogin:^{
                ContactViewController *vc = [[ContactViewController alloc] init];
                vc.title = @"常用入住人";
                vc.hidesBottomBarWhenPushed = YES;
                [nav pushViewController:vc animated:YES];
            }];
        }
    }else if (indexPath.row == 5){
        if ([LoginManager instance].isLogin) {
            //收藏
            MyCollectionViewController * vc = [[MyCollectionViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [nav pushViewController:vc animated:YES];
        }else{
            [[LoginManager instance] userLogin:^{
                MyCollectionViewController * vc = [[MyCollectionViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [nav pushViewController:vc animated:YES];
            }];
        }
    }else if (indexPath.row == 7){
        //邀请好友
        YaoQingController *vc = [[YaoQingController alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:vc animated:YES];
       
    }else if (indexPath.row == 9){
        NormalProblemViewController *vc = [[NormalProblemViewController alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        [nav pushViewController:vc animated:YES];
    }else if(indexPath.row == 11){
        //意见反馈
        if ([LoginManager instance].appUserID) {
            LYZFeedBackViewController *vc = [[LYZFeedBackViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [[LoginManager instance] userLogin];
        }
       
    }else if(indexPath.row == 13){
        [self phoneCall];
    }
}

-(void)phoneCall{
    [LYZPhoneCall noAlertCallPhoneStr:CustomerServiceNum withVC:self];
}



#pragma mark -- Cells Actions

-(void)toLogin{
     [[LoginManager instance] userLogin];
}

-(void)toPhoneEdit{
    UINavigationController *nav = self.tabBarController.viewControllers[2];
    ChanagePhoneViewController * vc = [[ChanagePhoneViewController alloc]  init];
    vc.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:vc animated:YES];
}

-(void)toSetting{
    
    SetViewController *set = [SetViewController new];
    UINavigationController *nav = self.tabBarController.viewControllers[2];
    set.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:set animated:YES];
    
//    if ([LoginManager instance].isLogin) {
//        //设置
//        SetViewController *set = [SetViewController new];
//        UINavigationController *nav = self.tabBarController.viewControllers[2];
//        set.hidesBottomBarWhenPushed = YES;
//        [nav pushViewController:set animated:YES];
//        
//    }else{
//        [[LoginManager instance] userLogin];
//    }
}

@end
