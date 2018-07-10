 //
//  LYZMyOrderViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/20.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZMyOrderViewController.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "LYZOrderFormListCell.h"
#import "LoginManager.h"
#import "BaseLYZOrders.h"
#import "GCD.h"
#import "LYZOrderFormViewController.h"
#import "MJRefresh.h"
#import "Public+JGHUD.h"
#import "LYZOrderCommitViewController.h"
#import "HotelMapViewController.h"
#import "EmptyManager.h"
#import "LYZOrderCommitRoomInfoModel.h"
#import "NSDate+Formatter.h"
#import "NSDate+Utilities.h"
#import "LYZRenewViewController.h"

typedef enum : NSUInteger {
    waitingPayStatus = 0,//待支付
    payAlreadyStatus,//已支付
    checkInStatus,//已入住
    compeleteStatus,//已完成
    allOrderStatus //全部订单
} orderStatus;

@interface LYZMyOrderViewController ()<UITableViewDelegate, UITableViewDataSource,CustomCellDelegate,UIScrollViewDelegate>
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIView *markView;
@property (nonatomic, strong) UIScrollView *iScrollview;

@property (nonatomic, strong) UITableView *allOrderFormTable;
@property (nonatomic, strong) UITableView *waitingPayTable;
@property (nonatomic, strong) UITableView *waitingCheckInTable;
@property (nonatomic, strong) UITableView *checkInTable;
@property (nonatomic, strong) UITableView *checkOutTable;

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *allOrder_adapters;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *waitingPay_adapters;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *waitingCheckIn_adapters;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *checkIn_adapters;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *checkOut_adapters;

@end

@implementation LYZMyOrderViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    [self.allOrderFormTable.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"我的订单";
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    [self createSegmentControl];
    [self createScrollview];
    [self createTableView];
//    [self getMyOrderFormListData:allOrderStatus];
}

-(NSString *)getOrderStatus:(orderStatus)order{
    NSString *status = nil;
    switch (order) {
        case 0:
            status = @"0";
            break;
        case 1:
            status = @"1";
            break;
        case 2:
            status = @"2";
            break;
        case 3:
            status = @"3";
            break;
        case 4:
            status = @"4";
            break;
        default:
            break;
    }
    return status;
}

-(void)setDataSourceWithStatus:(orderStatus)status data:(NSArray <BaseLYZOrders *>*)arr{
    if (status == allOrderStatus) {
        if (!_allOrder_adapters) {
            _allOrder_adapters = [NSMutableArray array];
        }
        if (self.allOrder_adapters.count > 0) {
            [self.allOrder_adapters removeAllObjects];
        }
        for (int i = 0; i < arr.count; i ++) {
            [self.allOrder_adapters addObject:[LYZOrderFormListCell dataAdapterWithData:arr[i] cellHeight:LYZOrderFormListCell.cellHeight]];
            if (i == arr.count - 1) {
                break;
            }
            [self.allOrder_adapters addObject:[self lineType:kLongType height:0.5]];
        }
        [GCDQueue executeInMainQueue:^{
            [self.allOrderFormTable reloadData];
        }];
    }else if (status == waitingPayStatus){
        if (!_waitingPay_adapters) {
            _waitingPay_adapters = [NSMutableArray array];
        }
        if (self.waitingPay_adapters.count) {
            [self.waitingPay_adapters removeAllObjects];
        }
        for (int i = 0; i < arr.count; i ++) {
            [self.waitingPay_adapters addObject:[LYZOrderFormListCell dataAdapterWithData:arr[i] cellHeight:LYZOrderFormListCell.cellHeight]];
            if (i == arr.count - 1) {
                break;
            }
            [self.waitingPay_adapters addObject:[self lineType:kLongType height:0.5]];
        }
        [GCDQueue executeInMainQueue:^{
            [self.waitingPayTable reloadData];
        }];

    }else if (status == payAlreadyStatus){
        if (!_waitingCheckIn_adapters) {
            _waitingCheckIn_adapters = [NSMutableArray array];
        }
        if (self.waitingCheckIn_adapters.count) {
            [self.waitingCheckIn_adapters removeAllObjects];
        }
        for (int i = 0; i < arr.count; i ++) {
            [self.waitingCheckIn_adapters addObject:[LYZOrderFormListCell dataAdapterWithData:arr[i] cellHeight:LYZOrderFormListCell.cellHeight]];
            if (i == arr.count - 1) {
                break;
            }
            [self.waitingCheckIn_adapters addObject:[self lineType:kLongType height:0.5]];
        }
        [GCDQueue executeInMainQueue:^{
            [self.waitingCheckInTable reloadData];
        }];

    }else if (status == checkInStatus){
        if (!_checkIn_adapters) {
            _checkIn_adapters = [NSMutableArray array];
        }
        if (self.checkIn_adapters.count) {
            [self.checkIn_adapters removeAllObjects];
        }
        for (int i = 0; i < arr.count; i ++) {
            [self.checkIn_adapters addObject:[LYZOrderFormListCell dataAdapterWithData:arr[i] cellHeight:LYZOrderFormListCell.cellHeight]];
            if (i == arr.count - 1) {
                break;
            }
            [self.checkIn_adapters addObject:[self lineType:kLongType height:0.5]];
        }
        [GCDQueue executeInMainQueue:^{
            [self.checkInTable reloadData];
        }];

    }else if (status == compeleteStatus){
        if (!_checkOut_adapters) {
            _checkOut_adapters = [NSMutableArray array];
        }
        if (self.checkOut_adapters.count) {
            [self.checkOut_adapters removeAllObjects];
        }
        for (int i = 0; i < arr.count; i ++) {
            [self.checkOut_adapters addObject:[LYZOrderFormListCell dataAdapterWithData:arr[i] cellHeight:LYZOrderFormListCell.cellHeight]];
            if (i == arr.count - 1) {
                break;
            }
            [self.checkOut_adapters addObject:[self lineType:kLongType height:0.5]];
        }
        [GCDQueue executeInMainQueue:^{
            [self.checkOutTable reloadData];
        }];

    }
}

-(void)getMyOrderFormListData:(orderStatus)orderStatus{
    NSString *appUserID = [LoginManager instance].appUserID ? [LoginManager instance].appUserID : @"";
    NSString *status = [self getOrderStatus:orderStatus];
    [[LYZNetWorkEngine sharedInstance] getUserOrder:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID orderStatus:status limit:@"10" pages:@"1" block:^(int event, id object) {
        if (event == 1) {
            BaseIIOrder *baseOrder = ((GetUserOrdersResponse *)object).baseiiOrder;
            [self setDataSourceWithStatus:orderStatus data:baseOrder.orders];
            NSLog(@"%@",baseOrder.orders);
            
             [self endRefresh];
        }else if (event == 2){
            //无数据
            LYLog(@"空数据");
            UIImage *img = [UIImage imageNamed:@"search_nOnresult"];
            if (orderStatus == allOrderStatus) {
                [[EmptyManager sharedManager] showEmptyOnView:self.allOrderFormTable withImage:img explain:@"暂无订单" operationText:@"" operationBlock:nil];
            }else if (orderStatus == waitingPayStatus){
                [[EmptyManager sharedManager] showEmptyOnView:self.waitingPayTable withImage:img explain:@"暂无订单" operationText:@"" operationBlock:nil];
            }else if (orderStatus == payAlreadyStatus){
                [[EmptyManager sharedManager] showEmptyOnView:self.waitingCheckInTable withImage:img explain:@"暂无订单" operationText:@"" operationBlock:nil];
            }else if (orderStatus == checkInStatus){
                 [[EmptyManager sharedManager] showEmptyOnView:self.checkInTable withImage:img explain:@"暂无订单" operationText:@"" operationBlock:nil];
            }else if (orderStatus  == compeleteStatus){
                 [[EmptyManager sharedManager] showEmptyOnView:self.checkOutTable withImage:img explain:@"暂无订单" operationText:@"" operationBlock:nil];
            }
             [self endRefresh];
        }else{
//            GetUserOrdersResponse *response = (GetUserOrdersResponse *)object;
            [Public showJGHUDWhenError:self.view msg:@"服务器异常,稍后再试"];
            [self endRefresh];
        }
        
    }];
}

-(void)endRefresh{
    [self.allOrderFormTable.mj_header endRefreshing];
    [self.waitingPayTable.mj_header endRefreshing];
    [self.checkInTable.mj_header endRefreshing];
    [self.checkOutTable.mj_header endRefreshing];
    [self.waitingCheckInTable.mj_header endRefreshing];
}

-(void)createSegmentControl{
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5, SCREEN_WIDTH, 46)];
    blackView.backgroundColor = LYZTheme_NavTab_Color;
    [self.view addSubview:blackView];
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"全部订单",@"待支付",@"待入住",@"已入住",@"已退房",nil];
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    self.segmentedControl.frame = CGRectMake(0, 0, SCREEN_WIDTH , 44);
 
//    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:LYZTheme_warmGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Medium size:14]} forState:UIControlStateNormal];

    NSDictionary *dic =[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"#999999"],NSForegroundColorAttributeName, [UIFont fontWithName:LYZTheme_Font_Medium size:14],NSFontAttributeName,nil];
    [self.segmentedControl setTitleTextAttributes:dic forState:UIControlStateNormal];

    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.tintColor = [UIColor clearColor];
    [self.segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    [blackView addSubview:self.segmentedControl];
    
    self.markView = [[UIView alloc] initWithFrame:CGRectMake(0, self.segmentedControl.bottom, SCREEN_WIDTH/5.0, 2)];
    self.markView.backgroundColor = LYZTheme_paleBrown;
    [blackView addSubview:self.markView];
    
    for (int i = 1; i < 5; i ++ ) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * i/5.0, 5, 0.5, 36)];
        line.backgroundColor =  kLineColor;
        [blackView addSubview:line];
    }
}

-(void)createScrollview{
    self.iScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.markView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 46)];
    self.iScrollview.delegate = self;
    self.iScrollview.showsHorizontalScrollIndicator = NO;
    self.iScrollview.pagingEnabled = YES;
    self.iScrollview.contentSize = CGSizeMake(SCREEN_WIDTH *self.segmentedControl.numberOfSegments , SCREEN_HEIGHT - 64 - 46);
    self.iScrollview.bounces = NO;
    [self.view addSubview:self.iScrollview];
}

-(void)createTableView{
    //all  tableview
    self.allOrderFormTable               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,self.iScrollview.height)];
    self.allOrderFormTable.delegate        = self;
    self.allOrderFormTable.dataSource      = self;
    self.allOrderFormTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.allOrderFormTable.backgroundColor = [UIColor clearColor];
    self.allOrderFormTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    __weak UITableView *weaktableView = self.allOrderFormTable;
    WEAKSELF;
    weaktableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getMyOrderFormListData:allOrderStatus];
    }];
    [self.iScrollview addSubview:self.allOrderFormTable];
    //注册cell
    [ColorSpaceCell registerToTableView:self.allOrderFormTable];
    [LYZOrderFormListCell registerToTableView:self.allOrderFormTable];
    
   
    //waitingPay
    self.waitingPayTable               = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 1, 0, SCREEN_WIDTH ,self.iScrollview.height)];
    self.waitingPayTable.delegate        = self;
    self.waitingPayTable.dataSource      = self;
    self.waitingPayTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.waitingPayTable.backgroundColor = [UIColor clearColor];
    self.waitingPayTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.iScrollview addSubview:self.waitingPayTable];
    __weak UITableView *weakwaitingtableView = self.waitingPayTable;
    weakwaitingtableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getMyOrderFormListData:waitingPayStatus];
    }];
    //注册cell
    [ColorSpaceCell registerToTableView:self.waitingPayTable];
    [LYZOrderFormListCell registerToTableView:self.waitingPayTable];
  
    
    //waiting CheckIn
    self.waitingCheckInTable               = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 2, 0, SCREEN_WIDTH ,self.iScrollview.height)];
    self.waitingCheckInTable.delegate        = self;
    self.waitingCheckInTable.dataSource      = self;
    self.waitingCheckInTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.waitingCheckInTable.backgroundColor = [UIColor clearColor];
    self.waitingCheckInTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.iScrollview addSubview:self.waitingCheckInTable];
      __weak UITableView *weakWaitingCheckintableView = self.waitingCheckInTable;
    weakWaitingCheckintableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getMyOrderFormListData:payAlreadyStatus];
    }];
    //注册cell
    [ColorSpaceCell registerToTableView:self.waitingCheckInTable];
    [LYZOrderFormListCell registerToTableView:self.waitingCheckInTable];
    
    //checkIn table
    self.checkInTable               = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 3, 0, SCREEN_WIDTH ,self.iScrollview.height)];
    self.checkInTable.delegate        = self;
    self.checkInTable.dataSource      = self;
    self.checkInTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.checkInTable.backgroundColor = [UIColor clearColor];
    self.checkInTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.iScrollview addSubview:self.checkInTable];
   __weak UITableView *weakCheckintableView = self.checkInTable;
  weakCheckintableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getMyOrderFormListData:checkInStatus];
    }];
    //注册cell
    [ColorSpaceCell registerToTableView:self.checkInTable];
    [LYZOrderFormListCell registerToTableView:self.checkInTable];
    
    //checkOut table
    self.checkOutTable               = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 4, 0, SCREEN_WIDTH ,self.iScrollview.height)];
    self.checkOutTable.delegate        = self;
    self.checkOutTable.dataSource      = self;
    self.checkOutTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.checkOutTable.backgroundColor = [UIColor clearColor];
    self.checkOutTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.iScrollview addSubview:self.checkOutTable];
     __weak UITableView *weakCheckoutTable = self.checkOutTable;
    weakCheckoutTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getMyOrderFormListData:compeleteStatus];
    }];
    //注册cell
    [ColorSpaceCell registerToTableView:self.checkOutTable];
    [LYZOrderFormListCell registerToTableView:self.checkOutTable];
}

#pragma mark -- Segment Value Change

-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)seg{
    self.iScrollview.contentOffset =  CGPointMake(SCREEN_WIDTH * seg.selectedSegmentIndex, 0.0f);
    
    [UIView animateWithDuration:.5 animations:^{
        self.markView.frame = CGRectMake(SCREEN_WIDTH/5.0 * seg.selectedSegmentIndex, self.segmentedControl.bottom, SCREEN_WIDTH/5.0, 2);
    } completion:^(BOOL finished) {
        
    }];
    if (seg.selectedSegmentIndex == 0) {
        [self getMyOrderFormListData:allOrderStatus];

    }else{
         [self getMyOrderFormListData:(orderStatus)(seg.selectedSegmentIndex - 1)];
    }
}

#pragma mark -- tableView Delegate
- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {
    
    if (type == kSpace) {
        return [ColorSpaceCell dataAdapterWithData:nil cellHeight:20.f];
    } else if (type == kLongType) {
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor} cellHeight:0.5f];
    } else if (type == kShortType) {
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor, @"leftGap" : @(20.f)} cellHeight:0.5f];
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.allOrderFormTable) {
        return _allOrder_adapters.count;
    }else if (tableView == self.waitingPayTable){
        return _waitingPay_adapters.count;
    }else if (tableView == self.waitingCheckInTable){
        return _waitingCheckIn_adapters.count;
    }else if (tableView == self.checkInTable){
        return _checkIn_adapters.count;
    }else if (tableView == self.checkOutTable){
        return _checkOut_adapters.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellDataAdapter *adapter ;
    if (tableView == self.allOrderFormTable) {
        adapter = _allOrder_adapters[indexPath.row];
    }else if (tableView == self.waitingPayTable){
         adapter = _waitingPay_adapters[indexPath.row];
    }else if (tableView == self.waitingCheckInTable){
         adapter = _waitingCheckIn_adapters[indexPath.row];
    }else if (tableView == self.checkInTable){
         adapter = _checkIn_adapters[indexPath.row];
    }else if (tableView == self.checkOutTable){
         adapter = _checkOut_adapters[indexPath.row];
    }else{
    
    }
    CustomCell      *cell    = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
    cell.dataAdapter         = adapter;
    cell.data                = adapter.data;
    cell.indexPath           = indexPath;
    cell.tableView           = tableView;
    cell.delegate            = self;
    cell.controller          = self;
    [cell loadContent];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.allOrderFormTable) {
        return _allOrder_adapters[indexPath.row].cellHeight;
    }else if (tableView == self.waitingPayTable){
        return _waitingPay_adapters[indexPath.row].cellHeight;
    }else if (tableView == self.waitingCheckInTable){
        return _waitingCheckIn_adapters[indexPath.row].cellHeight;
    }else if (tableView == self.checkInTable){
        return _checkIn_adapters[indexPath.row].cellHeight;
    }else if (tableView == self.checkOutTable){
        return _checkOut_adapters[indexPath.row].cellHeight;
    }
    return  0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
}

- (void)customCell:(CustomCell *)cell event:(id)event {
    LYLog(@"%@", event);
    BaseLYZOrders *order = (BaseLYZOrders *)event;
    LYZOrderFormViewController *vc = [[LYZOrderFormViewController alloc] init];
    
    vc.orderNo = order.orderJson.orderNO;
    vc.orderType = [NSString stringWithFormat:@"%@",order.orderJson.orderType];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

#pragma mark -- ScrollView Delegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.markView.frame = CGRectMake((SCREEN_WIDTH/5.0) * (scrollView.contentOffset.x/SCREEN_WIDTH), self.segmentedControl.bottom, SCREEN_WIDTH/5.0, 2);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if ([scrollView isEqual:self.iScrollview]) {
        
        if (scrollView.contentOffset.x == 0) {
           [self.segmentedControl  setSelectedSegmentIndex:0];
           [self indexDidChangeForSegmentedControl:self.segmentedControl];
        }else if (scrollView.contentOffset.x == SCREEN_WIDTH){
             [self.segmentedControl  setSelectedSegmentIndex:1];
              [self indexDidChangeForSegmentedControl:self.segmentedControl];
        }else if (scrollView.contentOffset.x == SCREEN_WIDTH *2){
            [self.segmentedControl  setSelectedSegmentIndex:2];
              [self indexDidChangeForSegmentedControl:self.segmentedControl];
        }else if (scrollView.contentOffset.x == SCREEN_WIDTH*3){
            [self.segmentedControl  setSelectedSegmentIndex:3];
              [self indexDidChangeForSegmentedControl:self.segmentedControl];
        }else if (scrollView.contentOffset.x == SCREEN_WIDTH*4){
            [self.segmentedControl  setSelectedSegmentIndex:4];
            [self indexDidChangeForSegmentedControl:self.segmentedControl];
        }
    }
}


#pragma mark -- Cell Btn Actions

-(void)orderBtnClicked:(BaseLYZOrders *)status{
    NSInteger orderStatus = status.orderJson.childStatus.intValue;
    NSInteger hostStatus = status.orderJson.hostStatus.integerValue;
    if (hostStatus == 1) {
        if (orderStatus == 0) {
            //立即支付
            LYZOrderFormViewController *vc = [[LYZOrderFormViewController alloc] init];
            vc.orderNo = status.orderJson.orderNO;
            vc.payNow = YES;
            vc.orderType =  [NSString stringWithFormat:@"%@",status.orderJson.orderType];
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (orderStatus == 1){
            //酒店地址
            HotelMapViewController*vc = [[HotelMapViewController alloc] init];
            vc.ilatidute = status.hotelJson.latitude;
            vc.ilongitude = status.hotelJson.longitude;
            vc.address = status.hotelJson.address;
            vc.hotelName = status.hotelJson.hotelName;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (orderStatus == 2){
            //续住
            
            LYZRenewViewController *vc = [[LYZRenewViewController alloc] init];
            vc.orderNo = status.orderJson.orderNO;
            vc.orderType = [NSString stringWithFormat:@"%@",status.orderJson.orderType];
            vc.roomTypeID = status.hotelJson.roomTypeID;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (orderStatus == 3){
            //已续住
            //        LYZOrderCommitViewController *vc = [[LYZOrderCommitViewController alloc] init];
            //        vc.fromOrderNO = status.orderJson.orderNO;
            //        LYZOrderCommitRoomInfoModel *roomModel = [[LYZOrderCommitRoomInfoModel alloc] init];
            //        roomModel.roomID = status.hotelJson.roomTypeID;
            //        roomModel.hotelName = status.hotelJson. hotelName;
            //        roomModel.roomType = status.hotelJson.roomType;
            //        roomModel.checkInDate = [NSDate date];
            //        roomModel.checkOutDate = [[NSDate date] dateByAddingDays:1];
            //        vc.roomInfo = roomModel;
            //        [self.navigationController pushViewController:vc animated:YES];
            LYZRenewViewController *vc = [[LYZRenewViewController alloc] init];
            vc.orderNo = status.orderJson.orderNO;
            vc.orderType = [NSString stringWithFormat:@"%@",status.orderJson.orderType];
            vc.roomTypeID = status.hotelJson.roomTypeID;
            [self.navigationController pushViewController:vc animated:YES];
            
        }else if (orderStatus == 4 ){
            //重新预订
            LYZOrderCommitViewController *vc = [[LYZOrderCommitViewController alloc] init];
            vc.fromOrderNO = status.orderJson.orderNO;
            vc.fromOrderType = [NSString stringWithFormat:@"%@",status.orderJson.orderType];
            vc.checkInDate =  [NSDate date];
            vc.checkOutDate =  [[NSDate date] dateByAddingDays:1];
            vc.roomTypeID = status.hotelJson.roomTypeID;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        LYZOrderCommitViewController *vc = [[LYZOrderCommitViewController alloc] init];
        vc.fromOrderNO = status.orderJson.orderNO;
        vc.fromOrderType = [NSString stringWithFormat:@"%@",status.orderJson.orderType];
        vc.checkInDate =  [NSDate date];
        vc.checkOutDate =  [[NSDate date] dateByAddingDays:1];
        vc.roomTypeID = status.hotelJson.roomTypeID;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    LYLog(@"dealloc");
}


@end
