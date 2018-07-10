//
//  SetViewController.m
//  LeYiZhu-iOS
//
//  Created by L on 2017/3/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "SetViewController.h"
#import "Masonry.h"
#import "ResetPswViewController.h"
#import "AboutUsViewController.h"
#import "LoginManager.h"
#import "Public+JGHUD.h"
#import "SDImageCache.h"
#import "UIView+SetRect.h"
#import "LYZWKWebViewController.h"

@interface SetViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UITableView *setTableView;
@property (nonatomic,strong)UIButton *exitButton;
@property (nonatomic,assign)float cameNumber;
@property (nonatomic,strong)UILabel *label;
@property (nonatomic, assign) BOOL isLogin;

@end

@implementation SetViewController


- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    _cameNumber = [[SDImageCache sharedImageCache] getSize]/1024/1024.;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.setTableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, kScreenWidth, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    [self.view addSubview:_setTableView];
    self.setTableView.delegate =self;
    self.setTableView.dataSource = self;
    [self.setTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"setTableView"];
    [self.setTableView reloadData];
    _isLogin = NO;
    // Do any additional setup after loading the view.
    if ([LoginManager instance].appUserID.length > 0) {
        _isLogin = YES;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    if (section == 0) {
        return 2;
    }else{
        return _isLogin?1:0;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 50;
    }else{
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setTableView"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor grayColor];
    [IICommons setPersistenceData:@"N" withKey:kAutoOpenDoorKey];
    /*
    BOOL isOpen;
    if ([[IICommons getPersistenceDataWithKey:kAutoOpenDoorKey] isEqualToString:@"Y"]) {
        isOpen = YES;
    }else{
        isOpen = NO;
    }
    if (indexPath.section == 0 &&indexPath.row== 0){
      
        //自动开门
        cell.textLabel.text = @"自动开门";
        cell.accessoryType =UITableViewCellAccessoryNone;
        UIButton *indicatorBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        indicatorBtn.frame = CGRectMake(0, 0, 45, 45);
        indicatorBtn.x = 90;
        indicatorBtn.y = 0;
        [indicatorBtn setImage:[UIImage imageNamed:@"icon_autoOpendoorIndicator"] forState:UIControlStateNormal];
        [indicatorBtn addTarget:self action:@selector(howToAutoOpenDoor:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:indicatorBtn];
        UISwitch *autoOpenSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 45, 23)];
//            autoOpenSwitch.right = SCREEN_WIDTH - 35;
        autoOpenSwitch.centerY = cell.contentView.height/2.0;
        autoOpenSwitch.onTintColor = LYZTheme_paleBrown;
        autoOpenSwitch.tintColor = kLineColor;
        autoOpenSwitch.on = isOpen;
        [autoOpenSwitch addTarget:self action:@selector(switchIsChanged:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = autoOpenSwitch;

    }else
    */
    
        if (indexPath.section == 0 &&indexPath.row == 0){
   
        cell.textLabel.text = @"清除缓存";
        self.label = [[UILabel alloc]init];
        self.label.text = [NSString stringWithFormat:@"%0.2fM",_cameNumber];
        self.label.textColor = [UIColor grayColor];
        [cell.contentView addSubview:_label];
        self.label.textAlignment = NSTextAlignmentRight;
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(cell.contentView);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(40);
            make.right.mas_equalTo(cell.contentView.mas_right).mas_equalTo(0);
        }];
       
    }else if(indexPath.section == 0 &&indexPath.row == 1){
       
        cell.textLabel.text = @"关于我们";
        
    }else{
        if (_isLogin) {
            cell.backgroundColor = [UIColor clearColor];
            cell.accessoryType = UITableViewCellAccessoryNone;
            self.exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [self.exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
            self.exitButton.titleLabel.font = [UIFont systemFontOfSize:20.0f];
            self.exitButton.layer.cornerRadius = 0;
            [self.exitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.exitButton.backgroundColor = LYZTheme_paleBrown;
            [self.exitButton addTarget:self action:@selector(exitLogin:) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:_exitButton];
            [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
            }];
        }else{
            self.exitButton.hidden = YES;
            cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
            cell.backgroundColor = [UIColor clearColor];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
      
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    if ( indexPath.section == 0 && indexPath.row== 0){
//        if (_isLogin) {
//            ChangePhoneStep2ViewController * vc = [[ChangePhoneStep2ViewController alloc]  init];
//            vc.hidesBottomBarWhenPushed = YES;
//            [self.navigationController pushViewController:vc animated:YES];
//        }
//    }else
    if (indexPath.section == 0 &&indexPath.row == 0){
    
            [self clearCache];
    }else if (indexPath.section == 0 && indexPath.row == 1){
      
            AboutUsViewController *us = [AboutUsViewController new];
            us.title = @"关于我们";
            [self.navigationController pushViewController:us animated:YES];
       
    }

}


- (void)exitLogin:(UIButton *)loginOut{

    
    NSString *appUserID = [LoginManager instance].appUserID;
    if(appUserID.length == 0){
        
        [Public showJGHUDWhenError:self.view msg:@"还没有登录！"];
        return;
    }
    
    [[LoginManager instance] logoutWithblock:^(int event, id object) {
        if (event == 1) {
            JGProgressHUD *hud =  [Public hudWhenSuccessWithMsg:@"注销成功！"] ;
            [hud showInView:self.view animated:YES];
            [hud dismissAfterDelay:1.0f];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }else{
            JGProgressHUD *hud =  [Public hudWhenSuccessWithMsg:@"注销失败！"] ;
            [hud showInView:self.view animated:YES];
            [hud dismissAfterDelay:1.5f];
        }
    }];
   
//    [[LYZNetWorkEngine sharedInstance] userLogoutAppUserID:appUserID versioncode:VersionCode devicenum:DeviceNum fromtype:FromType block:^(int event, id object) {
//        if(event == 1){
//            JGProgressHUD *hud =  [Public hudWhenSuccessWithMsg:@"注销成功！"] ;
//            [hud showInView:self.view animated:YES];
//            [hud dismissAfterDelay:1.0f];
//            [[LoginManager instance] logout];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController popViewControllerAnimated:YES];
//            });
//        }else{
//            JGProgressHUD *hud =  [Public hudWhenSuccessWithMsg:@"注销失败！"] ;
//            [hud showInView:self.view animated:YES];
//            [hud dismissAfterDelay:1.5f];
//        }
//        
//    }];

}

- (void)clearCache{

    
    _cameNumber = 0;
    
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        
        JGProgressHUD *hud =  [Public hudWhenSuccessWithMsg:@"已清空缓存"] ;
        [hud showInView:self.view animated:YES];
        [hud dismissAfterDelay:1.5f];
        
          [self.setTableView reloadData];
    }];
    
    self.label.text = [NSString stringWithFormat:@"%0.2fM",_cameNumber];

    [self.setTableView reloadData];

   
}

-(void)howToAutoOpenDoor:(UIButton *)sender{
    LYLog(@"Indicator Btn Clicked");
    LYZWKWebViewController *vc = [[LYZWKWebViewController alloc] init];
    vc.strURL = AutoOpenDoorGuid;
    vc.title = @"无钥匙开锁指南";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


//-(void)switchIsChanged:(UISwitch *)sender{
//
//    if ([sender isOn]){
//        NSLog(@"The switch is turned on.");
//        [IICommons setPersistenceData:@"Y" withKey:kAutoOpenDoorKey];
//    } else {
//        NSLog(@"The switch is turned off.");
//        [IICommons setPersistenceData:@"N" withKey:kAutoOpenDoorKey];
//    }
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
