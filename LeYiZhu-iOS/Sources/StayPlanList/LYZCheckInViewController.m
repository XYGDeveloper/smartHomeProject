//
//  LYZCheckInViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZCheckInViewController.h"
#import "LYZStayCheckInTable.h"
#import "LYZWaitingCheckInViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
#import "LYZRenewViewController.h"
#import "UserStaysModel.h"
#import "LYZChangePswViewController.h"
#import "LoginManager.h"
#import "AppDelegate.h"
#import "Public+JGHUD.h"
#import "CheckInCommentViewController.h"
#import "GCD.h"
#import "GifIndicatorView.h"
#import "PointView.h"
#import "LYZCommentViewController.h"
#import "YQAlertView.h"
@interface LYZCheckInViewController ()<StayCheckInTableDelegate,BaseMessageViewDelegate,YQAlertViewDelegate>

@property (nonatomic, strong) LYZStayCheckInTable *tableView;

@property (nonatomic, strong) LYZWaitingCheckInViewController *waitingVC;

@property (nonatomic, strong) GifIndicatorView *gifView;


@end

@implementation LYZCheckInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.tableView = [[LYZStayCheckInTable alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 40)];
    self.tableView.dataSource = self.dataSource;
    self.tableView.showNext = self.waitingDataSource.count > 0 ? YES:NO;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self addSwipGesuture];
}

-(void)addSwipGesuture{
    UISwipeGestureRecognizer* swipeUpGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(presentView)];
    swipeUpGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeUpGesture];
}

-(void)presentView{
    if(self.waitingDataSource.count > 0) {
        if (!self.waitingVC) {
            self.waitingVC = [[LYZWaitingCheckInViewController alloc] init];
        }
        if (!self.waitingVC.view.superview) {
            [self.waitingVC showInViewController:self];
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
            NSMutableArray *tempWaiting = [NSMutableArray array];
            if (base.userStays.count > 0) {
                for (int i = 0; i <base.userStays.count; i ++) {
                    UserStaysModel *model = base.userStays[i];
                    if (model.status.intValue == 2) {
                        [temp addObject:model];
                    }
                    if (model.status.integerValue == 1) {
                        [tempWaiting addObject:model];
                    }
                }
                self.tableView.showNext = tempWaiting.count > 0 ? YES:NO;
                self.tableView.dataSource = temp[0];
            }
        }
    }];
}


#pragma mark -- CheckInTableDelegate

-(void)shareBtnClicked{
    [self share];
}

-(void)renewBtnClicked:(UserStaysModel *)model{
    
    LYZRenewViewController *vc = [[LYZRenewViewController alloc] init];
    vc.orderNo = model.orderNO;
    vc.orderType = [NSString stringWithFormat:@"%@",model.orderType];
    vc.roomTypeID = model.roomTypeID;
    vc.hidesBottomBarWhenPushed = YES;
    UINavigationController *nav = self.tabBarController.viewControllers[1];
    [nav pushViewController:vc animated:YES];
}

-(void)checkoutBtnClicked:(UserStaysModel *)model{
    [self checkout:model];
}

-(void)openDoorSlider:(UserStaysModel *)model{
    NSString *hotelRoomNumID = model.roomID;
    NSString *orderNO= model.orderNO;
    [self openKeyWithhotelRoomNumID:hotelRoomNumID orderID:orderNO];
}

-(void)sliderBeginChange:(BOOL)isSliding{
    //    _mainScrollView.scrollEnabled = !isSliding;
}

-(void)changePswBtnClick:(UserStaysModel *)model{
    LYLog(@"psw changed");
    LYZChangePswViewController *vc =[[LYZChangePswViewController alloc] init];
    WEAKSELF;
    vc.vercodeCallBack = ^(){
        LYLog(@"enter  correct vercode");
        NSString *appUserID = [LoginManager instance].appUserID;
        [[LYZNetWorkEngine sharedInstance] changePwd:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID  roomID:model.roomID block:^(int event, id object) {
            if (event == 1) {
                [weakSelf requestData];
            }
        }];
    };
    AppDelegate *dele =(AppDelegate *)[UIApplication sharedApplication].delegate;
    [vc showInViewController:dele.rootTab];
}





#pragma mark --Private Method

-(void)share{
    NSArray *preplatform = @[@(UMSocialPlatformType_WechatSession) , @(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone) ,@(UMSocialPlatformType_TencentWb), @(UMSocialPlatformType_Sina),@(UMSocialPlatformType_DingDing),@(UMSocialPlatformType_Douban),@(UMSocialPlatformType_Renren),@( UMSocialPlatformType_YixinSession),@(UMSocialPlatformType_YixinTimeLine),@(UMSocialPlatformType_Linkedin),@(UMSocialPlatformType_Sms),@(UMSocialPlatformType_Email)
                             ];
    [UMSocialUIManager setPreDefinePlatforms:preplatform];
    UMSocialMessageObject *msg = [[UMSocialMessageObject alloc]init];
    msg.title = @"立即下载乐易住APP";
    msg.text = @"与您的好友共享优质入住体验！！！！";
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        LYLog(@"userInfo : %@" , userInfo);
        
        if(platformType == UMSocialPlatformType_WechatSession){
            
        }
        [self shareWebPageToPlatformType:platformType];
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


-(void)checkout:(UserStaysModel *)model{
    
//    YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:response.msg delegate:self buttonTitles:@[@"取消",@"退房"],nil];
//    [alert Show];
    
    NSString *title = [NSString stringWithFormat:@"是否确认退订%@号房",model.roomNum];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:[NSString stringWithFormat:@"你原计划退房日期是:%@，现在距离退房日期还有%d天。如现在退房，你将不可继续居住。如有问题请咨询客服（4009670533）。",model.checkOutDate,[model.remainDays intValue]]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    //添加取消到UIAlertController中
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:cancelAction];
    
    //添加确定到UIAlertController中
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"退房" style:UIAlertActionStyleDefault handler:^(UIAlertAction *  action) {
        //退房
        JGProgressHUD *hud = [Public hudWhenRequest];
        [hud showInView:self.view animated:YES];
        NSString *appUserID = [LoginManager instance].appUserID;
        [[LYZNetWorkEngine sharedInstance] retreatRoom:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID roomID:model.roomID  block:^(int event, id object) {
            [hud dismissAnimated:YES];
            if (event == 1) {
                RetreatRoomResponse *response = (RetreatRoomResponse *)object;
                NSString *point = [NSString stringWithFormat:@"积分 +%@",[((NSDictionary *)response.result) objectForKey:@"points"]] ;
                PointViewMessageObject *messageObject = MakePointViewObject(@"iconIntegral",point , @"主动退房");
                [PointView showAutoHiddenMessageViewInKeyWindowWithMessageObject:messageObject];
                [GCDQueue executeInMainQueue:^{
                    LYZCommentViewController *vc = [[LYZCommentViewController alloc] init];
                    vc.stayModel = model;
                    vc.hidesBottomBarWhenPushed = YES;
                    UINavigationController *nav = self.tabBarController.viewControllers[1];
                    [nav pushViewController:vc animated:YES];
                } afterDelaySecs:0.1];

            }else{
                [Public showJGHUDWhenError:self.view msg:object];
            }
        }];
        
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)openKeyWithhotelRoomNumID:(NSString*)hotelRoomNumID orderID:(NSString*)orderNO{
    
    LYLog(@"openKeyWithhotelRoomNumID");
    LYLog(@"hotelRoomNumID : %@ orderNO : %@" ,hotelRoomNumID , orderNO);
    
//    JGProgressHUD  *hud = [Public hudWhenRequest];
//    [hud showInView:self.view animated:YES];

    [GCDQueue executeInMainQueue:^{
        NSString *path = [[NSBundle mainBundle] pathForResource:@"opendoor" ofType:@"gif"];
        NSData *localData = [NSData dataWithContentsOfFile:path];
        GifIndicatorViewObject *messageObject = MakeGifIndicatorViewObject(localData);
         UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        _gifView                = [[GifIndicatorView alloc] init];
        _gifView.messageObject                     = messageObject;
        _gifView.delegate                          = self;
        _gifView.contentView                       = keyWindow;
        _gifView.tag                               = 99;
        _gifView.autoHiden                         = NO;
        _gifView.contentViewUserInteractionEnabled = YES;
        [_gifView show];
    }];
    
    NSString *appUserID = [LoginManager instance].appUserID;
    [[LYZNetWorkEngine sharedInstance] openKey:VersionCode devicenum:DeviceNum fromtype:FromType roomID:hotelRoomNumID  appUserID:appUserID pactVersion:@""  block:^(int event, id object) {
//        [hud dismissAnimated:YES];
        [_gifView hide];
        if (event == 1) {
            //            OpenKeyResponse *response = (OpenKeyResponse*)object;
            [Public showJGHUDWhenSuccess:self.view msg:@"开锁成功！"];
            //刷新状态
            //            [self requestData];
        }else{
//            NSString *msg = [object description];
            [Public showJGHUDWhenError:self.view msg:@"开锁失败~请重新尝试！"];
        }
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
