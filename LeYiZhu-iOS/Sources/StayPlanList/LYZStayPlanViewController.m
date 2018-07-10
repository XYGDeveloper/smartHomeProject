//
//  LYZStayPlanViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/5.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZStayPlanViewController.h"
#import "MJRefresh.h"
#import "ColorSpaceCell.h"
#import "CustomCell.h"
#import "LoginManager.h"

#import "UserStaysModel.h"
#import "LYZStayWaitingCheckInTable.h"
#import "LYZStayCheckInTable.h"

#import "LYZHotelViewController.h"
#import "HotelMapViewController.h"

#import "Public+JGHUD.h"
#import "LYZOrderCommitRoomInfoModel.h"
#import "NSDate+Utilities.h"
#import "CheckInCommentViewController.h"
#import "LYZNoPlanView.h"
#import "NoPlanView.h"

#import "LYZRenewViewController.h"
#import "AlertView.h"
#import "LYZPhoneCall.h"
#import "LYZWKWebViewController.h"
#import "LYZChangePswViewController.h"
#import <Reachability.h>
#import "GCDQueue.h"
#import "Public.h"
#import "LYZWaitingCheckInViewController.h"
#import "LYZCheckInViewController.h"
#import "UIViewController+BarButton.h"


@interface LYZStayPlanViewController ()<UIScrollViewDelegate,CustomCellDelegate,StayWaitingTableDelegate,StayCheckInTableDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic ,strong) NSMutableArray *tableArrs;
@property (nonatomic , strong) LYZNoPlanView *PlanView;
@property (nonatomic , strong) NoPlanView *noPlanView;

@property (nonatomic, strong)  LYZCheckInViewController *checkInVC;
@property (nonatomic, strong) LYZWaitingCheckInViewController *waitingVC;
//@property (nonatomic ,strong) UIViewController *currentVC;

@property (nonatomic, strong) NSArray *waitingCheckInDataSource;
@property (nonatomic, strong) NSArray *checkInDataSource;
@property (nonatomic, strong) Reachability *reach;
@end

static int viewTag = 0x11;

@implementation LYZStayPlanViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    [self requestData];
    [self NetWorkMonitor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"入住";
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    [self configUI];
//     [self requestData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:kNotificationStayPlanList object:nil];
    
}

-(void)refresh{
    [self requestData];
}
- (void)NetWorkMonitor{
    weakify(self);
    self.reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    self.reach .unreachableBlock = ^(Reachability * reachability){
        [GCDQueue executeInMainQueue:^{
            strongify(self);
            [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
            [[EmptyManager sharedManager] showEmptyOnView:self.view withImage:[UIImage imageNamed:@"network"] explain:@"当前网络没有连接，请检查网络" operationText:nil operationBlock:nil];
        }];
    };
    self.reach.reachableBlock = ^(Reachability *reachability) {
        strongify(self);
         [GCDQueue executeInMainQueue:^{
             [[EmptyManager sharedManager] removeEmptyFromView:self.view];
             [self requestData];
         }];
    };
    [self.reach  startNotifier];
}

-(void)configUI{
    [self setupNav];
}


-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationStayPlanList object:nil];
    LYLog(@"dealloc");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --Data Source

-(void)requestData{
    NSString *appUserID = [LoginManager instance].appUserID;
    if (appUserID.length <= 0) {
       //空白页
        [self configLYZNoPlanView];
    }else{
        if (self.PlanView.superview) {
            [self.PlanView removeFromSuperview];
        }
        [[LYZNetWorkEngine sharedInstance] getStayList:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID limit:nil pages:nil block:^(int event, id object){
            if (event == 1) {
                NSLog(@"ruzhurenxinxi%@",object);
                StayListResponse *response = (StayListResponse *)object;
                BaseUserStays *base = response.baseStays;
                NSMutableArray *temp = [NSMutableArray array];
                if (base.userStays.count > 0) {
                    for (int i = 0; i <base.userStays.count; i ++) {
                        UserStaysModel *model = base.userStays[i];
                        if (model.status.intValue != 3) {
                            [temp addObject:model];
                        }
                    }
                    if (temp.count > 0) {
                        [self configTableviews:[NSArray arrayWithArray:temp]];
                    }else{
                         [self configNoPlanView];
                    }
                }
            }else if(event == 2){
                [self configNoPlanView];
                [self configTableviews:nil];
            }else{
                
            }
        }];
    }
}

-(void)configTableviews:(NSArray *)data{
    if (self.checkInVC && self.checkInVC.view.superview) {
        [self.checkInVC willMoveToParentViewController:nil];
        [self.checkInVC removeFromParentViewController];
         [self.checkInVC.view removeFromSuperview];
    }
    if (self.waitingVC && self.waitingVC.view.superview) {
        [self.waitingVC willMoveToParentViewController:nil];
        [self.waitingVC removeFromParentViewController];
         [self.waitingVC.view removeFromSuperview];
    }
    if (data.count == 0) {
        return;
    }

    NSMutableArray *temp_waiting = [NSMutableArray array];
    NSMutableArray *temp_checkIn = [NSMutableArray array];
    for (int i = 0; i <data.count; i ++) {
        UserStaysModel *model = data[i];
        if (model.status.integerValue == 2) {
            [temp_checkIn  addObject:model];
        }else if (model.status.integerValue == 1){
            [temp_waiting addObject:model];
        }
    }
    self.waitingCheckInDataSource = [NSArray arrayWithArray:temp_waiting];
    self.checkInDataSource = [NSArray arrayWithArray:temp_checkIn];
    if (self.checkInDataSource.count > 0) {
        self.checkInVC = [[LYZCheckInViewController alloc] init];
        self.checkInVC.dataSource = [self.checkInDataSource firstObject];
        self.checkInVC.waitingDataSource = self.waitingCheckInDataSource;
        [self addChildViewController:self.checkInVC];
//        [self.checkInVC didMoveToParentViewController:self];
        [self.view addSubview:self.checkInVC.view];
    }
    if (self.checkInDataSource.count == 0 && self.waitingCheckInDataSource.count > 0) {
        if (!self.waitingVC) {
            self.waitingVC = [[LYZWaitingCheckInViewController alloc] init];
        }
//        self.waitingVC.canDisMiss = self.checkInDataSource.count > 0 ? YES:NO;
        [self addChildViewController:self.waitingVC];
//        [self.waitingVC didMoveToParentViewController:self];
        [self.view addSubview:self.waitingVC.view];
    }
}

#pragma mark --UI Config

-(void)setupNav{
    
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    rightButton.bounds = CGRectMake(0, 0, 60, 30);
//     UIImage * image = [[UIImage imageNamed:@"icon_phone_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [rightButton setImage:image forState:UIControlStateNormal];
//
//    [rightButton addTarget:self action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceItem.width = - 20;
//    self.navigationItem.rightBarButtonItems = @[spaceItem,rightItem];
//
//    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    leftBtn.bounds = CGRectMake(0, 0, 60, 30);
//    [leftBtn setImage:[UIImage imageNamed:@"guid"] forState:UIControlStateNormal];
//    [leftBtn addTarget:self action:@selector(liveGuidBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    self.navigationItem.leftBarButtonItems = @[spaceItem, leftBtnItem];
    UIImage *image_guid = [[UIImage imageNamed:@"guid"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addLeftBarButtonWithImage:image_guid action:@selector(liveGuidBtnClick:)];
    
     UIImage * image = [[UIImage imageNamed:@"icon_phone_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addRightBarButtonWithFirstImage:image action:@selector(phoneBtnClick:)];
    
    
}

-(void)configLYZNoPlanView{
    
    _PlanView = [[LYZNoPlanView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _PlanView.orderBtnHandler = ^(){
        [[LoginManager instance] userLogin];
    };
    [self.view addSubview:_PlanView];
}

-(void)configNoPlanView{
    _noPlanView = [[NoPlanView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    WEAKSELF;
    _noPlanView.orderBtnHandler = ^(){
        [weakSelf.tabBarController setSelectedViewController:weakSelf.tabBarController.viewControllers[0]];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationShowSearch object:nil];
    };
    [self.view addSubview:_noPlanView];
}

#pragma mark - Btn Actions

-(void)phoneBtnClick:(id)sender{
    [LYZPhoneCall noAlertCallPhoneStr:CustomerServiceNum withVC:self];
}

-(void)liveGuidBtnClick:(id)sender{
    //入住指南
    LYZWKWebViewController *vc = [[LYZWKWebViewController alloc] init];
    vc.strURL = GuidLink;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
