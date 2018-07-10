//
//  LYZOrderCenterViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/1.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZOrderCenterViewController.h"
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



@interface LYZOrderCenterViewController ()<UITableViewDelegate, UITableViewDataSource,CustomCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) NSArray *orders;
@property (nonatomic, assign) int count;

@end

@implementation LYZOrderCenterViewController

#pragma life cycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.orderTitle;
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    [self createTableView];
}

-(void)dealloc{
    LYLog(@"dealloc");
}

#pragma mark - UI Config

-(void)createTableView{
    //all  tableview
    self.tableView               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 64)];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableView];
    __weak UITableView *weaktableView = self.tableView;
    WEAKSELF;
    weaktableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getMyOrderFormListData:self.status limit:10];
    }];
    weaktableView.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [weakSelf getMyOrderFormListData:self.status limit:self.count];
    }];
    
    [ColorSpaceCell registerToTableView:self.tableView];
    [LYZOrderFormListCell registerToTableView:self.tableView];
}

- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {
    
    if (type == kSpace) {
        return [ColorSpaceCell dataAdapterWithData:nil cellHeight:height];
    } else if (type == kLongType) {
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor} cellHeight:0.5f];
    } else if (type == kShortType) {
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor, @"leftGap" : @(20.f)} cellHeight:0.5f];
    } else {
        return nil;
    }
}


#pragma mark - DataSource Delegate


-(void)createDataSource{
    if (!_adapters) {
        _adapters = [NSMutableArray array];
    }
    if (_adapters.count > 0) {
        [_adapters removeAllObjects];
    }
    for (int i = 0; i < self.orders.count; i ++) {
        [self.adapters addObject:[LYZOrderFormListCell dataAdapterWithData:self.orders[i] cellHeight:LYZOrderFormListCell.cellHeight]];
        if (i == self.orders.count - 1) {
            break;
        }
        [self.adapters addObject:[self lineType:kLongType height:0.5]];
    }
    [GCDQueue executeInMainQueue:^{
        [self.tableView reloadData];
    }];
    
}

-(void)getMyOrderFormListData:(orderStatus)orderStatus limit:(int)limit{
    NSString *appUserID = [LoginManager instance].appUserID ? [LoginManager instance].appUserID : @"";
    NSString *status = [self getOrderStatus:orderStatus];
    [[LYZNetWorkEngine sharedInstance] getUserOrder:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID orderStatus:status limit:[NSString stringWithFormat:@"%d",limit] pages:@"1" block:^(int event, id object) {
      
        if (event == 1) {
            BaseIIOrder *baseOrder = ((GetUserOrdersResponse *)object).baseiiOrder;
            self.orders = baseOrder.orders;
            NSLog(@"%@",baseOrder.orders);

            [self createDataSource];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }else if (event == 2){
            //无数据
            LYLog(@"空数据");
            UIImage *img = [UIImage imageNamed:@"search_nOnresult"];
           [[EmptyManager sharedManager] showEmptyOnView:self.tableView withImage:img explain:@"暂无订单" operationText:@"" operationBlock:nil];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        }else{
            //            GetUserOrdersResponse *response = (GetUserOrdersResponse *)object;
            [Public showJGHUDWhenError:self.view msg:@"服务器异常,稍后再试"];
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
        
    }];
    
    limit += 10;
    self.count = limit;
    
}

#pragma mark - TableView & DataSource Delegate

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
}

- (void)customCell:(CustomCell *)cell event:(id)event {
    LYLog(@"%@", event);
    BaseLYZOrders *order = (BaseLYZOrders *)event;
    LYZOrderFormViewController *vc = [[LYZOrderFormViewController alloc] init];
    
    vc.orderNo = order.orderJson.orderNO;
    vc.orderType = [NSString stringWithFormat:@"%@",order.orderJson.orderType];
    [self.navigationController pushViewController:vc animated:YES];
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




#pragma mark - Private Method

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


#pragma mark - Memory Warning

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
