//
//  MixCellsViewController.m
//  Animations
//
//  Created by YouXianMing on 2016/11/24.
//  Copyright © 2016年 YouXianMing. All rights reserved.
//

#import "MixCellsViewController.h"

#import "HeaderIconCell.h"
#import "ContentIconCell.h"
#import "ColorSpaceCell.h"

#import "LoginManager.h"
#import "ChanagePhoneViewController.h"
#import "ResetPswViewController.h"
#import "ContactsViewController.h"
#import "AboutUsViewController.h"
#import "Public+JGHUD.h"
#import "User.h"
//test
#import "LYZOrderCommitViewController.h"

//typedef enum : NSUInteger {
//    
//    kSpace = 1000,
//    kLongType,
//    kShortType,
//    
//} ELineTypeValue;

@interface MixCellsViewController () <UITableViewDelegate, UITableViewDataSource, CustomCellDelegate> {

    HeaderIconCell *_headerCell;
}

@property(nonatomic,strong) User * userInfo;

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;

@end

@implementation MixCellsViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
     [self  getUserData];
   
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"设置";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f4f4f4"];
    
    [self setup];
    
}

-(void)getUserData{
    self.userInfo =  [LoginManager  instance].userInfo;
     [_tableView reloadData];
}


- (void)setup {

    [self createTableViewAndRegisterCells];
    
    UILabel * versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 10- 20, SCREEN_WIDTH, 20)];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    versionLabel.font = [UIFont systemFontOfSize:13];
    versionLabel.textColor = [UIColor colorWithRed:193/255.0 green:194/255.0 blue:195/255.0 alpha:1.0];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    versionLabel.text = [NSString stringWithFormat:@"版本 V%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]];
    [self.view addSubview:versionLabel];
    
    [self createDataSource];
    
}

#pragma mark - Data source.

- (void)createDataSource {

    self.adapters = [NSMutableArray array];
    
    [self.adapters addObject:[HeaderIconCell dataAdapterWithData: [LoginManager  instance].userInfo cellHeight:HeaderIconCell.cellHeight]];
    [self.adapters addObject:[self lineType:kSpace height:20.f]];
    [self.tableView reloadData];
    
    [UIView animateWithDuration:0.75f animations:^{
        
        self.tableView.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        
        [self.adapters addObject:[self lineType:kLongType height:0.5f]];
        [self.adapters addObject:[ContentIconCell dataAdapterWithData:@{@"icon" : @"signlist_new",   @"title" : @"修改密码"}  cellHeight:50.f]];
        
        [self.adapters addObject:[self lineType:kShortType height:0.5f]];
        [self.adapters addObject:[ContentIconCell dataAdapterWithData:@{@"icon" : @"collection_new", @"title" : @"常用旅客"} cellHeight:50.f]];
        
        [self.adapters addObject:[self lineType:kShortType height:0.5f]];
        [self.adapters addObject:[ContentIconCell dataAdapterWithData:@{@"icon" : @"drawer_setting", @"title" : @"清除缓存"}        cellHeight:50.f]];
         [self.adapters addObject:[self lineType:kShortType height:0.5f]];
         [self.adapters addObject:[ContentIconCell dataAdapterWithData:@{@"icon" : @"drawer_setting", @"title" : @"关于"}        cellHeight:50.f]];
        [self.adapters addObject:[self lineType:kShortType height:0.5f]];
        [self.adapters addObject:[ContentIconCell dataAdapterWithData:@{@"icon" : @"drawer_setting", @"title" : @"注销"}        cellHeight:50.f]];
        [self.adapters addObject:[self lineType:kLongType height:0.5f]];
        
        NSMutableArray *indexPaths = [NSMutableArray array];
        [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
        }];
        [indexPaths removeObjectsInRange:NSMakeRange(0, 2)];
        [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }];
}

- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {

    if (type == kSpace) {
    
        return [ColorSpaceCell dataAdapterWithData:nil cellHeight:15.f];
        
    } else if (type == kLongType) {
    
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :[UIColor colorWithHexString:@"E8E8E8"]} cellHeight:0.5f];
        
    } else if (type == kShortType) {
    
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" : [UIColor colorWithHexString:@"E8E8E8"], @"leftGap" : @(50.f)} cellHeight:0.5f];
        
    } else {
    
        return nil;
    }
}

#pragma mark - UITableView related.

- (void)createTableViewAndRegisterCells {

    self.tableView                 = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.alpha           = 0.f;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [HeaderIconCell  registerToTableView:self.tableView];
    [ContentIconCell registerToTableView:self.tableView];
    [ColorSpaceCell  registerToTableView:self.tableView];
}

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
    cell.delegate            = self;
    [cell loadContent];
    WEAKSELF;
    if (_headerCell == nil && [cell isKindOfClass:[HeaderIconCell class]]) {
        _headerCell = (HeaderIconCell *)cell;
    }
    
    if ([cell isKindOfClass:[HeaderIconCell class]]) {
        HeaderIconCell * headCell = (HeaderIconCell *)cell;
        headCell.buttonTappedHandler =^(){
            
            ChanagePhoneViewController * vc = [[ChanagePhoneViewController alloc]  init];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
    if (indexPath.row == 3) {
        ResetPswViewController * vc = [[ResetPswViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 5){
        ContactsViewController *vc = [[ContactsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 7){
        LYZOrderCommitViewController *vc = [[LYZOrderCommitViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 9){
        AboutUsViewController *vc = [[AboutUsViewController alloc] initWithNibName:@"AboutUsViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }else if(indexPath.row == 11){
        NSString *appUserID = [LoginManager instance].appUserID;
        if(appUserID.length == 0){
            [Public showJGHUDWhenError:self.view msg:@"还没有登录！"];
            return;
        }
        
        NSString *userID = [LoginManager instance].appUserID;
        
        [[LoginManager  instance] logoutWithblock:^(int event, id object) {
            if (event == 1) {
                JGProgressHUD *hud =  [Public hudWhenSuccessWithMsg:@"注销成功！"] ;
                [hud showInView:self.view animated:YES];
                [hud dismissAfterDelay:1.5f];
            }else{
                JGProgressHUD *hud =  [Public hudWhenSuccessWithMsg:@"注销失败！"] ;
                [hud showInView:self.view animated:YES];
                [hud dismissAfterDelay:1.5f];
            }
        }];
        
//        [[LYZNetWorkEngine sharedInstance] userLogoutAppUserID:userID versioncode:VersionCode devicenum:DeviceNum fromtype:FromType block:^(int event, id object) {
//            if(event == 1){
//                JGProgressHUD *hud =  [Public hudWhenSuccessWithMsg:@"注销成功！"] ;
//                [hud showInView:self.view animated:YES];
//                [hud dismissAfterDelay:1.5f];
//                [[LoginManager instance] logout];
//                
//            }else{
//                JGProgressHUD *hud =  [Public hudWhenSuccessWithMsg:@"注销失败！"] ;
//                [hud showInView:self.view animated:YES];
//                [hud dismissAfterDelay:1.5f];
//            }
//        }];

    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    [_headerCell offsetY:scrollView.contentOffset.y];
}



#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {

    LYLog(@"%@", event);
}


@end
