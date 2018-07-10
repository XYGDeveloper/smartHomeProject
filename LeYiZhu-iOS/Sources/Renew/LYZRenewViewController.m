//
//  LYZRenewViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/11.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZRenewViewController.h"
#import "ColorSpaceCell.h"
#import "CustomCell.h"
#import "LoginManager.h"
#import "Public+JGHUD.h"
#import "LYZRenewPhoneCell.h"
#import "LYZRenewHotelNameCell.h"
#import "LYZRenewRoomTypeCell.h"
#import "LYZRenewGuestInfoCell.h"
#import "RefillInfoModel.h"
#import "BaseRefillInfoModel.h"
#import "LYZRefillGuestInfoModel.h"
#import "OrderPreFillModel.h"
#import "OrderCommitChooseInvoiceCell.h"
#import "OrderCommitInvoiceInfoCell.h"
#import "OrderInvoiceModel.h"
#import "LYZInvoiceViewController.h"
#import "OrderCommitNoticeCell.h"
#import "CountRefillLiveMoneyModel.h"
//#import "LYZRenewPayMoneyDetailView.h"
#import "PaymentView.h"
#import "NSArray+YYAdd.h"
#import "NSDictionary+YYAdd.h"

#import "GCD.h"
#import "NSDate+Utilities.h"
#import "ThirdPayManager.h"
#import "UIAlertView+Block.h"
#import "LYZPayScuessViewController.h"
#import "LYZSingleCalenderViewController.h"
#import "AlertView.h"
#import "LYZPhoneCall.h"
#import "OrderCommitNoTraceCell.h"
#import "User.h"
#import "OrderCommitCouponCell.h"
#import "PreFillCouponModel.h"
#import "CouponModel.h"
#import "CouponViewController.h"
#import "LYZHotelRoomDetailModel.h"
#import "RenewCalendar.h"
#import "PaymentDetailView.h"
#import "UIView+SetRect.h"
#import "RoomPriceInfo.h"
#import "NSDate+Formatter.h"
#import "YQAlertView.h"
#define kRenewCalendarTag 121
#define kPayAlertTag 101
#define kPaymentViewHeightYScale 0.417
#define kMoneyDetalViewHeight (kPaymentViewHeightYScale * SCREEN_HEIGHT)

@interface LYZRenewViewController ()<UITableViewDelegate, UITableViewDataSource, CustomCellDelegate,BaseMessageViewDelegate,YQAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;

//bottom float View
@property(nonatomic, strong) UILabel *totalPriceLabel;
@property(nonatomic, strong) UILabel *depositLabel;

//@property (nonatomic, strong) BaseOrderDetailModel *orderDetailModel;
@property (nonatomic, strong) LYZHotelRoomDetailModel *roomInfo;
@property (nonatomic ,strong) NSArray <RefillInfoModel *> * refillUsers;
@property (nonatomic ,copy) NSArray <LYZRefillGuestInfoModel *>*localGuestInfoModel;
@property (nonatomic, strong)PreFillCouponModel *couponModel;

@property (nonatomic,strong) OrderInvoiceModel *invoiceModel;
@property (nonatomic, strong) CountMoneyModel *countMoneyModel;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, assign) BOOL needInvoice;

@property(nonatomic, strong) UIView *alphaBlackView;//选择房间数时弹出

@property (nonatomic, strong) PaymentView *moneyDetailView;

@property (nonatomic ,assign)CGFloat moneyDetailViewHeight;

@property (nonatomic, copy) NSString *renewOrder;
@property (nonatomic, strong) NSNumber *renewOrderType;
@property (nonatomic, strong) CreateRenewModel *existRenewOrder;
@property (nonatomic, assign) BOOL isTrack;

@property (nonatomic, copy) NSString *price;

@property (nonatomic, copy) NSString *forRequestOrderStatus_orderNo;// 专门为获取每次订单状态的订单号
@property (nonatomic, copy) NSString *forRequestOrderStatus_orderType;// 专门为获取每次订单状态的订单号

@property (nonatomic, assign) NSInteger selectedRenewIndex;

@property (nonatomic, strong) NSDate *renewDate;

@property (nonatomic, strong) PaymentDetailView *paymentDetailView;

@property (nonatomic, strong)UIView *floatView; //底部支付栏

@property (nonatomic, strong) CountRefillLiveMoneyModel *refillMoneyModel;

@property (nonatomic, strong) RoomPriceInfo *priceInfo;

@end

@implementation LYZRenewViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.title = @"续住订单填写";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkVxPaySuccess:) name:kNotificationCheckVxPaySuccess object:nil];
    
    //第一次续住，把子订单号传给
    self.forRequestOrderStatus_orderNo = self.orderNo;
    self.forRequestOrderStatus_orderType = self.orderType;
    
    AppDelegate *dele = (AppDelegate*)[UIApplication sharedApplication].delegate;
    dele.renewOrderVC = self;
    _isTrack = NO;
     User *userInfo = [LoginManager instance].userInfo ;
    self.phone =userInfo.phone;
    [self setup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setup {
     [self setupNav];
    [self createTableViewAndRegisterCells];
    [self createBottomFloatView];
    [self createDefaultData];
    [self getRefillLiveUsers];
     [self getRoomInfo];
}

#pragma mark - Config UI

-(void)setupNav{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.bounds = CGRectMake(0, 0, 60, 30);
    [rightButton setImage:[UIImage imageNamed:@"icon_phone_left"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(phoneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = - 20;
    self.navigationItem.rightBarButtonItems = @[spaceItem,rightItem];
}

-(void)createBottomFloatView{
   self.floatView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT  - 60 - 64, SCREEN_WIDTH, 60)];
    self.floatView .backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = kLineColor;
    [self.floatView addSubview:line];
    
    self.totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, SCREEN_WIDTH - 165, 35)]; //165 提交按钮宽度
    self.totalPriceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:22];
    self.totalPriceLabel.textColor = LYZTheme_paleBrown;
    self.totalPriceLabel.textAlignment = NSTextAlignmentLeft;
    [self.floatView  addSubview:self.totalPriceLabel];
    
    self.depositLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, self.totalPriceLabel.bottom - 5,  SCREEN_WIDTH - 165, 25)];
    self.depositLabel.textColor = LYZTheme_greyishBrownFontColor;
    self.depositLabel.textAlignment = NSTextAlignmentLeft;
    self.depositLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13.0f];
    
    [self.floatView  addSubview:self.depositLabel];
    
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(SCREEN_WIDTH - 165, 0.5 , 165, 59.5);
    [payBtn setBackgroundColor:LYZTheme_paleBrown];
    [payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.floatView  addSubview:payBtn];
    
    UIButton *paymentDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    paymentDetailBtn.frame = CGRectMake(0, 0, 80, 60);
    paymentDetailBtn.right = SCREEN_WIDTH - 165;
    paymentDetailBtn.y = 0;
    [paymentDetailBtn setTitle:@"金额明细" forState:UIControlStateNormal];
    paymentDetailBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:13];
    [paymentDetailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [paymentDetailBtn addTarget:self action:@selector(showPaymentDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.floatView addSubview:paymentDetailBtn];
    
    [self.view insertSubview:self.floatView  atIndex:1001];
}

- (void)createTableViewAndRegisterCells {
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 60 - 64 )]; // 多 -5  底部留点空白
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [ColorSpaceCell  registerToTableView:self.tableView];
    [OrderCommitCouponCell registerToTableView:self.tableView];
    [LYZRenewHotelNameCell registerToTableView:self.tableView];
    [LYZRenewRoomTypeCell registerToTableView:self.tableView];
    [LYZRenewGuestInfoCell registerToTableView:self.tableView];
    [OrderCommitChooseInvoiceCell registerToTableView:self.tableView];
    [OrderCommitInvoiceInfoCell registerToTableView:self.tableView];
    [OrderCommitNoticeCell registerToTableView:self.tableView];
    [OrderCommitNoTraceCell registerToTableView:self.tableView];
}

-(void)updateMoneyWithModel:(CountRefillLiveMoneyModel *)model{
    self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%@",[NSString removeFloatAllZero:[NSString stringWithFormat:@"%@",model.actualPayment]]];
    NSString *str = [NSString stringWithFormat:@"含押金￥%@",[NSString removeFloatAllZero:[NSString stringWithFormat:@"%@",model.depositSum]]];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    [string addAttribute:NSForegroundColorAttributeName value:LYZTheme_paleBrown range:NSMakeRange(3,str.length - 3)];
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f] range:NSMakeRange(3,str.length - 3)];
    self.depositLabel.attributedText = string;
    [self.moneyDetailView configureWithRenewMoneyModel:model hotelName:self.roomInfo.hotelname roomType:self.roomInfo.roomType];
}

-(UIView *)alphaBlackView{
    if (!_alphaBlackView) {
        _alphaBlackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _alphaBlackView.backgroundColor = [UIColor blackColor];
        _alphaBlackView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissMissRoomCountView)];
        [_alphaBlackView addGestureRecognizer:tap];
    }
    return _alphaBlackView;
    
}

-(PaymentView *)moneyDetailView{
    if (!_moneyDetailView) {
        _moneyDetailView = [[PaymentView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,kMoneyDetalViewHeight)];
        WEAKSELF;
        _moneyDetailView.wxPay= ^(){
            [[ThirdPayManager instance] weixinRequest:weakSelf.renewOrder orderType: [NSString stringWithFormat:@"%@",weakSelf.renewOrderType]];
        };
        _moneyDetailView.aliPay =^(){
            [[ThirdPayManager instance] createAliOrder:weakSelf.renewOrder orderType: [NSString stringWithFormat:@"%@",weakSelf.renewOrderType]];
        };
    }
    return _moneyDetailView;
}

-(PaymentDetailView *)paymentDetailView{
    if (!_paymentDetailView) {
        _paymentDetailView = [[PaymentDetailView alloc] initWithFrame: [UIScreen mainScreen].bounds];
    }
    return _paymentDetailView;
}

-(void)resetBottomMoneyDetail{
    NSString *deposit = self.refillMoneyModel.depositSum ? :@"0";
    self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%@",deposit];
    NSString *str = [NSString stringWithFormat:@"含押金￥%@",deposit];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    [string addAttribute:NSForegroundColorAttributeName value:LYZTheme_paleBrown range:NSMakeRange(3,str.length - 3)];
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f] range:NSMakeRange(3,str.length - 3)];
    self.depositLabel.attributedText = string;
}

#pragma mark - Data Config

-(void)createDefaultData{
    //续住默认不需要发票
    OrderInvoiceModel *invoiceModel = [[OrderInvoiceModel alloc] init];
    invoiceModel.type = OrderInvoiceType_none;
    self.invoiceModel = invoiceModel;
    self.needInvoice = NO;
}

-(void)getRoomInfo{
    [[LYZNetWorkEngine sharedInstance] getHotelRoomDetailWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType roomID:self.roomTypeID block:^(int event, id object) {
        if (event == 1) {
            GetHotelRoomDetailsResponse *response = (GetHotelRoomDetailsResponse*)object;
            self.roomInfo = response.hotelRoomDetail;
            [self createDataSource];
           
        }else{
            [Public showJGHUDWhenError:self.view msg:object];
        }
    }];
}

-(void)getRoomPrice:(NSString *)roomtypeId{
    LYZRefillGuestInfoModel *model = self.localGuestInfoModel[0];
    NSString *outDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    if ([model.renewDate isEqualToString:model.continueDate]) {
        NSDate * endDate =[[formatter  dateFromString:model.continueDate] dateByAddingDays:1];
        outDate = [formatter stringFromDate:endDate];
    }else{
        outDate = model.renewDate;
    }
    NSLog(@"房型ID: %@",self.roomTypeID);
    [[LYZNetWorkEngine sharedInstance] getRoomPriceWithCheckInDate:model.continueDate checkOutDate:outDate roomTypeID:roomtypeId block:^(int event, id object) {
        if (event == 1) {
            GetRoomPriceResponse *response = (GetRoomPriceResponse *)object;
            self.priceInfo = response.roomPriceInfo;
            PreFillCouponModel *preCoupon = [[PreFillCouponModel alloc] init];
            preCoupon.coupondetatilid =  self.priceInfo.coupondetatilid;
            preCoupon.coupontype =  self.priceInfo.coupontype;
            preCoupon.coupondiscount =  self.priceInfo.coupondiscount;
            preCoupon.coupondenominat =  self.priceInfo.coupondenominat;
            preCoupon.couponName = self.priceInfo.couponName;
            self.couponModel = preCoupon;
//            [self reloadRoomInfoCell];
            [self createDataSource];
             [self countRenewMoney];
        }else{
            [Public showJGHUDWhenError:self.view msg:object];
        }
        
    }];
}

//Deprecated
-(void)reloadRoomInfoCell{
    LYZRefillGuestInfoModel *model = self.localGuestInfoModel[0];
    NSString *outDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    if ([model.renewDate isEqualToString:model.continueDate]) {
        NSDate * endDate =[[formatter  dateFromString:model.continueDate] dateByAddingDays:1];
        outDate = [formatter stringFromDate:endDate];
    }else{
        outDate = model.renewDate;
    }
    NSDictionary *dic;
     NSString *isExact = [[formatter dateFromString:outDate] daysAfterDate:[formatter dateFromString:model.continueDate]] == 1 ? @"Y":@"N";
    if (self.roomInfo && !self.priceInfo) {
        dic = @{@"roomInfo":self.roomInfo, @"price":self.roomInfo.price, @"vipprice":self.roomInfo.vipprice,@"exact":isExact};
    }else if (self.roomInfo && self.priceInfo){
        dic = @{@"roomInfo":self.roomInfo, @"price":self.priceInfo.minPrice, @"vipprice":self.priceInfo.vipMinPrice,@"exact":isExact};
    }
    
    [self.adapters replaceObjectAtIndex:2 withObject:[LYZRenewRoomTypeCell dataAdapterWithData:dic cellHeight:LYZRenewRoomTypeCell.cellHeight]];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
}

//-(void)getOrderDetail{
//    [[LYZNetWorkEngine sharedInstance] getOrderDetailWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType orderNo:self.orderNo orderType:self.orderType block:^(int event, id object) {
//        if (event == 1) {
//            GetOrderDetailResponse *response = (GetOrderDetailResponse *)object;
//            LYLog(@"the response is %@",response.baseOrderDetail);
//            self.orderDetailModel = response.baseOrderDetail;
//            [self createDataSource];
//          
//        }else{
//            [Public showJGHUDWhenError:self.view msg:object];
//        }
//    }];
//     
//}


-(void)getRefillLiveUsers{

    __block NSString *roomTypeid = self.roomTypeID;
    
    [[LYZNetWorkEngine sharedInstance] getRefillLiveUser:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:[LoginManager instance].appUserID orderNO:self.orderNo orderType:self.orderType block:^(int event, id object) {
        if (event == 1) {
            GetRefillLiveUserResponse *response = (GetRefillLiveUserResponse *)object;
            LYLog(@"%@",response);
            self.refillUsers = response.baseRefillModel.childOrderInfoJar;
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            //            NSDateFormatter *formatter_1  = [[NSDateFormatter alloc] init];
            //            [formatter_1 setDateFormat:@"MM月dd日"];
            NSMutableArray *temp = [NSMutableArray array];
            for (int i = 0; i < self.refillUsers.count ;  i ++) {
                RefillInfoModel *refillModel = self.refillUsers[i];
                LYZRefillGuestInfoModel *model = [[LYZRefillGuestInfoModel alloc] init];
                model.isSelect = refillModel.isSelect;
                model.roomNum = refillModel.roomNum;
                model.liveUserName = refillModel.liveUserName;
                model.childOrderId = refillModel.childOrderId;
                model.index = i;
                model.continueDate = refillModel.continueDate;
                NSDate *renewDate = nil;
                NSDate *checkoutDate = [formatter dateFromString:refillModel.continueDate];
                if (model.isSelect) {
                    renewDate = [checkoutDate dateByAddingDays:1];
                }else{
                    renewDate = checkoutDate;
                }
                model.renewDate = [formatter stringFromDate:renewDate];
                [temp addObject:model];
            }
            self.localGuestInfoModel = temp;
//            PreFillCouponModel *preCoupon = [[PreFillCouponModel alloc] init];
//            preCoupon.coupondetatilid = response.baseRefillModel.coupondetatilid;
//            preCoupon.coupontype = response.baseRefillModel.coupontype;
//            preCoupon.coupondiscount = response.baseRefillModel.coupondiscount;
//            preCoupon.coupondenominat = response.baseRefillModel.coupondenominat;
//            self.couponModel = preCoupon;
            [self createDataSource];
            [self getRoomPrice:self.roomTypeID];
        }else{
            LYLog(@"%@",object);
        }
    }];
}

-(void)countRenewMoney{
    //生成数据模型
    NSMutableArray *checkInsArray = [NSMutableArray array];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
//    NSDateFormatter *formatter_1  = [[NSDateFormatter alloc] init];
//    [formatter_1 setDateFormat:@"MM月dd日"];
    
    if (self.localGuestInfoModel) {
        for (int i = 0; i < self.localGuestInfoModel.count; i ++) {
            LYZRefillGuestInfoModel *model =self.localGuestInfoModel[i] ;
            if([model isKindOfClass:[LYZRefillGuestInfoModel class]]){
                if (model.isSelect) {
                    if (model.childOrderId) {
                        NSDictionary *dict = @{@"childOrderId":model.childOrderId,@"newContinueDate":model.renewDate,@"oldContinueDate":model.continueDate};
                        [checkInsArray addObject:dict];
                    }
                }
            }

        }
        if (checkInsArray.count) {
            NSArray *checkIns = [NSArray arrayWithArray:checkInsArray];
            NSString *couponID = self.couponModel.coupondetatilid ?: @"";
            [[LYZNetWorkEngine sharedInstance] countRefillLiveMoneyWithChildOrderIds:checkIns couponID:couponID block:^(int event, id object) {
                if (event == 1) {
                    CountRefillLiveMoneyResponse *response = (CountRefillLiveMoneyResponse *)object;
                    self.refillMoneyModel = response.refillModel;
                    [GCDQueue executeInMainQueue:^{
                        [self updateMoneyWithModel:self.refillMoneyModel];
                    }];
                    
                }else{
                    [Public showJGHUDWhenError:self.view msg:object];
                }
            }];
        }else{
            [self resetBottomMoneyDetail];
        }
    }
}


-(void)createDataSource{
    if (!self.adapters) {
        self.adapters = [NSMutableArray array];
    }
    if (self.adapters.count > 0) {
        [self.adapters removeAllObjects];
    }
    [_adapters addObject:[LYZRenewHotelNameCell dataAdapterWithData:self.roomInfo cellHeight:LYZRenewHotelNameCell.cellHeight]];
    [_adapters addObject:[self lineType:kShortType height:0.5]];
    NSDictionary *dic;
    if (self.localGuestInfoModel) {
        LYZRefillGuestInfoModel *model = self.localGuestInfoModel[0];
        NSString *outDate;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        if ([model.renewDate isEqualToString:model.continueDate]) {
            NSDate * endDate =[[formatter  dateFromString:model.continueDate] dateByAddingDays:1];
            outDate = [formatter stringFromDate:endDate];
        }else{
            outDate = model.renewDate;
        }
        NSString *isExact = [[formatter dateFromString:outDate] daysAfterDate:[formatter dateFromString:model.continueDate]] == 1 ? @"Y":@"N";
        if (self.roomInfo && !self.priceInfo) {
            dic = @{@"roomInfo":self.roomInfo, @"price":self.roomInfo.price, @"vipprice":self.roomInfo.vipprice,@"exact":isExact};
        }else if (self.roomInfo && self.priceInfo){
            dic = @{@"roomInfo":self.roomInfo, @"price":self.priceInfo.minPrice, @"vipprice":self.priceInfo.vipMinPrice,@"exact":isExact};
        }
    }
    
    [_adapters addObject:[LYZRenewRoomTypeCell dataAdapterWithData:dic cellHeight:LYZRenewRoomTypeCell.cellHeight]];
    [_adapters addObject:[OrderCommitNoTraceCell dataAdapterWithData:nil cellHeight:OrderCommitNoTraceCell.cellHeight]];
    [_adapters addObject:[self lineType:kSpace height:15.0]];
    for (int i = 0; i < self.refillUsers.count; i ++) {
//        RefillInfoModel *refillModel = self.refillUsers[i];
//        LYZRefillGuestInfoModel *localrefillModel = self.localGuestInfoModel[i];
//        if (localrefillModel.renewDate == refillModel.checkOutDate) {
//            localrefillModel.isOriginDate = YES;
//        }else{
//            localrefillModel.isOriginDate = NO;
//        }
        [_adapters addObject:[LYZRenewGuestInfoCell dataAdapterWithData:self.localGuestInfoModel[i] cellHeight:LYZRenewGuestInfoCell.cellHeight]];
        if (i == self.refillUsers.count - 1) {
            break;
        }
        [_adapters addObject:[self lineType:kLongType height:0.5]];
    }
    [_adapters addObject:[self lineType:kSpace height:15.0]];
    

    [_adapters addObject:[OrderCommitCouponCell dataAdapterWithData:self.couponModel cellHeight:OrderCommitCouponCell.cellHeight]];
    [_adapters addObject:[self lineType:kSpace height:15]];
    [_adapters addObject:[OrderCommitChooseInvoiceCell dataAdapterWithData:self.invoiceModel cellHeight:OrderCommitChooseInvoiceCell.cellHeight]];
    if (self.needInvoice) {
        [self.adapters addObject:[self lineType:kLongType height:0.5]];
        [self.adapters addObject:[OrderCommitInvoiceInfoCell dataAdapterWithData:self.invoiceModel cellHeight:[OrderCommitInvoiceInfoCell cellHeightWithData:self.invoiceModel]]];
    }
    [self.adapters addObject:[OrderCommitNoticeCell dataAdapterWithData:nil cellHeight:OrderCommitNoticeCell.cellHeight]];
    [GCDQueue executeInMainQueue:^{
        [self.tableView reloadData];
    }];
}

#pragma mark - UITableView related.

- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {
    if (type == kSpace) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" :LYZTheme_BackGroundColor} cellHeight:15.f];
        
    } else if (type == kLongType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :[UIColor colorWithHexString:@"E8E8E8"]} cellHeight:0.5f];
        
    } else if (type == kShortType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" : [UIColor colorWithHexString:@"E8E8E8"], @"leftGap" : @(25.f)} cellHeight:0.5f];
        
    } else {
        return nil;
    }
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
    
}

#pragma mark - Btn Acitons

-(void)showPaymentDetail{
    if ([_paymentDetailView superview]) {
        [_paymentDetailView dismiss];
    }else{
        [self.paymentDetailView configureWithRenewMoneyModel:self.refillMoneyModel];
        [self.view insertSubview:self.paymentDetailView belowSubview:self.floatView];
    }
}

-(void)payBtnClick:(id)sender{
//    [self generateOrderForm];

    BOOL haveSelect = NO;
    for (LYZRefillGuestInfoModel *model in self.localGuestInfoModel) {
        if (model.isSelect) {
            haveSelect = YES;
            break;
        }
    }
    if (haveSelect) {
        //如果订单存在,则删掉该订单
        if (self.renewOrder) {
            [[LYZNetWorkEngine sharedInstance] deleteOrder:VersionCode devicenum:DeviceNum fromtype:FromType orderNO:self.renewOrder orderType: [NSString stringWithFormat:@"%@",self.renewOrderType] block:^(int event, id object) {
                if (event == 1) {
                    self.renewOrder = nil;
                    [self generateOrderForm];
                }else if (event == 19){
                    DeleteOrderResponse *response = (DeleteOrderResponse *)object;
                    YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:response.msg delegate:self buttonTitles:@"知道了",nil];
                    [alert Show];
                    
                }else{
                    WEAKSELF;
                    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                        
                        if(buttonIndex == 1){
                            [weakSelf.tabBarController setSelectedViewController:weakSelf.tabBarController.viewControllers[1]];
                        }
                    } title:@"提示信息" message:@"您的订单已经存在，请前往查看您的入住信息" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
                    return;
                }
            }];
        }else{
            [self generateOrderForm];
        }

        
    }else{
        [Public showJGHUDWhenError:self.view msg:@"请至少选择一个续住人"];
    }
    
}

-(void)generateOrderForm{
    //生成数据模型
    NSMutableArray *checkInsArray = [NSMutableArray array];
    for (int i = 0; i < self.localGuestInfoModel.count; i ++) {
        LYZRefillGuestInfoModel *model =self.localGuestInfoModel[i] ;
        if([model isKindOfClass:[LYZRefillGuestInfoModel class]]){
            if (model.isSelect) {
                
                if ( model.childOrderId) {
                    NSDictionary *dict = @{@"childOrderId":model.childOrderId,@"oldContinueDate":model.continueDate,@"newContinueDate":model.renewDate};
                    [checkInsArray addObject:dict];
                }
            }
        }
    }
    NSArray *checkIns = [NSArray arrayWithArray:checkInsArray];
    NSString *invoiceType;
    NSDictionary *invoiceInfo;
    OrderInvoiceModel *invoiceModel = self.invoiceModel;
    if(invoiceModel.type == OrderInvoiceType_none){
        invoiceType = @"0";
    }
    if(invoiceModel.type == OrderInvoiceType_Paper){
        invoiceType = @"2";
        NSString *invoiceDetails = invoiceModel.detail;
        NSString *invoiceremark = invoiceModel.invoiceremark;
        NSString *invoiceLookupID = invoiceModel.title.lookUpID;
        NSString *addressID = invoiceModel.recieverInfo.invoiceAddressID;
        NSString *mailType = @"2";
        NSString *email = @"";
        
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
        
        [infoDict setValue:invoiceDetails forKey:@"invoiceDetail"];
        [infoDict setValue:invoiceremark forKey:@"invoiceremark"];
        [infoDict setValue:invoiceLookupID forKey:@"invoiceLookupId"];
        [infoDict setValue:addressID forKey:@"invoiceAddressId"];
        [infoDict setValue:mailType forKey:@"mailType"];
        [infoDict setValue:email forKey:@"email"];
        invoiceInfo = [NSDictionary dictionaryWithDictionary:infoDict];
    }
    if(invoiceModel.type == OrderInvoiceType_Electronic){
        
        invoiceType = @"1";
        NSString *invoiceDetails = invoiceModel.detail;
        NSString *invoiceLookupID = invoiceModel.title.lookUpID;
        NSString *addressID = invoiceModel.recieverInfo.invoiceAddressID;
        NSString *mailType = @"1";
        NSString *email = @"";//TODO: 电子发票暂未开放
        
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
        
        [infoDict setValue:invoiceDetails forKey:@"invoiceDetail"];
        [infoDict setValue:invoiceLookupID forKey:@"invoiceLookupId"];
        [infoDict setValue:addressID forKey:@"invoiceAddressId"];
        [infoDict setValue:mailType forKey:@"mailType"];
        [infoDict setValue:email forKey:@"email"];
         invoiceInfo = [NSDictionary dictionaryWithDictionary:infoDict];
    }
    
    //创建订单
    NSString *appUserId = [LoginManager instance].appUserID;
    if (!appUserId) {
        appUserId = @"";
    }
   
    JGProgressHUD *hud = [Public hudWhenRequest];
    [hud showInView:self.view];
    NSString *track = _isTrack ?@"1":@"0";
    NSString *couponID = self.couponModel.coupondetatilid?:@"";
    [[LYZNetWorkEngine sharedInstance] commitRefillLiveOrderWithPhone:self.phone invoiceType:invoiceType invoiceInfo:invoiceInfo childOrderIds:checkIns isOpenPrivacy:track couponID:couponID block:^(int event, id object) {
        [hud dismissAnimated:YES];
        if (event == 1) {
            CommitRefillLiveOrderResponse *response = (CommitRefillLiveOrderResponse *)object;
            CreateRenewModel *renewOrderModel = response.renewOrder;
            self.renewOrder = renewOrderModel.orderNO;
            self.renewOrderType = renewOrderModel.orderType;
            
            //防止请求订单状态时候出现续住订单再续住时出现 传错订单号问题 （正确的应该传续住再续住生成的订单号）
            
            self.forRequestOrderStatus_orderNo = self.renewOrder;
            self.forRequestOrderStatus_orderType = [NSString stringWithFormat:@"%@",self.renewOrderType];
            
            if ([_paymentDetailView superview]) {
                [_paymentDetailView dismiss];
            }
            [GCDQueue executeInMainQueue:^{
                AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UIWindow *keyWindow  = delegate.window;
                [keyWindow addSubview:self.alphaBlackView];
                [keyWindow addSubview:self.moneyDetailView];
                [UIView animateWithDuration:0.3 animations:^{
                    self.alphaBlackView.alpha = 0.5;
                    self.moneyDetailView.frame = CGRectMake(0,SCREEN_HEIGHT - kMoneyDetalViewHeight, SCREEN_WIDTH,  kMoneyDetalViewHeight);
                } completion:^(BOOL finished) {
                }];
                
            }];
        }else if(event == 15){
            CommitRefillLiveOrderResponse *response = (CommitRefillLiveOrderResponse *)object;
            self.existRenewOrder = response.renewOrder;
            NSString *title = @"发现您还有一个待支付订单";
            NSString *content                     = @"您可以查看待支付订单并支付，继续支付将删除原待支付订单";
            NSArray  *buttonTitles                =  @[AlertViewNormalStyle(@"查看订单"), AlertViewRedStyle(@"继续支付")] ;
            AlertViewMessageObject *messageObject = MakeAlertViewMessageObject(title,content, buttonTitles);
            [AlertView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag: kPayAlertTag];
            
        }else if(event == 100){
            CommitRefillLiveOrderResponse *response = (CommitRefillLiveOrderResponse *)object;
            YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:response.msg delegate:self buttonTitles:@"知道了",nil];
            [alert Show];
        }else if(event == 102){
            CommitRefillLiveOrderResponse *response = (CommitRefillLiveOrderResponse *)object;
            YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:response.msg delegate:self buttonTitles:@"知道了",nil];
            [alert Show];
        }else{
            YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:object delegate:self buttonTitles:@"知道了",nil];
            [alert Show];
//            [Public showJGHUDWhenError:self.view msg:object];
            //            LYLog(@"failure! object:%@",object);
        }
    }];
    
    
   
}

#pragma mark - BaseMessageViewDelegate

- (void)baseMessageView:(__kindof BaseMessageView *)messageView event:(id)event {
    
    NSLog(@"%@, tag:%ld event:%@", NSStringFromClass([messageView class]), (long)messageView.tag, event);
    if (messageView.tag == kPayAlertTag) {
        if ([event isEqualToString:@"查看订单"]) {
            LYZOrderFormViewController *orderForm = [LYZOrderFormViewController new];
            orderForm.orderType =[NSString stringWithFormat:@"%@",self.existRenewOrder.orderType] ;
            orderForm.orderNo = self.existRenewOrder.orderNO;
            [self.navigationController pushViewController:orderForm animated:YES];
        }else if ([event isEqualToString:@"继续支付"]){
            [[LYZNetWorkEngine sharedInstance] deleteOrder:VersionCode devicenum:DeviceNum fromtype:FromType orderNO:self.existRenewOrder.orderNO orderType:@"2" block:^(int event, id object) {
                if (event == 1) {
                    [self generateOrderForm];
                }else if (event == 19){
                    DeleteOrderResponse *response = (DeleteOrderResponse *)object;
                    YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:response.msg delegate:self buttonTitles:@"知道了",nil];
                    [alert Show];
                    
                }else{
                    WEAKSELF;
                    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                        if(buttonIndex == 1){
                            [weakSelf.tabBarController setSelectedViewController:weakSelf.tabBarController.viewControllers[1]];
                        }
                    } title:@"提示信息" message:@"您的订单已经存在，请前往查看您的入住信息" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
                    return;
                }
            }];
        }
    }else if (messageView.tag == kRenewCalendarTag){
        NSArray *arr = (NSArray *)event;
        NSDate *endDate =  [arr lastObject];
        LYZRefillGuestInfoModel *model = self.localGuestInfoModel[self.selectedRenewIndex];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
        [formatter setDateFormat:@"yyyy-MM-dd"];
        model.renewDate =  [formatter stringFromDate:endDate];
        //
        [[LYZNetWorkEngine sharedInstance]  getValidRoomAmount:VersionCode devicenum:DeviceNum fromtype:FromType checkInTime:model.continueDate checkOutTime:model.renewDate hotelRoomID:self.roomTypeID block:^(int event, id object) {
            if (event == 1) {
                
            }else if (event == 100){
                GetValidRoomAmountResponse *response = (GetValidRoomAmountResponse *)object;
                YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:response.msg delegate:self buttonTitles:@"知道了",nil];
                [alert Show];
            }else{
                YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:object delegate:self buttonTitles:@"知道了",nil];
                [alert Show];
            }}];
        
        [self countRenewMoney];
        [self createDataSource];
        [self getRoomPrice:self.roomTypeID];
    }
    [messageView hide];
}


-(void)phoneBtnClick:(id)sender{
    [LYZPhoneCall noAlertCallPhoneStr:CustomerServiceNum withVC:self];
}



-(void)dissMissRoomCountView{
    [UIView animateWithDuration:0.5 animations:^{
        self.alphaBlackView.alpha = 0;
        
        if (_moneyDetailView) {
            self.moneyDetailView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, self.moneyDetailViewHeight);
        }
    } completion:^(BOOL finished) {
        if (self.alphaBlackView.superview) {
            [_alphaBlackView removeFromSuperview];
        }
       
        if (self.moneyDetailView.superview) {
            [_moneyDetailView removeFromSuperview];
        }
    }];
}


#pragma mark - Cell Btn Actions


-(void)chooseCoupon{
    CouponViewController *vc = [[CouponViewController alloc] init];
    //TODO: 传入价格参数
    vc.price = self.priceInfo.realPrice;
    WEAKSELF;
    vc.couponCallBack = ^(id coupon){
        if (!coupon) {
            PreFillCouponModel *prefill = [[PreFillCouponModel alloc] init];
            prefill.coupontype = @4;
            weakSelf.couponModel = prefill;
            [weakSelf createDataSource];
        }else{
            CouponModel *model = (CouponModel *)coupon;
            PreFillCouponModel *prefill = [[PreFillCouponModel alloc] init];
            prefill.coupondetatilid = model.couponID;
            prefill.coupondenominat = model.denominat;
            prefill.coupontype = model.coupontype;
            prefill.coupondiscount = model.discount;
            prefill.couponName = model.name;
            weakSelf.couponModel = prefill;
            [weakSelf createDataSource];
        }
        [weakSelf countRenewMoney];
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(void)needInvoice:(BOOL)need{
    self.needInvoice = need;
    if (self.needInvoice) {
        //push to invoice view
        LYZInvoiceViewController *vc = [[LYZInvoiceViewController alloc] init];
        vc.popBlock = ^(OrderInvoiceModel *model){
            self.invoiceModel = model;
            [self createDataSource];
        };
        vc.callback = ^(){
            self.needInvoice = NO;
            OrderInvoiceModel *orderInvoice = [[OrderInvoiceModel alloc] init];
            orderInvoice.type = OrderInvoiceType_none;
            self.invoiceModel = orderInvoice;
            [self createDataSource];
        };
        if (self.invoiceModel.type != OrderInvoiceType_none) {
            vc.invoiceModel = self.invoiceModel;
        }
        [self.navigationController pushViewController:vc animated:YES];
        LYLog(@"---->choose a  invoice %i",need);
    }else{
        self.invoiceModel.type = OrderInvoiceType_none;
        [self createDataSource];
    }

}


-(void)renewBtnSelect:(NSInteger )index{
    LYZRefillGuestInfoModel *model = self.localGuestInfoModel[index];
    model.isSelect = !model.isSelect;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
//    NSDateFormatter *formatter_1  = [[NSDateFormatter alloc] init];
//    [formatter_1 setDateFormat:@"MM月dd日"];
    RefillInfoModel *refillModel = self.refillUsers[model.index];
    if (!model.isSelect) {
        NSDate *originDate = [formatter dateFromString:refillModel.continueDate];
        model.renewDate = [formatter stringFromDate:originDate];
    }else{
        NSDate *originDate = [formatter dateFromString:refillModel.continueDate];
        model.renewDate = [formatter stringFromDate:[originDate dateByAddingDays:1]];
    }
    [self createDataSource];
    [self countRenewMoney];
}


-(void)trackSwitch:(BOOL)isOn{
    self.isTrack = isOn;
}

-(void)datePick:(NSInteger) index{
    self.selectedRenewIndex = index;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
     RefillInfoModel *originalModel = self.refillUsers[index];
    RenewCalendarMessageObject *object =MakeRenewCalendarViewObject([formatter dateFromString:originalModel.continueDate]);
     [RenewCalendar showManualHiddenMessageViewInKeyWindowWithMessageObject:object delegate:self viewTag:kRenewCalendarTag];
}

//-(void)datePick:(NSInteger) index{
//    LYZSingleCalenderViewController *vc = [[LYZSingleCalenderViewController alloc] init];
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
//    [formatter setDateFormat:@"yyyy-MM-dd"];
//    LYZRefillGuestInfoModel *model = self.localGuestInfoModel[index];
//    RefillInfoModel *originalModel = self.refillUsers[index];
//    vc.enableDate = [[formatter dateFromString:originalModel.continueDate] dateByAddingDays:1];
//    model.isSelect = YES;
//
//    vc.optionCalederBlock = ^(NSDate *date){
//        if ([IICommons compareOneDay:date withAnotherDay:[formatter dateFromString:originalModel.checkOutDate]] <=  0) {
//
//            JGProgressHUD *hud =  [Public hudWhenSuccessWithMsg:@"请选择正确续住时间"];
//            [hud showInView:self.view];
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [hud dismissAnimated:YES];
//                return ;
//            });
//
//        }
//        model.renewDate = [formatter stringFromDate:date];
//        [self createDataSource];
//        [self countRenewMoney];
//
//
//    };
//    [self presentViewController:vc animated:YES completion:^{
//
//    }];
//
//}

#pragma mark - Third Pay delegate

- (void)weixinPay:(BOOL)isSuccess
{
    if(isSuccess){
        
        JGProgressHUD *hud  = [Public hudWhenSuccess];
        hud.textLabel.text = @"支付成功！";
        [hud showInView:self.view];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [hud dismissAnimated:YES];
            [self dissMissRoomCountView];
            LYZPayScuessViewController *payVC = [[LYZPayScuessViewController alloc] init];
            payVC.orderNumber = self.renewOrder;
            payVC.orderType = [NSString stringWithFormat:@"%@", self.renewOrderType];
            [self.navigationController pushViewController:payVC animated:YES];
            
        });
        
    }else{
        JGProgressHUD *hud  = [Public hudWHenFailure];
        hud.textLabel.text = @"支付失败！";
        [hud showInView:self.view];
        [hud dismissAfterDelay:2.0 animated:YES];
    }
}

- (void)zhifubaoPay:(BOOL)isSuccess
{
    if(isSuccess){
        
        JGProgressHUD *hud  = [Public hudWhenSuccess];
        hud.textLabel.text = @"支付成功！";
        [hud showInView:self.view];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [hud dismissAnimated:YES];
            [self dissMissRoomCountView];
            LYZPayScuessViewController *payVC = [[LYZPayScuessViewController alloc]init];
            payVC.orderNumber = self.renewOrder;
            payVC.orderType = [NSString stringWithFormat:@"%@",self.renewOrderType];
            [self.navigationController pushViewController:payVC animated:YES];
            
        });
        
    }else{
        JGProgressHUD *hud  = [Public hudWHenFailure];
        hud.textLabel.text = @"支付失败！";
        [hud showInView:self.view];
        
        [hud dismissAfterDelay:2.0 animated:YES];
    }
}

-(void)checkVxPaySuccess:(NSNotification *)noti{
    //获取订单状态
    [[LYZNetWorkEngine sharedInstance] getOrderDetailWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType orderNo:self.forRequestOrderStatus_orderNo orderType:self.forRequestOrderStatus_orderType block:^(int event, id object) {
        if (event == 1) {
            GetOrderDetailResponse *response = (GetOrderDetailResponse *)object;
            LYLog(@"the response is %@",response.baseOrderDetail);
            if (response.baseOrderDetail.orderJson.childStatus.integerValue == 1) {
                JGProgressHUD *hud  = [Public hudWhenSuccess];
                hud.textLabel.text = @"支付成功！";
                [hud showInView:self.view];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [hud dismissAnimated:YES];
                    [self dissMissRoomCountView];
                    LYZPayScuessViewController *payVC = [[LYZPayScuessViewController alloc] init];
                    payVC.orderNumber = self.orderNo;
                    payVC.orderType =  self.orderType;
                    [self.navigationController pushViewController:payVC animated:YES];
                    
                });
            }else{
                
            }
        }else{
            LYLog(@"这都请求不到。。。。渣渣");
        }
    }];
}



@end
