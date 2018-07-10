//
//  LYZWaitingCheckInViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZWaitingCheckInViewController.h"
#import "LYZStayWaitingCheckInTable.h"
#import "LoginManager.h"
#import "UserStaysModel.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "LYZHotelViewController.h"
#import "HotelMapViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import "Public+JGHUD.h"
#import "LYZWKWebViewController.h"
#import "GCD.h"

@interface LYZWaitingCheckInViewController ()<UIScrollViewDelegate,StayWaitingTableDelegate,CAAnimationDelegate>

@property (nonatomic,strong) LYZStayWaitingCheckInTable *tableView;
@property (nonatomic,strong)  UIScrollView *mainScrollView;

@end

@implementation LYZWaitingCheckInViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    [self configScrollView];
    [self addSwipGesuture];

}

-(void)addSwipGesuture{
    UISwipeGestureRecognizer* swipeDownGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dissMissView)];
    swipeDownGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeDownGesture];
}

-(void)dissMissView{
    if (self.canDisMiss) {
        if (self.view.superview) {
            [self disMiss];
        }
    }
}

-(void)requestData{
    NSString *appUserID = [LoginManager instance].appUserID;
    [[LYZNetWorkEngine sharedInstance] getStayList:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID limit:nil pages:nil block:^(int event, id object){
            if (event == 1) {
                NSLog(@"ruzhurenxinxi%@",object);
                StayListResponse *response = (StayListResponse *)object;
                BaseUserStays *base = response.baseStays;
                NSMutableArray *temp = [NSMutableArray array];
                if (base.userStays.count > 0) {
                    for (int i = 0; i <base.userStays.count; i ++) {
                        UserStaysModel *model = base.userStays[i];
                        if (model.status.intValue == 1) {
                            [temp addObject:model];
                        }
                        if (model.status.intValue == 2) {
                            self.canDisMiss = YES;
                        }
                    }
                    if (temp.count > 0) {
                        [GCDQueue executeInMainQueue:^{
                             [self configTableviews:[NSArray arrayWithArray:temp]];
                        }];
                       
                    }
                }
            }
    }];
}




-(void)configScrollView{
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49)];
    self.mainScrollView.pagingEnabled = YES;
    self.mainScrollView.autoresizingMask = YES;
    self.mainScrollView.clipsToBounds = NO;
    self.mainScrollView.showsVerticalScrollIndicator = NO;
    self.mainScrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView.delegate = self;
    self.mainScrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mainScrollView];
}

-(void)configTableviews:(NSArray *)data{
//    if (_mainScrollView.subviews) {
//        for (UIView *view in _mainScrollView.subviews) {
//            [view removeFromSuperview];
//        }
//    }
    
    [_mainScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //配置scrollviewContentSize
    _mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, (SCREEN_HEIGHT - 64 - 49  )*data.count);
    //配置tableview
    for (int i = 0; i <data.count; i ++) {
        UserStaysModel *model = data[i];
        LYZStayWaitingCheckInTable *table = [[LYZStayWaitingCheckInTable alloc] initWithFrame:CGRectMake(0,  i*(SCREEN_HEIGHT - 64 -49), SCREEN_WIDTH, SCREEN_HEIGHT - 64 -49)];
        table.delegate = self;
        table.dataSource = model;
//        table.showUp = self.canDisMiss ? YES:NO;
        table.showUp = self.canDisMiss;
        table.showNext = YES;

        if (i == data.count - 1) {
            table.showNext = NO;
            
        }
        [self.mainScrollView addSubview:table];
    }
}

- (void)showInViewController:(UIViewController *)vc{
    if (vc) {
        [vc addChildViewController:self];
        [vc.view addSubview:self.view];
        [self show];
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
}

-(void)show{
    [self addKeyAnimation];
}

- (void)addKeyAnimation {
    CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAnima.duration = 0.8;
    positionAnima.fromValue = @(SCREEN_HEIGHT + self.view.center.y);
    positionAnima.toValue = @(self.view.center.y);
    positionAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    positionAnima.repeatCount = 0;
//    positionAnima.repeatDuration = 2;
    positionAnima.fillMode = kCAFillModeForwards;
    positionAnima.removedOnCompletion = NO;
    [self.view.layer addAnimation:positionAnima forKey:@"AnimationMoveY"];
}

-(void)addDisMissAnmation{
    CABasicAnimation *positionAnima = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionAnima.duration = 0.8;
    positionAnima.toValue = @(SCREEN_HEIGHT + self.view.center.y);
    positionAnima.fromValue = @(self.view.center.y);
    positionAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    positionAnima.repeatCount = 0;
    [positionAnima setDelegate:self];//代理回调
    //    positionAnima.repeatDuration = 2;
    positionAnima.fillMode = kCAFillModeForwards;
    positionAnima.removedOnCompletion = NO;
    [self.view.layer addAnimation:positionAnima forKey:@"AnimationDisMissY"];
}

- (void)disMiss {
    [self addDisMissAnmation];
}

- (void)animationDidStart:(CAAnimation *)anim{
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (flag) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        
    }
}


#pragma mark -- UIScrollView Delegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat  offset = scrollView.contentOffset.y;
    if (offset < -20) {
        [self dissMissView];
    }
}


#pragma mark -- WaitingCheckInTableDelegate

-(void)tableClickAtIndex:(NSInteger)index withDataSource:(UserStaysModel *)dataSource{
    if (index == 2) {
        //跳酒店
        LYZHotelViewController *vc = [[LYZHotelViewController alloc] init];
        vc.i_hotelId = dataSource.hotelID;
        vc.i_latidute = dataSource.latitude;
        vc.i_longitude = dataSource.longitude;
        vc.title = dataSource.hotelName;
        vc.hidesBottomBarWhenPushed = YES;
        UINavigationController *nav = self.tabBarController.viewControllers[1];
        [nav pushViewController:vc animated:YES];
    }else if (index == 4){
        //跳导航
        HotelMapViewController *vc = [[HotelMapViewController alloc] init];
        vc.ilatidute = dataSource.latitude;
        vc.ilongitude = dataSource.longitude;
        vc.address = dataSource.address;
        vc.hotelName = dataSource.hotelName;
        vc.hidesBottomBarWhenPushed = YES;
        UINavigationController *nav = self.tabBarController.viewControllers[1];
        [nav pushViewController:vc animated:YES];
    }else if (index == 8){
        //跳入住指南
        //入住指南
        LYZWKWebViewController *vc = [[LYZWKWebViewController alloc] init];
        vc.strURL = GuidLink;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (index == 9){
        //分享
        [self share];
    }
}


-(void)share{
    NSArray *preplatform = @[@(UMSocialPlatformType_WechatSession) , @(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone) ,@(UMSocialPlatformType_TencentWb), @(UMSocialPlatformType_Sina),@(UMSocialPlatformType_DingDing),@(UMSocialPlatformType_Douban),@(UMSocialPlatformType_Renren),@( UMSocialPlatformType_YixinSession),@(UMSocialPlatformType_YixinTimeLine),@(UMSocialPlatformType_Linkedin),@(UMSocialPlatformType_Sms),@(UMSocialPlatformType_Email)
                             ];
    [UMSocialUIManager setPreDefinePlatforms:preplatform];
    UMSocialMessageObject *msg = [[UMSocialMessageObject alloc]init];
    msg.title = @"立即下载乐易住APP";
    msg.text = @"与您的好友共享优质入住体验！！！！";
    WEAKSELF;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        LYLog(@"userInfo : %@" , userInfo);
        
        if(platformType == UMSocialPlatformType_WechatSession){
            
        }
        [weakSelf shareWebPageToPlatformType:platformType];
    }];
}

//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    //    NSString* thumbURL =  @"https://www.baidu.com";
    NSString* thumbURL = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"立即下载乐易住APP" descr:@"与您的好友共享优质入住体验！！！" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = InviteFriend;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
            [Public showJGHUDWhenError:self.view msg:@"分享失败！"];
        }else{
            [Public showJGHUDWhenSuccess:self.view msg:@"分享成功！"];
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        //        [self alertWithError:error];
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    LYLog(@"dealloc");
    self.tableView.delegate = nil;
    self.tableView = nil;
}

@end
