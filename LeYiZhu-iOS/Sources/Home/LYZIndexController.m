//
//  LYZIndexController.m
//  LeYiZhu-iOS
//
//  Created by L on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZIndexController.h"
#import "Masonry.h"
#import "InfiniteLoopViewBuilder.h"
#import "LoopViewCell.h"
#import "ImageModel.h"
#import "CircleNodeStateView.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "LYZSearchController.h"
#import "MJRefresh.h"
#import "BannersModel.h"
#import "RecommendsModel.h"
#import "ActivitysModel.h"
#import "Public+JGHUD.h"
#import "LYZRecommendHotelCell.h"
#import "LYZActivitysCell.h"
#import "LYZMoreHotelCell.h"
#import "GCD.h"
#import "UIViewController+TFModalView.h"
#import "TFModalContentView.h"
#import "LYZSearchController.h"
#import "LYZPhoneCall.h"
#import "LoginManager.h"
#import "LYZToast.h"
#import "LYZOrderFormViewController.h"
#import "LYZWKWebViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "LYZQRCodeScanningViewController.h"
#import "UIButton+LYZLoginButton.h"
#import "AlertView.h"
#import "UIViewController+BarButton.h"
#import "XFAlertView.h"
#import <Reachability.h>

#import "CabinetInfoModel.h"
#import "LuggageCabinetViewController.h"

#define kFetchTag 100

#define kNormalAlertTag 110

#define HEAD_HEIGHT 480.0f
@interface LYZIndexController ()<UITableViewDelegate, UITableViewDataSource, CustomCellDelegate,InfiniteLoopViewBuilderEventDelegate,BaseMessageViewDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) InfiniteLoopViewBuilder *banner;
@property (nonatomic, strong) UIView *headOrderView;
@property (nonatomic, strong) UIView *footPhoneView;
@property (nonatomic, strong) UILabel *headTitleLabel;

@property(nonatomic, strong) NSArray <BannersModel *> *banners;
@property (nonatomic, strong) NSArray <RecommendsModel *> *recommends;
@property (nonatomic, strong) NSArray <ActivitysModel *> *activitys;
@property (nonatomic, strong) NSString *moreActivity;
@property (nonatomic, strong) BaseBannerListModel *baseBannerList;
@property (nonatomic, strong) NSString *unpaidOrderNo;
@property (nonatomic, strong) NSNumber *unpaidOrderType;

//添加搜索到首页

@property (nonatomic,weak) UIViewController *searchVC;
@property (nonatomic, strong) LYZToast *toast;
@property (nonatomic, strong) Reachability *reach;

@property (nonatomic, copy) CabinetInfoModel *cabinet; // 中间量，柜子信息

@end
@implementation LYZIndexController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    [self monitorUnpaidOrder];
    [self NetWorkMonitor];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [_toast dismissToast];
    if (self.searchVC) {
        [self.searchVC hiddenTFModalViewControllerWithHiddenCompletionBlock:nil];
    }
}

- (void)NetWorkMonitor{
    
    self.reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    self.reach .unreachableBlock = ^(Reachability * reachability){
        [GCDQueue executeInMainQueue:^{
            [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
        }];
    };
    weakify(self);
    self.reach.reachableBlock = ^(Reachability * reachability){
        strongify(self);
        [self fetchBannerListData];
    };
    [self.reach  startNotifier];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"乐易住";
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setUp];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSearch:) name:kNotificationShowSearch object:nil];
}


-(void)showSearch:(NSNotification *)noti{
    [self showHotelList];
}


-(void)setUp{
    [self setRightButton];
    [self createTableViewAndRegisterCells];
     [self fetchBannerListData];
}

#pragma mark -- UI Config

#pragma mark- 设置右侧的按钮

- (void)setRightButton{
    self.navigationItem.title = @"乐易住";
    [self addLeftBarButtonWithImage:[UIImage imageNamed:@"icon_richscan"]  action:@selector(scanningQRCode:) needLogin:YES];
    [self addRightBarButtonItemWithTitle:@"立即预订" action:@selector(toBookRoom:)];
}

- (UIView *)bannerHeadView
{
        UIView *backGround = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HEAD_HEIGHT)];
        backGround.backgroundColor = LYZTheme_BackGroundColor;
         if (!_banner) {
            _banner = [[InfiniteLoopViewBuilder alloc] initWithFrame:CGRectMake(0, 0, Width, 262)];
            _banner.nodeViewTemplate         = [CircleNodeStateView new];
            _banner.delegate                 = self;
            _banner.sampleNodeViewSize       = CGSizeMake(15, 12);
            _banner.position                 = kNodeViewBottom;
            _banner.edgeInsets               = UIEdgeInsetsMake(0, 0, 40, 5);
             _banner.scrollTimeInterval = 2;
            [backGround addSubview:_banner];
            [backGround insertSubview:self.headOrderView atIndex:101];
        }
    return backGround;
}

-(UIView *)footPhoneView{
    if (!_footPhoneView) {
        _footPhoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _footPhoneView.backgroundColor = LYZTheme_BackGroundColor;
        UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        phoneBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH, _footPhoneView.height);
        NSString *phone = [NSString stringWithFormat:@"客服电话：%@",CustomerServiceNum];
        phoneBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14];
        [phoneBtn setTitle:phone forState:UIControlStateNormal];
        [phoneBtn setTitleColor:LYZTheme_warmGreyFontColor forState:UIControlStateNormal];
        [phoneBtn addTarget:self action:@selector(PhoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_footPhoneView addSubview:phoneBtn];
    }
    return _footPhoneView;
}

-(UIView *)headOrderView{
    if (!_headOrderView) {
        _headOrderView = [[UIView alloc] initWithFrame:CGRectMake(14.5, 229, SCREEN_WIDTH - 14.5*2, 232)];
        _headOrderView.backgroundColor = [UIColor whiteColor];
        _headOrderView.layer.borderWidth = 1;
        _headOrderView.layer.borderColor = kLineColor.CGColor;
        _headOrderView.layer.shadowOffset = CGSizeMake(0, 0);
        _headOrderView.layer.shadowOpacity = .6;
        _headOrderView.layer.shadowColor = LYZTheme_warmGreyFontColor.CGColor;
        
        _headTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake((_headOrderView.width - 290)/2.0, 25, 290, 70)];
        _headTitleLabel.numberOfLines = 0;
        _headTitleLabel.textAlignment = NSTextAlignmentCenter;
        _headTitleLabel.textColor = [UIColor blackColor];
        _headTitleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:20];
        _headTitleLabel.text = @"全球领先的无人智慧酒店";
        [_headOrderView addSubview:_headTitleLabel];
        
        UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        orderBtn.frame = CGRectMake(28, _headTitleLabel.bottom + 15, _headOrderView.width - 28 *2, 40);
        orderBtn.backgroundColor = LYZTheme_paleBrown;
        [orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [orderBtn setTitle:@"立即预订" forState:UIControlStateNormal];
        orderBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
        [orderBtn addTarget:self action:@selector(orderHotel:) forControlEvents:UIControlEventTouchUpInside];
        [_headOrderView addSubview:orderBtn];
        
        UIButton *aboutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        aboutBtn.frame = CGRectMake(orderBtn.x, orderBtn.bottom + 10, orderBtn.width, orderBtn.height);
        [aboutBtn setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
        [aboutBtn setTitle:@"了解乐易住" forState:UIControlStateNormal];
        aboutBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
        aboutBtn.layer.borderWidth = 1.0f;
        aboutBtn.layer.borderColor = LYZTheme_paleBrown.CGColor;
        [aboutBtn addTarget:self action:@selector(aboutUs:) forControlEvents:UIControlEventTouchUpInside];
        [_headOrderView addSubview:aboutBtn];
        
    }
    return _headOrderView;
}

- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {
    if (type == kSpace) {
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" :LYZTheme_BackGroundColor} cellHeight:height];
    } else if (type == kLongType) {
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor} cellHeight:0.5f];
    } else if (type == kShortType) {
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" : kLineColor, @"leftGap" : @(20.f)} cellHeight:0.5f];
    } else {
        return nil;
    }
}

#pragma mark -- Config DateSource

-(void)monitorUnpaidOrder{
    NSString * appUserID = [LoginManager instance].appUserID;
    if (appUserID.length == 0) {
        appUserID = @"";
    }
    [[LYZNetWorkEngine sharedInstance] getUnpaidOrder:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID block:^(int event, id object) {
        if (event == 1) {
            GetUnpaidOrderResponse *response = (GetUnpaidOrderResponse *)object;
            createOrderModel *unpaidOrder = response.order;
            self.unpaidOrderNo = unpaidOrder.orderNo;
            self.unpaidOrderType = unpaidOrder.orderType;
            //显示通知框
            [self showToast];
        }else{
            
        }
    }];
}

-(void)fetchBannerListData{
    [[LYZNetWorkEngine sharedInstance] getHomeBannerList:VersionCode devicenum:DeviceNum fromtype:FromType block:^(int event, id object) {
               if (event == 1) {
                   [self endRefresh];
                GetHomeBannerListResponse *response = (GetHomeBannerListResponse *)object;
                BaseBannerListModel *baseBannerModel = response.baseBannerList;
                   self.banners = baseBannerModel.banners;
                   self.recommends = baseBannerModel.recommends;
                   self.activitys = baseBannerModel.activitys;
                   self.moreActivity = baseBannerModel.activityurl;
                   [self configBannerImgs:self.banners];
                   [self createDataSource];
                   
        }else if(event == 2)
            [Public showJGHUDWhenError:self.view msg:@"暂无数据"];
        {
//            [Public showJGHUDWhenError:self.view msg:@""];
        }
    }];
}

-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
}

-(void)configBannerImgs:(NSArray <BannersModel *> *) banner{
    if (banner.count) {
        NSMutableArray *models = [NSMutableArray array];
        for (int i = 0; i < banner.count; i++) {
            BannersModel *bannerModel =  banner[i];
            ImageModel *model                     = [ImageModel imageModelWithImageUrl:bannerModel.imgpath];
            // Setup model.
            model.infiniteLoopCellClass           = [LoopViewCell class];
            model.infiniteLoopCellReuseIdentifier = [NSString stringWithFormat:@"LoopViewCell_%d", i];
            [models addObject:model];
        }
        _banner.models                   = (NSArray <InfiniteLoopViewProtocol, InfiniteLoopCellClassProtocol> *)models;
        [_banner startLoopAnimated:YES];
       
    }
}


-(void)createDataSource{
    if (!_adapters) {
        _adapters = [NSMutableArray array];
    }
    if (_adapters.count) {
        [_adapters removeAllObjects];
    }
    [_adapters addObject:[LYZRecommendHotelCell dataAdapterWithData:self.recommends cellHeight:LYZRecommendHotelCell.cellHeight]];
    [_adapters addObject:[LYZActivitysCell dataAdapterWithData:self.activitys cellHeight:LYZActivitysCell.cellHeight]];
    [_adapters addObject:[LYZMoreHotelCell dataAdapterWithData:nil cellHeight:LYZMoreHotelCell.cellHeight]];
    [GCDQueue executeInMainQueue:^{
        
        [self.tableView reloadData];
        
    }];
}

#pragma mark --Tableview Delegate

- (void)createTableViewAndRegisterCells {
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49  -64)];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.bannerHeadView;
    self.tableView.tableFooterView =self.footPhoneView;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    __weak UITableView *tableView = self.tableView;
    __weak typeof(self)weakSelf = self;
    tableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchBannerListData];
        [weakSelf monitorUnpaidOrder];
    }];
    self.tableView.mj_header.backgroundColor = LYZTheme_BackGroundColor;
    [ColorSpaceCell registerToTableView:self.tableView];
    [LYZRecommendHotelCell registerToTableView:self.tableView];
    [LYZActivitysCell registerToTableView:self.tableView];
    [LYZMoreHotelCell registerToTableView:self.tableView];
    
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
    cell.controller          = self;
    [cell loadContent];
    // WEAKSELF;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) {
        //了解更多
        if (self.reach.currentReachabilityStatus == NotReachable) {
            [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
        }else{
            LYZWKWebViewController *vc = [[LYZWKWebViewController alloc] init];
            vc.strURL = self.moreActivity;
            vc.title = @"品牌活动";
            vc.type = iMoreType;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
   
    }
}

#pragma mark - InfiniteLoopViewBuilderEventDelegate

- (void)infiniteLoopViewBuilder:(InfiniteLoopViewBuilder *)infiniteLoopViewBuilder
                           data:(id <InfiniteLoopViewProtocol>)data
                  selectedIndex:(NSInteger)index
                           cell:(CustomInfiniteLoopCell *)cell {
    
//    ImageModel *model = (ImageModel *)data;
    BannersModel *bannerModel = self.banners[index];
    NSLog(@"-----%@",bannerModel.url);
    if (self.reach.currentReachabilityStatus == NotReachable) {
        [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
    }else{
        if (bannerModel.url.length > 0) {
            LYZWKWebViewController *vc = [[LYZWKWebViewController alloc] init];
            vc.title = bannerModel.subtitle;
            vc.strURL = bannerModel.url;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

- (void)infiniteLoopViewBuilder:(InfiniteLoopViewBuilder *)infiniteLoopViewBuilder
           didScrollCurrentPage:(NSInteger)index {

//    BannersModel *model = self.banners[index];
//    self.headTitleLabel.text = model.subtitle;

}

#pragma mark- Btn Actions

-(void)showToast{
    _toast = [[LYZToast alloc] initToastWithTitle:@"您有一个待支付订单" message:@"立即处理 >>" iconImage:nil];
    _toast.supView = self.view;
    [_toast show:^{
        [_toast dismissToast];
        //跳转
        LYZOrderFormViewController *vc = [[LYZOrderFormViewController alloc] init];
        vc.orderType =  [NSString stringWithFormat:@"%@",self.unpaidOrderType];
        vc.orderNo = self.unpaidOrderNo;
        vc.payNow = YES;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    }];
}



//预定按钮方法
- (void)toBookRoom:(UIBarButtonItem *)book{
    [self showHotelList];
    
}

-(void)showHotelList{
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"luanched" forKey:@"firstLaunch"];
        if (self.searchVC) {
            return;
        }
        LYZSearchController *vc = [LYZSearchController new];
        [self showTFModalViewControllerWithController:vc AndShowScale:0.7 AndShowDirection:TFModalViewControllerShowDirectionFromTop WithShowCompletionBlock:^{
            self.searchVC = vc;
        }];

    }else{
        if ([CLLocationManager locationServicesEnabled])
        {
            //  判断用户是否允许程序获取位置权限
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse||[CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways)
            {
                //用户允许获取位置权限
                if (self.searchVC) {
                    return;
                }
                LYZSearchController *vc = [LYZSearchController new];
                [self showTFModalViewControllerWithController:vc AndShowScale:0.7 AndShowDirection:TFModalViewControllerShowDirectionFromTop WithShowCompletionBlock:^{
                    self.searchVC = vc;
                }];
            }else
            {
                //用户拒绝开启用户权限
                [GCDQueue executeInMainQueue:^{
                    UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"打开-定位服务权限-来允许-乐易住-确定您的位置" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>开启)" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
                    alertView.delegate=self;
                    alertView.tag=2;
                    [alertView show];
                }];
                
            }
        }else{
            [GCDQueue executeInMainQueue:^{
                UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"打开-定位服务权限-来允许-乐易住-确定您的位置" message:@"请在系统设置中开启定位服务(设置>隐私>定位服务>乐易住>始终)" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去设置", nil];
                alertView.delegate=self;
                alertView.tag=1;
                [alertView show];
            }];
            
        }
    }
   
}



-(void)PhoneBtnClick:(id)sender{
    [LYZPhoneCall noAlertCallPhoneStr:CustomerServiceNum withVC:self];
}


-(void)orderHotel:(id)sender{
    //--------- >跳搜索
    [self showHotelList];
    
}


-(void)aboutUs:(id)sender{
    if (self.reach.currentReachabilityStatus == NotReachable) {
        [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
    }else{
        //banner 页面
        LYZWKWebViewController *vc = [[LYZWKWebViewController alloc] init];
        vc.title = @"乐易住";
        vc.strURL = AboutLYZ;
        vc.type = iBannerType;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
  
}

-(void)moreDetail:(RecommendsModel * )model{
    if (self.reach.currentReachabilityStatus == NotReachable) {
        [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
    }else{
        LYZWKWebViewController *vc = [[LYZWKWebViewController alloc] init];
        vc.type = iRecommendType;
        vc.hotelID = model.hotelid;
        vc.title = model.hotelname;
        vc.strURL = model.url;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
   
    
}

-(void)activityDetail:(ActivitysModel *)model{
    if (self.reach.currentReachabilityStatus == NotReachable) {
        [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
    }else{
        LYZWKWebViewController *vc  = [[LYZWKWebViewController alloc] init];
        vc.type = iActivityType;
        vc.hidesBottomBarWhenPushed = YES;
        vc.strURL = model.url;
        vc.title = @"品牌活动";
        [self.navigationController pushViewController:vc animated:YES];
    }
 
    
}

- (void)scanningQRCode:(id)sender {
    // 1、 获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (status == AVAuthorizationStatusNotDetermined) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        LYZQRCodeScanningViewController *vc = [[LYZQRCodeScanningViewController alloc] init];
                        vc.hidesBottomBarWhenPushed = YES;
                        WEAKSELF;
                        vc.popBlock = ^(NSString *cabinetNo, NSString *type) {
                            [weakSelf handleScanResult:cabinetNo type:type];
                        };
                        [self.navigationController pushViewController:vc animated:YES];
                    });
                    
                    SGQRCodeLog(@"当前线程 - - %@", [NSThread currentThread]);
                    // 用户第一次同意了访问相机权限
                    SGQRCodeLog(@"用户第一次同意了访问相机权限");
                    
                } else {
                    
                    // 用户第一次拒绝了访问相机权限
                    SGQRCodeLog(@"用户第一次拒绝了访问相机权限");
                }
            }];
        } else if (status == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
            LYZQRCodeScanningViewController *vc = [[LYZQRCodeScanningViewController alloc] init];
            WEAKSELF;
            vc.popBlock = ^(NSString *cabinetNo, NSString *type) {
                [weakSelf handleScanResult:cabinetNo type:type];
            };
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } else if (status == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
            UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@" 警告" message:@"请去-> 设置 - 隐私 - 相机 -乐易住 - 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *alertB = [UIAlertAction actionWithTitle:@"去设置" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if( [[UIApplication sharedApplication] canOpenURL:url] ) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }];
            
            [alertC addAction:alertA];
            [alertC addAction:alertB];
            [self presentViewController:alertC animated:YES completion:nil];
            
        } else if (status == AVAuthorizationStatusRestricted) {
            NSLog(@"因为系统原因, 无法访问相册");
        }
    } else {
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
    } 
    
}


#pragma mark - BaseMessageViewDelegate

- (void)baseMessageView:(__kindof BaseMessageView *)messageView event:(id)event {
    
    NSLog(@"%@, tag:%ld event:%@", NSStringFromClass([messageView class]), (long)messageView.tag, event);
    if (messageView.tag == kFetchTag) {
        //取失物
        if ([event isEqualToString:@"打开柜门"]) {
            [[LYZNetWorkEngine sharedInstance] openCabinet:self.cabinet.cabinetID cabtype:self.cabinet.cabtype opentype:self.cabinet.opentype latticeid:self.cabinet.latticeid norm:nil block:^(int event, id object) {
                if (event == 1) {
                    [Public showJGHUDWhenSuccess:self.view msg:@"开柜成功"];
                }else{
                    [Public showJGHUDWhenError:self.view msg:object];
                }
            }];
        }
    }
    
    
    [messageView hide];
    
}

-(void)showScanMessageTitle:(NSString *)title content:(NSString *)content leftBtnTitle:(NSString *)left rightBtnTitle:(NSString *)right tag:(NSInteger)tag{
    [GCDQueue executeInMainQueue:^{
        NSArray  *buttonTitles ;
        if (left && right) {
            buttonTitles   =  @[AlertViewNormalStyle(left),AlertViewRedStyle(right)];
        }else{
            buttonTitles = @[AlertViewRedStyle(left)];
        }
        
        AlertViewMessageObject *messageObject = MakeAlertViewMessageObject(title,content, buttonTitles);
        [AlertView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:tag];
    }];
}

-(void)handleScanResult:(NSString * )cabinetNo type:(NSString *)cabinetType{
    [[LYZNetWorkEngine sharedInstance] getCabinetInfo:cabinetNo cabinetType:cabinetType block:^(int event, id object) {
        if (event == 1) {
            GetCabinetInfoResponse *response = (GetCabinetInfoResponse *)object;
            CabinetInfoModel *cabinetInfo = response.cabinetInfo;
            self.cabinet = response.cabinetInfo;
            
            if ([cabinetInfo.opentype isEqualToString:@"1"]) {
                //取
                if ([cabinetInfo.cabtype isEqualToString:@"3"]) {
                    //取行李
                    
                    NSString *content = @"温馨提示:\n1、取出行李后，不能再次打开柜子，请确保所有行李已取出；\n2、取完物品后请关柜门。\n3、如有问题，请联系客服（4009670533)";
                    [self showScanMessageTitle:@"取出行李" content:content leftBtnTitle:@"取消" rightBtnTitle:@"打开柜门" tag:kFetchTag];
                    
                }else if([cabinetInfo.cabtype isEqualToString:@"4"]){
                    //取失物
                    
                    NSString *content = @"温馨提示:\n1、取出失物后，不能再次打开柜子，请确保所有失物已取出；\n2、取完物品后请关柜门。\n3、如有问题，请联系客服（4009670533)";
                    [self showScanMessageTitle:@"取出失物" content:content leftBtnTitle:@"取消" rightBtnTitle:@"打开柜门" tag:kFetchTag];
                }
               
                
            }else if ([cabinetInfo.opentype isEqualToString:@"2"]){
                //存
                LuggageCabinetViewController *vc = [[LuggageCabinetViewController alloc] init];
                vc.cabinetInfo = cabinetInfo;
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:NO];
            }
        
        }else if (event == 2){
            
        }else{
            //显示错误提示
            [self showScanMessageTitle:nil content:object leftBtnTitle:@"知道了" rightBtnTitle:nil tag:kNormalAlertTag];
        }
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.000000) {
                //跳转到定位权限页面
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if( [[UIApplication sharedApplication] canOpenURL:url] ) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }else {
                //跳转到定位开关界面
                NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
                if( [[UIApplication sharedApplication]canOpenURL:url] ) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        }
    } else if (alertView.tag == 2) {
        if (buttonIndex == 1) {
            //跳转到定位权限页面
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if( [[UIApplication sharedApplication] canOpenURL:url] ) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }
    }
    if (self.searchVC) {
        return;
    }
    LYZSearchController *vc = [LYZSearchController new];
    [self showTFModalViewControllerWithController:vc AndShowScale:0.7 AndShowDirection:TFModalViewControllerShowDirectionFromTop WithShowCompletionBlock:^{
        self.searchVC = vc;
    }];
}


- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



@end
