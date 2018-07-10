//
//  LYZHotelViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/27.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZHotelViewController.h"
#import "CustomCell.h"
#import "CellDataAdapter.h"
#import "ColorSpaceCell.h"
#import "InfiniteLoopViewBuilder.h"
#import "LoopViewCell.h"
#import "ImageModel.h"
#import "CircleNodeStateView.h"
#import "LoginManager.h"
#import "NSDate+Formatter.h"
#import "NSDate+Utilities.h"
#import "LYZHotelNameCell.h"
#import "LYZHotelFunctionCell.h"
#import "LYZHotelDateCell.h"
#import "HotelMapViewController.h"
//#import "LYZCalederViewController.h"
#import "LYZOrderCommitViewController.h"
#import  "LYZOrderCommitRoomInfoModel.h"
#import "GCD.h"
#import "Public+JGHUD.h"
#import "LYZRoomViewController.h"
#import "LewPopupViewController.h"
#import "LYZPhoneCall.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>
//#import "LYZFeatureView.h"
#import "LYZHotelFacilitiesCell.h"
#import "LYZHotelCommentCell.h"
#import "LYZHotelRoomTypeCell.h"
#import "LYZHotelPolicyCell.h"
#import "LYZHotelDetailViewController.h"
#import "LYZHotelCommentViewController.h"
#import "UIViewController+BarButton.h"
#import "LYZHotelCommonTitleCell.h"
#import "LYZHotelOrderCell.h"
#import "LYZHotelWarmCell.h"
#import "LSTimeSlot.h"
#import "Calendar.h"
#import "NSDate+Utilities.h"
#import "YQAlertView.h"
#import "LYZCommentListViewController.h"
#import "LYZToast.h"
//#import "HotelBannerLoopCell.h"
#define kNormalAlertTag  2007
#define kCalendarTag 111
#define HEAD_HEIGHT 400.0f
#import "AlertView.h"
@interface LYZHotelViewController ()<UITableViewDelegate, UITableViewDataSource, CustomCellDelegate,InfiniteLoopViewBuilderEventDelegate,BaseMessageViewDelegate,YQAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) InfiniteLoopViewBuilder *banner;

@property (nonatomic, strong) NSMutableArray * bannerModels;
@property (nonatomic ,strong)  LYZHotelDetailModel * hotelDetailModel;
@property (nonatomic, strong) NSDate *checkInDate;
@property (nonatomic, strong) NSDate *checkOutDate;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic ,strong) UIButton *favoriteBtn;
@property (nonatomic,strong) Reachability *reach;
@property (nonatomic, strong) NSArray <HotelRoomsModel *> *hotelRooms;
@property (nonatomic, strong) HotelRoomsModel *selectedRoomModel;
@property (nonatomic, strong) UILabel *bannerSubtitleLabel;
@property (nonatomic , assign) NSInteger selectRoomTypeIndex;// 预留，暂时没用
@property (nonatomic, strong) NSString *unpaidOrderNo;
@property (nonatomic, strong) NSNumber *unpaidOrderType;
@property (nonatomic, strong) LYZToast *toast;

@end

@implementation LYZHotelViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBarHidden = NO;
    
    [MobClick beginLogPageView:Time_hotelDetail];
    [self monitorUnpaidOrder];

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:Time_hotelDetail];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [MobClick event:Count_hotelDetail];
    self.reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    [self.reach startNotifier];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.selectRoomTypeIndex = 0;//初始选中第一个房型
    [self setUp];
    [self refresh];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshordercell:) name:@"re" object:nil];
}

- (void)refreshordercell:(NSNotification *)noti{
    if ([noti.name isEqualToString:@"re"]) {
        [self getAllDataWithFromDate:self.checkInDate outDate:self.checkOutDate];
        [self createDateSource];
    }
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Data Config

-(void)refresh
{
    [self getAllDataWithFromDate:nil outDate:nil];
}

-(void)getAllDataWithFromDate:(NSDate *)inDate outDate:(NSDate *)outDate{
    
    NSString *userId = [LoginManager instance].appUserID;
    if (!inDate || !outDate) {
        if ([self isBetweenFromHour:0 toHour:6]) {
            inDate = [NSDate  dateYesterday];
            outDate = [NSDate date];
        }else{
            inDate = [NSDate date];
            outDate = [NSDate dateTomorrow];
        }
    }   
    [[LYZNetWorkEngine sharedInstance] getHotelDetailWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType hotelID:self.i_hotelId longitude:self.i_longitude latitude:self.i_latidute appUserId:userId checkInTime:[inDate dateWithFormat:@"yyyy-MM-dd"] checkOutTime:[outDate dateWithFormat:@"yyyy-MM-dd"] block:^(int event, id object) {
        if (event == 1) {
            
            GetHotelDetailResponse * response = (GetHotelDetailResponse*)object;
            self.hotelDetailModel = response.hotelDetail;
            self.hotelRooms = self.hotelDetailModel.roomTypes;
            self.title = response.hotelDetail.hotelName;
            NSLog(@"%@",response);

            //统计
            NSString *appuserID = [LoginManager instance].appUserID ?  [LoginManager instance].appUserID:@"游客";
            NSDictionary *analysticData = @{@"userID":appuserID , @"hotelID":self.hotelDetailModel.hotelName};
            [MobClick event:User_HotelName_HotelDetail attributes:analysticData];
            [self setHeadBanner]; //设置头部banner
            [self.tableView reloadData];
//            [self createDateSource];
            [self getHotelRoomTypeList:nil outDate:nil];
        }else{
            LYLog(@"error  --> %@",object);
        }
    }];
}


-(void)getHotelRoomTypeList:(NSDate *)inDate outDate:(NSDate *)outDate{
    if (!inDate || !outDate) {
        if ([self isBetweenFromHour:0 toHour:6]) {
            inDate = [NSDate  dateYesterday];
            outDate = [NSDate date];
        }else{
            inDate = [NSDate date];
            outDate = [NSDate dateTomorrow];
        }
    }
    
    [[LYZNetWorkEngine sharedInstance] getHotelRoomTypeList:VersionCode devicenum:DeviceNum fromtype:FromType hotelID:self.i_hotelId checkInDate:[inDate dateWithFormat:@"yyyy-MM-dd"] checkOutDate:[outDate dateWithFormat:@"yyyy-MM-dd"] block:^(int event, id object) {
        if (event == 1) {
            GetHotelRoomTypeListResponse *response = (GetHotelRoomTypeListResponse *)object;
            BaseHotelRoomsModel *base= response.baseHotelRooms;
            self.hotelRooms = base.roomTypes;
            [GCDQueue executeInMainQueue:^{
                [self createDateSource];
            }];
           
        }else{
            
            
        }
    }];
}

-(void)reloadRoomTypeCell{
    
     NSString *roomTypeAmount = [NSString stringWithFormat:@"(共%li种)",self.hotelRooms.count];
    [self.adapters replaceObjectAtIndex:6 withObject:[LYZHotelCommonTitleCell dataAdapterWithData:@{@"title":@"选择房型",@"subtitle":roomTypeAmount} cellHeight:LYZHotelCommonTitleCell.cellHeight]];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:6 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    
    NSString *isExact = [self.checkOutDate daysAfterDate:self.checkInDate] == 1 ? @"Y":@"N";
//    NSInteger index = self.selectRoomTypeIndex; //预留，目前collectionView 每次刷新都回到第一页，导致对不上
    NSInteger index = 0;
    NSDictionary *dic = @{@"data":self.hotelRooms[index],@"isExact":isExact};
    [self.adapters replaceObjectAtIndex:8 withObject:[LYZHotelOrderCell dataAdapterWithData:dic cellHeight:LYZHotelOrderCell.cellHeight]];

    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:8 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    [self.adapters replaceObjectAtIndex:9 withObject:[LYZHotelRoomTypeCell dataAdapterWithData:self.hotelRooms cellHeight:[LYZHotelRoomTypeCell cellHeightWithData]]];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:9 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
}

//Deprecated
-(void)reloadOrderCell:(HotelRoomsModel *)model{
    [self.adapters replaceObjectAtIndex:8 withObject:[LYZHotelOrderCell dataAdapterWithData:model cellHeight:LYZHotelOrderCell.cellHeight]];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:8 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)createDateSource{
    if (!self.adapters) {
        self.adapters = [NSMutableArray array];
    }
    if (self.adapters.count > 0) {
        [self.adapters removeAllObjects];
    }
    [self.adapters addObject:[LYZHotelNameCell dataAdapterWithData:self.hotelDetailModel cellHeight:LYZHotelNameCell.cellHeight]];
//    [self.adapters addObject:[self lineType:kLongType height:0.5]];
    [self.adapters addObject:[self lineType:kSpace height:10]];
    [self.adapters addObject:[LYZHotelCommonTitleCell dataAdapterWithData:@{@"title":@"入住及离店日期"} cellHeight:LYZHotelCommonTitleCell.cellHeight]];
    [self.adapters addObject:[self lineType:kLongType height:0.5]];
    if (!self.checkInDate) {
        if ([self isBetweenFromHour:0 toHour:6]) {
            self.checkInDate = [NSDate  dateYesterday];
            self.checkOutDate = [NSDate date];
        }else{
            self.checkInDate = [NSDate date];
            self.checkOutDate = [NSDate dateTomorrow];
        }
    }
    
    [self.adapters addObject:[LYZHotelDateCell dataAdapterWithData:@{@"checkIn":self.checkInDate, @"checkOut":self.checkOutDate} cellHeight:LYZHotelDateCell.cellHeight]];
        if ([[LSTimeSlot sharedTimeSlot] isStockTradingBeginHour:0 andBeginMinus:00 andEndHour:6 andEndMinus:00 andIsEarlyBack:NO andEarlyBackMinus:0]) {
            [self.adapters addObject:[LYZHotelWarmCell dataAdapterWithData:nil cellHeight:35.5]];
        }else{
            [self.adapters addObject:[self lineType:kSpace height:0.0f]];
        }
    [self.adapters addObject:[self lineType:kSpace height:10.0f]];
    NSString *roomTypeAmount = [NSString stringWithFormat:@"(共%li种)",self.hotelRooms.count];
    [self.adapters addObject:[LYZHotelCommonTitleCell dataAdapterWithData:@{@"title":@"选择房型",@"subtitle":roomTypeAmount} cellHeight:LYZHotelCommonTitleCell.cellHeight]];
    [self.adapters addObject:[self lineType:kLongType height:0.5]];
    NSString *isExact = [self.checkOutDate daysAfterDate:self.checkInDate] == 1 ? @"Y":@"N";
    NSDictionary *dic ;
    if (self.selectedRoomModel) {
        //dic = @{@"data":self.selectedRoomModel,@"isExact":isExact};
        dic = @{@"data":self.hotelRooms[self.selectRoomTypeIndex],@"isExact":isExact};
    }else{
        dic = @{@"data":self.hotelRooms[0],@"isExact":isExact};
    }
    [self.adapters addObject:[LYZHotelOrderCell dataAdapterWithData:dic cellHeight:LYZHotelOrderCell.cellHeight]];
    [self.adapters addObject:[LYZHotelRoomTypeCell dataAdapterWithData:self.hotelRooms cellHeight:[LYZHotelRoomTypeCell cellHeightWithData]]];
    [self.adapters addObject:[LYZHotelFacilitiesCell dataAdapterWithData:self.hotelDetailModel cellHeight:LYZHotelFacilitiesCell.cellHeight]];
    [self.adapters addObject:[self lineType:kLongType height:0.5]];
    [self.adapters addObject:[LYZHotelCommentCell dataAdapterWithData:self.hotelDetailModel cellHeight:LYZHotelCommentCell.cellHeight]];
    [self.adapters addObject:[self lineType:kLongType height:0.5]];
    [self.adapters addObject:[LYZHotelPolicyCell dataAdapterWithData:nil cellHeight:[LYZHotelPolicyCell cellHeightWithData:nil]]];

//    [self.adapters addObject:[LYZHotelFunctionCell dataAdapterWithData:self.hotelDetailModel cellHeight:LYZHotelFunctionCell.cellHeight]];
//    [self.adapters addObject:[self lineType:kLongType height:0.5]];
//    [self.adapters addObject:[self lineType:kLongType height:0.5]];
//    [self.adapters addObject:[self lineType:kSpace height:20.0]];
//
//    [self.adapters addObject:[self lineType:kLongType height:0.5]];
//    [self.adapters addObject:[LYZHotelRoomTypeCell dataAdapterWithData:self.hotelRooms cellHeight:SCREEN_HEIGHT - 64 - 404]];
//    [self.adapters addObject:[self lineType:kLongType height:0.5]];
    [self.tableView reloadData];
    [self.collectionView reloadData];
    [self setFavoriteIcon:self.hotelDetailModel.isFavorite.intValue];
    
}

#pragma mark -- UI Config

-(void)setHeadBanner{
    UIView *blackView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 35)];
    blackView.bottom          = _banner.height;
    self.banner.position = kNodeViewBottomRight;
    blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [_banner.contentView addSubview:blackView];
    self.bannerSubtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, SCREEN_WIDTH - 2*DefaultLeftSpace, 35)];
    self.bannerSubtitleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:15];
    self.bannerSubtitleLabel.textColor = [UIColor whiteColor];
    [blackView addSubview:self.bannerSubtitleLabel];
    self.bannerSubtitleLabel.text = self.hotelDetailModel.hotelName;
    //以上 、尝试加载到数据再添加黑色条、防止进入时候不美观

     NSMutableArray * arr_urls = [NSMutableArray array];
    if (self.hotelDetailModel.hotelImgs.count) {
        for (NSDictionary * dic in self.hotelDetailModel.hotelImgs) {
            NSString * url = [dic objectForKey:@"imgPath"];
            [arr_urls addObject:url];
        }
    }
    NSArray *strings = [NSArray arrayWithArray:arr_urls];
    NSMutableArray *models = [NSMutableArray array];
    for (int i = 0; i < strings.count; i++) {
        ImageModel *model                     = [ImageModel imageModelWithImageUrl:strings[i]];

        // Setup model.
        model.infiniteLoopCellClass           = [LoopViewCell class];
        model.infiniteLoopCellReuseIdentifier = [NSString stringWithFormat:@"LoopViewCell_%d", i];
        [models addObject:model];
    }
    _banner.models                   = (NSArray <InfiniteLoopViewProtocol, InfiniteLoopCellClassProtocol> *)models;
    [_banner startLoopAnimated:YES];
}

-(void)setUp{
    [self setLeftNav];
    [self createTableViewAndRegisterCells];
    [self setTopTabbar];
}

-(void)setLeftNav{
//    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
//    rightBtn.bounds = CGRectMake(0, 0, 60, 30);
//    UIImage * phoneImg = [[UIImage imageNamed:@"icon_phone_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [rightBtn setImage:phoneImg forState:UIControlStateNormal];
//    [rightBtn addTarget:self action:@selector(phoneCall) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceItem.width = - 20;
//    self.navigationItem.rightBarButtonItems = @[spaceItem,rightItem];
    
     UIImage * phoneImg = [[UIImage imageNamed:@"icon_phone_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addRightBarButtonWithFirstImage:phoneImg action:@selector(phoneCall)];
    
    //A页面的标题非常长，从A页面push到B页面的时候，B页面的标题会向右偏移，不能居中显示
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
}

-(void)setTopTabbar{
    UIView *topBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 47)];
    UIColor *colorOne = [UIColor colorWithRed:0.0 green:0.0  blue:0.0  alpha:0.5];
    UIColor *colorTwo = [UIColor colorWithRed:0.0  green:0.0  blue:0.0  alpha:0.0];
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo,  nil];
    
    //crate gradient layer
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    headerLayer.frame = topBarView.bounds;
    [topBarView.layer insertSublayer:headerLayer atIndex:0];
    [self.view insertSubview:topBarView atIndex:1002];
    
    self.favoriteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.favoriteBtn.frame = CGRectMake(SCREEN_WIDTH - 47 - 47 , 0, 47, 47);
    [self.favoriteBtn  setImage: [UIImage imageNamed:@"icon_keep"] forState:UIControlStateNormal];
    [self.favoriteBtn addTarget:self action:@selector(keepFavorite) forControlEvents:UIControlEventTouchUpInside];
    [topBarView addSubview:self.favoriteBtn];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(SCREEN_WIDTH -  47 , 0, 47, 47);
    [shareBtn setImage:[UIImage imageNamed:@"icon_partook"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [topBarView addSubview:shareBtn];
    
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

- (InfiniteLoopViewBuilder *)bannerHeadView
{
    if (!_banner) {
        _banner = [[InfiniteLoopViewBuilder alloc] initWithFrame:CGRectMake(0, 0, Width, HEAD_HEIGHT / 2.f)];
        _banner.nodeViewTemplate         = [CircleNodeStateView new];
        _banner.delegate                 = self;
        _banner.sampleNodeViewSize       = CGSizeMake(15, 12);
        _banner.position                 = kNodeViewBottom;
        _banner.edgeInsets               = UIEdgeInsetsMake(0, 0, 7, 5);
    }
    return _banner;
}


#pragma mark --Tableview Delegate

- (void)createTableViewAndRegisterCells {
    
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 )];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.bannerHeadView;
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.tableFooterView = self.collectionView;
    [self.view addSubview:_tableView];
    [ColorSpaceCell  registerToTableView:self.tableView];
    [LYZHotelNameCell registerToTableView:self.tableView];
    [LYZHotelFunctionCell registerToTableView:self.tableView];
    [LYZHotelDateCell registerToTableView:self.tableView];
    [LYZHotelWarmCell registerToTableView:self.tableView];
    [LYZHotelFacilitiesCell registerToTableView:self.tableView];
    [LYZHotelCommentCell registerToTableView:self.tableView];
    [LYZHotelRoomTypeCell registerToTableView:self.tableView];
    [LYZHotelPolicyCell registerToTableView:self.tableView];
    [LYZHotelOrderCell registerToTableView:self.tableView];
    [LYZHotelCommonTitleCell registerToTableView:self.tableView];
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
    
    if ([[LSTimeSlot sharedTimeSlot] isStockTradingBeginHour:0 andBeginMinus:00 andEndHour:6 andEndMinus:00 andIsEarlyBack:NO andEarlyBackMinus:0]) {
        if (indexPath.row == 4) {
            //选择时间
            [self datePick];
            //        //酒店特色
            //        [self showHotelFeature:0];
        }else if (indexPath.row == 5){
            NSLog(@"shanchu%ld",indexPath.row);
//            NSLog(@"%ld",self.adapters.count);
            [self.adapters replaceObjectAtIndex:5 withObject:[self lineType:kSpace height:0.0f]];
            NSLog(@"%ld",self.adapters.count);
            [self.tableView reloadData];
            
        }
        else if (indexPath.row == 11){

            //酒店详情
            LYZHotelDetailViewController *vc = [[LYZHotelDetailViewController alloc] init];
            vc.hotelID = self.hotelDetailModel.hotelID;
            [vc showInViewController:self];
        }else if (indexPath.row == 13){
            //评论
            LYZCommentListViewController *list = [LYZCommentListViewController new];
            list.hotelId = self.hotelDetailModel.hotelID;
            list.averageScore = self.hotelDetailModel.commentCount;
            [list showInViewController:self];
        }
    }else{
        if (indexPath.row == 4) {
            //选择时间
            [self datePick];
            //        //酒店特色
            //        [self showHotelFeature:0];
        }else if (indexPath.row == 11){
            //酒店详情
            LYZHotelDetailViewController *vc = [[LYZHotelDetailViewController alloc] init];
            vc.hotelID = self.hotelDetailModel.hotelID;
            [vc showInViewController:self];
            
        }else if (indexPath.row == 13){
            //评论
//            LYZHotelCommentViewController *vc = [[LYZHotelCommentViewController alloc] init];
//            vc.hotelId = self.hotelDetailModel.hotelID;
//            vc.averageScore = self.hotelDetailModel.avgSatisfaction;
//            [vc showInViewController:self];
            LYZCommentListViewController *list = [LYZCommentListViewController new];
                        list.hotelId = self.hotelDetailModel.hotelID;
                        list.averageScore = self.hotelDetailModel.commentCount;
                        [list showInViewController:self];
        }
    }
  
}

/*    Deprecated
-(void)showHotelFeature:(NSInteger) index{
    NSArray *strings = @[@"Feature_1",
                             @"Feature_2",
                             @"Feature_3"
                             ];
    FeatureViewMessageObject *messageObject = MakeUpdateViewObject(strings,index);
    [LYZFeatureView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:1004];
}
 */

#pragma mark - BaseMessageViewDelegate

- (void)baseMessageView:(__kindof BaseMessageView *)messageView event:(id)event {
    
    NSLog(@"%@, tag:%ld event:%@", NSStringFromClass([messageView class]), (long)messageView.tag, event);
    if (messageView.tag == kCalendarTag) {
        NSArray *arr = (NSArray *)event;
        self.checkInDate = [arr firstObject];
        self.checkOutDate = [arr lastObject];
        NSLog(@"%@,%@",self.checkInDate,self.checkOutDate);
        [self getHotelRoomTypeList:self.checkInDate outDate:self.checkOutDate];
        if (self.selectedRoomModel) {
            [self orderRoomsize:self.selectedRoomModel];
        }else{
            [self orderRoomsize:self.hotelRooms[0]];
        }
    }
    if (messageView.tag == kNormalAlertTag) {
    
    }
    [messageView hide];
}

-(void)orderRoomsize:(HotelRoomsModel *)model{
    NSString *checkinTime =[self.checkInDate dateWithFormat:@"yyyy-MM-dd"];
    NSString *checkoutTime = [self.checkOutDate dateWithFormat:@"yyyy-MM-dd"];
    [[LYZNetWorkEngine sharedInstance]  getValidRoomAmount:VersionCode devicenum:DeviceNum fromtype:FromType checkInTime:checkinTime checkOutTime:checkoutTime hotelRoomID:model.roomTypeID block:^(int event, id object) {
        GetValidRoomAmountResponse *response = (GetValidRoomAmountResponse *)object;
        if (event == 1) {
            NSDictionary *count = response.roomCout;
            NSNumber *roomsize = [count objectForKey:@"validRoomSize"];
            if ( roomsize.intValue > 0) {
            
            }else{
             
            }
        }else if (event == 100){
            [self showScanMessageTitle:nil content:response.msg leftBtnTitle:@"知道了" rightBtnTitle:nil tag:kNormalAlertTag];
        }else if (event == 102){

        }else{
            [self showScanMessageTitle:nil content:object leftBtnTitle:@"知道了" rightBtnTitle:nil tag:kNormalAlertTag];
        }}];
    
}


#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {
    
}

#pragma mark - InfiniteLoopViewBuilderEventDelegate

- (void)infiniteLoopViewBuilder:(InfiniteLoopViewBuilder *)infiniteLoopViewBuilder
                           data:(id <InfiniteLoopViewProtocol>)data
                  selectedIndex:(NSInteger)index
                           cell:(CustomInfiniteLoopCell *)cell {

    
}

- (void)infiniteLoopViewBuilder:(InfiniteLoopViewBuilder *)infiniteLoopViewBuilder
           didScrollCurrentPage:(NSInteger)index {
    
   
}


#pragma mark -- Btn Action

-(void)orderRoom:(HotelRoomsModel *)model{
    NSString *checkinTime =[self.checkInDate dateWithFormat:@"yyyy-MM-dd"];
    NSString *checkoutTime = [self.checkOutDate dateWithFormat:@"yyyy-MM-dd"];
    [[LYZNetWorkEngine sharedInstance]  getValidRoomAmount:VersionCode devicenum:DeviceNum fromtype:FromType checkInTime:checkinTime checkOutTime:checkoutTime hotelRoomID:model.roomTypeID block:^(int event, id object) {
        NSLog(@"%d,%@",event,object);
        if (event == 1) {
            GetValidRoomAmountResponse *response = (GetValidRoomAmountResponse *)object;
            NSDictionary *count = response.roomCout;
            NSNumber *roomsize = [count objectForKey:@"validRoomSize"];
            if ( roomsize.intValue > 0) {
                [GCDQueue executeInMainQueue:^{
                    LYZOrderCommitViewController *vc = [[LYZOrderCommitViewController alloc] init];
                    vc.checkInDate = self.checkInDate;
                    vc.checkOutDate = self.checkOutDate;
                    vc.roomTypeID = model.roomTypeID;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }else{

            }
        }else if (event == 100){
            GetValidRoomAmountResponse *response = (GetValidRoomAmountResponse *)object;
            NSString *msg = (NSString *)response.msg;
            [self showScanMessageTitle:nil content:msg leftBtnTitle:@"知道了" rightBtnTitle:nil tag:kNormalAlertTag];
            
        }else if (event == 102){
            GetValidRoomAmountResponse *response = (GetValidRoomAmountResponse *)object;
            NSString *msg = (NSString *)response.msg;
            [self showScanMessageTitle:nil content:msg leftBtnTitle:@"知道了" rightBtnTitle:nil tag:kNormalAlertTag];
        }else{
            [self showScanMessageTitle:nil content:object leftBtnTitle:@"知道了" rightBtnTitle:nil tag:kNormalAlertTag];
        }}];

}

-(void)selectRoomType:(HotelRoomsModel *)model index:(NSInteger)index{
//    [self.adapters replaceObjectAtIndex:8 withObject:[LYZHotelOrderCell dataAdapterWithData:model cellHeight:LYZHotelOrderCell.cellHeight]];
//    [GCDQueue executeInMainQueue:^{
//          [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:8 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
//    }];
  
    [GCDQueue executeInMainQueue:^{
        self.selectedRoomModel = model;
        self.selectRoomTypeIndex = index;// 预留，暂时没用
        [self createDateSource];
    }];
}

-(void)pushToRoom:(HotelRoomsModel *)model{
    LYZRoomViewController *vc = [[LYZRoomViewController alloc]  init];
    vc.roomID = model.roomTypeID;
    vc.hotelDetailModel = self.hotelDetailModel;
    vc.hotelRoomslModel = model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)phoneCall{
    [LYZPhoneCall noAlertCallPhoneStr:CustomerServiceNum withVC:self];
}


-(void)navToBaiDuMap{
    HotelMapViewController *vc = [[HotelMapViewController alloc] init];
    vc.ilongitude = self.hotelDetailModel.longitude;
    vc.ilatidute = self.hotelDetailModel.latitude;
    vc.address = self.hotelDetailModel.address;
    vc.hotelName = self.hotelDetailModel.hotelName;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)datePick{
    [Calendar showManualHiddenMessageViewInKeyWindowWithMessageObject:nil delegate:self viewTag:kCalendarTag];
}

//-(void)datePick{
//
//    LYZCalederViewController *vc = [[LYZCalederViewController alloc] init];
//    WEAKSELF;
//    vc.optionCalederBlock = ^(NSArray *arr){
//        weakSelf.checkInDate = [arr firstObject];
//        weakSelf.checkOutDate = [arr lastObject];
//        if (weakSelf.checkInDate == weakSelf.checkOutDate) {
//            weakSelf.checkOutDate = [weakSelf.checkInDate dateByAddingDays:1];
//        }
////        [weakSelf createDateSource];
//        [self.adapters replaceObjectAtIndex:8 withObject:[LYZHotelDateCell dataAdapterWithData:@{@"checkIn":weakSelf.checkInDate, @"checkOut":weakSelf.checkOutDate} cellHeight:LYZHotelDateCell.cellHeight]];
//        [GCDQueue executeInMainQueue:^{
//             [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:8 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
//        }];
//        [weakSelf getHotelRoomTypeList:weakSelf.checkInDate outDate:weakSelf.checkOutDate];
//    };
//    [self presentViewController:vc animated:YES completion:^{
//
//    }];
//}

-(void)share:(id)sender{
    [self share];
}


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


-(void)keepFavorite{
    NSString *userId = [LoginManager instance].appUserID;
    if (!userId) {
        
        [[LoginManager instance] userLogin];
        return;
    }
    
    [[LYZNetWorkEngine sharedInstance] updateFavoriteWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:userId hotelID:self.i_hotelId block:^(int event, id object) {
        if (event == 1) {
            UpdateUserFavoriteResponse * reponse = (UpdateUserFavoriteResponse *)object;
            NSDictionary * dic = reponse.type;
            BOOL isFavorite = NO;
            if ([dic objectForKey:@"type"]) {
                NSNumber *type = [dic objectForKey:@"type"];
                isFavorite = type.intValue ? YES : NO;
            }
            if (isFavorite) {
                 [Public showJGHUDWhenSuccess:self.view msg:@"收藏成功"];
            }else{
                [Public showJGHUDWhenSuccess:self.view msg:@"取消成功"];
            }
            
            [self setFavoriteIcon:isFavorite];
        }else{
            LYLog(@"操作失败");
        }
    }];
}

-(void)setFavoriteIcon:(int)isFavorite{
    //    _isFavorite = !_isFavorite;
    if (isFavorite) {
        [self.favoriteBtn setImage:[UIImage imageNamed:@"icon_keep_c"] forState:UIControlStateNormal];
    }else{
         [self.favoriteBtn setImage:[UIImage imageNamed:@"icon_keep"] forState:UIControlStateNormal];
    }
}

- (void) reachabilityChanged: (NSNotification*)note {
    Reachability * reach = [note object];
    
    if(![reach isReachable])
    {
        [[EmptyManager sharedManager] showEmptyOnView:self.view withImage:[UIImage imageNamed:@"no_network"] explain:@"网络断开了连接或网络无连接" operationText:@"点击刷新" operationBlock:^{
            if ([reach isReachable]) {
                [self refresh];
                [self setUp];
                [self.tableView reloadData];
            }else{
                
            }
        }];
    }
}

#pragma mark - Private

/**
 * @brief 判断当前时间是否在fromHour和toHour之间。如，fromHour=8，toHour=23时，即为判断当前时间是否在8:00-23:00之间
 */
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour {
    
    NSDate *dateFrom = [self getCustomDateWithHour:fromHour];
    NSDate *dateTo = [self getCustomDateWithHour:toHour];
    
    NSDate *currentDate = [NSDate date];
    if ([currentDate compare:dateFrom]==NSOrderedDescending && [currentDate compare:dateTo]==NSOrderedAscending) {
        // 当前时间在9点和10点之间
        return YES;
    }
    return NO;
}

/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour {
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    return [resultCalendar dateFromComponents:resultComps];
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

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"re" object:nil];
    LYLog(@"dealloc");
}


@end
