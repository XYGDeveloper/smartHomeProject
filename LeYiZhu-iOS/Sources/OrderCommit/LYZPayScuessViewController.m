//
//  LYZPayScuessViewController.m
//  LeYiZhu-iOS
//
//  Created by L on 2017/4/5.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZPayScuessViewController.h"
#import "HotelMapViewController.h"
#import "LYZOrderFormViewController.h"
#import "BaseOrderDetailModel.h"
#import "LYZPhoneCall.h"
#import "LoginManager.h"
#import "AppDelegate.h"
#import "UIView+SetRect.h"
#import "User.h"

@interface LYZPayScuessViewController ()

@property (weak, nonatomic) IBOutlet UIView *bottomLine;     //底部分割线

@property (weak, nonatomic) IBOutlet UILabel *NoticeContent; //注意内容

@property (weak, nonatomic) IBOutlet UILabel *hotelName;     //酒店名称

@property (weak, nonatomic) IBOutlet UILabel *HotelAddress;  //酒店地址

@property (weak, nonatomic) IBOutlet UIButton *ScanOrder;    //查看订单

@property (weak, nonatomic) IBOutlet UIButton *ArriveHotel;  //前往酒店

@property (nonatomic, strong) BaseOrderDetailModel *baseOrderDetail;

@end

@implementation LYZPayScuessViewController

- (void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    //其他UI部分界面配置
    self.bottomLine.backgroundColor = kLineColor;
    self.NoticeContent.font = [UIFont fontWithName:LYZTheme_Font_Medium size:12.0f];
    self.NoticeContent.textColor = LYZTheme_warmGreyFontColor;
    self.ScanOrder.layer.cornerRadius = 4;
    self.ScanOrder.layer.borderWidth = 1;
    self.ScanOrder.layer.borderColor = LYZTheme_paleGreyFontColor.CGColor;
    self.ArriveHotel.layer.cornerRadius = 4;
    self.ArriveHotel.layer.masksToBounds = YES;
    self.navigationItem.hidesBackButton = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark-查看订单

- (IBAction)scanOrderAction:(id)sender {
    [self toDifferentView];
}

-(void)jumpToOrderForm{
    [self.navigationController popToRootViewControllerAnimated:NO];
    AppDelegate *dele = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UITabBarController *tab = (UITabBarController *)dele.rootTab;
    tab.selectedIndex = 0;
    BaseNavController *nav = (BaseNavController *)tab.viewControllers[0];
    LYZOrderFormViewController *orderForm = [LYZOrderFormViewController new];
    orderForm.orderType = self.orderType;
    orderForm.orderNo = self.baseOrderDetail.orderJson.orderNO;
    orderForm.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:orderForm animated:YES];
}

#pragma mark-前往酒店

- (IBAction)ToArriveHotelAction:(id)sender {
    
  
//    [self.navigationController pushViewController:map animated:YES];
    [self.navigationController popToRootViewControllerAnimated:NO];
    AppDelegate *dele = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UITabBarController *tab = (UITabBarController *)dele.rootTab;
    tab.selectedIndex = 0;
    BaseNavController *nav = (BaseNavController *)tab.viewControllers[0];
    HotelMapViewController *map = [HotelMapViewController new];
           //续住订单
    map.ilatidute = self.baseOrderDetail.hotelJson.latitude;
    map.ilongitude = self.baseOrderDetail.hotelJson.longitude;
    map.address = self.baseOrderDetail.hotelJson.address;
    map.hotelName =  self.baseOrderDetail.hotelJson.hotelName;
  
    map.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:map animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付成功";
    [self setLeftNav];
    [self setBackBtn];
    [self getOrderDetail];
}

-(void)getOrderDetail{
    [[LYZNetWorkEngine sharedInstance] getOrderDetailWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType orderNo:self.orderNumber orderType:self.orderType  block:^(int event, id object) {
        if (event == 1) {
            GetOrderDetailResponse *response = (GetOrderDetailResponse *)object;
            LYLog(@"the response is %@",response.baseOrderDetail);
            self.baseOrderDetail = response.baseOrderDetail;
            self.hotelName.text = self.baseOrderDetail.hotelJson.hotelName;
            self.HotelAddress.text = [NSString stringWithFormat:@"酒店地址：%@",self.baseOrderDetail.hotelJson.address];
            [self.HotelAddress sizeToFit];
            self.HotelAddress.centerX = self.view.centerX;
            
        }else{
        }
    }];
}

-(void)setLeftNav{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    rightButton.frame = CGRectMake(0, 0,50, 30);
    
    rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    
    [rightButton setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
    [rightButton setTitleColor:LYZTheme_paleBrown forState:UIControlStateSelected];
    [rightButton setTitle:@"完成" forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(toDifferentView) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = - 10;
    self.navigationItem.rightBarButtonItems = @[spaceItem,rightItem];
    
}

-(void)setBackBtn{
//    UIImage * leftImg = [[UIImage imageNamed:@"icon_returned"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    UIBarButtonItem * leftNavItem = [[UIBarButtonItem alloc] initWithImage:leftImg style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
//    self.navigationItem.leftBarButtonItem = leftNavItem;
//    self.navigationItem.leftBarButtonItem = nil;
}


-(void)back:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.tabBarController setSelectedIndex:0];
}


-(void)toDifferentView{

    if (self.baseOrderDetail) {
        for ( OrderCheckInsModel *model in self.baseOrderDetail.childOrderInfoJar) {
            if ([model.liveUserPhone isEqualToString:[LoginManager instance].userInfo.phone]) {
                //跳入住计划
                [self.navigationController popToRootViewControllerAnimated:NO];
                 AppDelegate *dele = (AppDelegate*)[UIApplication sharedApplication].delegate;
                [(UITabBarController *)dele.window.rootViewController setSelectedIndex:1];
                return;
            }
        }
        [self jumpToOrderForm];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void)dealloc{
    LYLog(@"released !");
}

@end
