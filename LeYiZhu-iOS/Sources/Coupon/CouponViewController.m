//
//  CouponViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/28.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "CouponViewController.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "LoginManager.h"
#import "Public+JGHUD.h"
#import "GCD.h"
#import "MJRefresh.h"
#import "CouponCell.h"
#import "CouponModel.h"
#import "BaseCouponListModel.h"
#import "CouponModel.h"
#import "AnnouncementView.h"
#import "UIViewController+BarButton.h"
#import "ExchangeCouponViewController.h"
#import "EmptyManager.h"
@interface CouponViewController ()<UITableViewDelegate, UITableViewDataSource, CustomCellDelegate,BaseMessageViewDelegate>

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) NSArray *couponList;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, assign) int count;

@end

@implementation CouponViewController

#pragma mark - life cycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.price) {
        self.title = @"使用优惠券";
    }else{
        self.title = @"优惠券";
        [self setupNav];
    }
    
    self.view.backgroundColor = LYZTheme_BackGroundColor;
     [self createTableViewAndRegisterCells];
}

#pragma mark - UI Config

-(void)setupNav{
     [self addRightBarButtonItemWithTitle:@"兑换" action:@selector(exchangeCoupon:)];
}

-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        _headView.backgroundColor = [UIColor clearColor];
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(25, 0, SCREEN_WIDTH - 50, 42)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        backgroundView.layer.shadowColor = LYZTheme_warmGreyFontColor.CGColor;
        backgroundView.layer.shadowOffset = CGSizeMake(0, 0);
        backgroundView.layer.shadowOpacity = 0.5;
        backgroundView.layer.cornerRadius = 5.0f;
        
        UILabel *label = [[UILabel alloc] initWithFrame:backgroundView.bounds];
        label.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"不使用优惠券";
        [backgroundView addSubview:label];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = backgroundView.bounds;
        [button addTarget:self action:@selector(dontUseCoupon:) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:button];
        
        backgroundView.center = _headView.center;
        backgroundView.y += 6;
        [_headView addSubview:backgroundView];
    }
    return _headView;
}

- (void)createTableViewAndRegisterCells {
    
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0,0, kScreenWidth, kScreenHeight - 64)];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    if (self.price) {
        self.tableView.tableHeaderView = self.headView;
    }
    [self.view addSubview:_tableView];
    __weak UITableView *tableView = self.tableView;
    __weak typeof(self)weakSelf = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestCouponData:10];
    }];
    tableView.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [weakSelf requestCouponData:self.count];
    }];
    [ColorSpaceCell  registerToTableView:self.tableView];
    [CouponCell registerToTableView:self.tableView];
}


- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {
    
    if (type == kSpace) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : LYZTheme_BackGroundColor} cellHeight:height];
        
    } else if (type == kLongType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor} cellHeight:0.5f];
        
    } else if (type == kShortType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor, @"leftGap" : @(20.f)} cellHeight:0.5f];
        
    } else {
        
        return nil;
    }
}

#pragma mark - DataSource Config

-(void)createDataSource{
    if (!_adapters) {
        _adapters= [NSMutableArray array];
    }
    if (_adapters.count > 0) {
        [_adapters removeAllObjects];
    }
    if (!self.price) {
         [_adapters addObject:[self lineType:kSpace height:10]];
    }
    for (int i = 0; i < self.couponList.count ; i ++) {
        [_adapters addObject:[CouponCell dataAdapterWithData:self.couponList[i] cellHeight:CouponCell.cellHeight]];
    }
    [GCDQueue executeInMainQueue:^{
        [self.tableView reloadData];
    }];
}

-(void)requestCouponData:(int)count{
    NSString *moneySum = self.price ? :@"";
    [[LYZNetWorkEngine sharedInstance] getCouponListWithCouponStatus:@"" staymoneysum:moneySum limit:[NSString stringWithFormat:@"%d",count] pages:@"1" block:^(int event, id object) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        if (event == 1) {
            [[EmptyManager sharedManager] removeEmptyFromView:self.tableView];
            GetCouponListResponse *response = (GetCouponListResponse *)object;
            BaseCouponListModel *baseCoupon = response.baseCoupon;
            self.couponList = baseCoupon.couponjar;
             [self createDataSource];
        }else if(event == 2){
            //TODO: 空
            [[EmptyManager sharedManager] showEmptyOnView:self.tableView withImage:[UIImage imageNamed:@"no_live"] explain:@"暂无优惠券" operationText:@"刷新" operationBlock:^{
            
                [self.tableView.mj_header beginRefreshing];
                [self.tableView.mj_footer endRefreshing];

            }];
            
        }else{
            
            [Public showJGHUDWhenError:self.view msg:object];
            
        }
    }];
    
    count += 10;
    
    self.count = count;
    
}

#pragma mark - TableView Delegate & DataSource Delegate
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
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
    if (self.price) {
        CouponModel *model = self.couponList[indexPath.row];
        if (model.status.integerValue == 2 && [model.isavailable isEqualToString:@"Y"]) {
            self.couponCallBack(model);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {
    LYLog(@"%@", event);
}


#pragma mark -- Btn Action

-(void)exchangeCoupon:(id)sender{
    ExchangeCouponViewController *vc = [[ExchangeCouponViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)dontUseCoupon:(UIButton *)sender{
    self.couponCallBack(nil);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)announcement:(CouponModel *)model{
    AnnoucementViewObject *object = MakeAnnoucementViewObject(model.remark);
    [AnnouncementView showManualHiddenMessageViewInKeyWindowWithMessageObject:object delegate:self viewTag:101];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
