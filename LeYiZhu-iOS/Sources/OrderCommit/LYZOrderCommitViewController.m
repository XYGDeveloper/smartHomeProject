 //
//  LYZOrderCommitViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/2.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZOrderCommitViewController.h"
#import "ColorSpaceCell.h"
#import "OrderCommitHotelNameCell.h"
#import "OrderCommitRoomInfoCell.h"
#import "OrderCommitDateCell.h"
#import "OrderCommitRoomCountCell.h"
#import "OrderCommitGuestInfoCell.h"
#import "OrderCommitPhoneCell.h"
#import "OrderCommitInvoiceInfoCell.h"
#import "OrderCommitNoTraceCell.h"
#import "OrderCommitNoticeCell.h"
#import "LYZOrderCommitRoomInfoModel.h"
#import "LYZOrderGuestInfoModel.h"
#import "OrderInvoiceModel.h"
#import "OrderCommitChooseInvoiceCell.h"
#import "OrderInvoiceModel.h"
#import "LYZContactsModel.h"
#import "OrderPreFillModel.h"

#import "NSDate+Utilities.h"
#import "LoginManager.h"
#import "Public+JGHUD.h"
#import "NSDate+Utilities.h"
#import "YQAlertView.h"
#import "LYZChooseGuestViewController.h"
#import "AddNewContactViewController.h"
#import "ChooseRoomCountView.h"
#import "LYZInvoiceViewController.h"
#import "AppDelegate.h"
//#import "OrderCommitMoneyDetailView.h"
#import "NSDictionary+YYAdd.h"
#import "NSArray+YYAdd.h"
#import "NSDate+Formatter.h"
#import "GCD.h"
#import "LYZPayScuessViewController.h"
#import "LYZCalederViewController.h"
#import <ContactsUI/ContactsUI.h>
#import "BaseNavController.h"
#import "ThirdPayManager.h"
#import "IICommons.h"
#import "UIAlertView+Block.h"

#import "LYZPhoneCall.h"
#import "AlertView.h"
#import "User.h"
#import "OrderCommitCouponCell.h"
#import "PreFillCouponModel.h"
#import "CouponViewController.h"
#import "CouponModel.h"
#import "UIViewController+BarButton.h"
#import "Calendar.h"
#import "PaymentView.h"
#import "UIView+SetRect.h"
#import "PaymentDetailView.h"
#import "RoomPriceInfo.h"
#import "LYZHotelWarmCell.h"
#import "LSTimeSlot.h"
#import "LYZAlertCellTableViewCell.h"
#define kPaymentViewHeightYScale 0.417
#define kRoomCountViewHeight 169.f
#define kMoneyDetalViewHeight (kPaymentViewHeightYScale * SCREEN_HEIGHT)

@interface LYZOrderCommitViewController () <UITableViewDelegate, UITableViewDataSource, CustomCellDelegate,CNContactPickerDelegate,BaseMessageViewDelegate,YQAlertViewDelegate>

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;

@property (nonatomic, strong) LYZOrderGuestInfoModel *guestInfoModel;//入住人信息
@property (nonatomic,strong) OrderInvoiceModel *invoiceModel;
@property (nonatomic, strong) CountMoneyModel *countMoneyModel;
@property (nonatomic, strong) PreFillCouponModel *prefillCoupon;
@property (nonatomic, strong) LYZHotelRoomDetailModel *roomInfo;
@property (nonatomic, assign) BOOL needInvoice;

//bottom float View
@property(nonatomic, strong) UILabel *totalPriceLabel;
@property(nonatomic, strong) UILabel *depositLabel;

@property(nonatomic, strong) ChooseRoomCountView *roomCountView;
@property(nonatomic, strong) UIView *alphaBlackView;//选择房间数时弹出
//@property(nonatomic, strong)OrderCommitMoneyDetailView *moneyDetailView;
@property (nonatomic, strong) PaymentView *paymentView;
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, strong) NSString *orderType;

@property (nonatomic, strong) createOrderModel *existOrderModel;

//@property (nonatomic, assign) BOOL hasPriFillData;

@property (nonatomic, strong) NSArray * firstDate;

@property (nonatomic, strong) NSArray * lastDate;

@property (nonatomic, strong) NSArray * singleDate;

@property (nonatomic ,assign) BOOL hasTrack;

@property (nonatomic, strong)UIView *floatView; //底部支付栏

@property (nonatomic, strong) PaymentDetailView *paymentDetailView;

@property (nonatomic, strong) RoomPriceInfo *priceInfo;

@end

@implementation LYZOrderCommitViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"订单填写";
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkVxPaySuccess:) name:kNotificationCheckVxPaySuccess object:nil];
    AppDelegate *dele = (AppDelegate*)[UIApplication sharedApplication].delegate;
    dele.orderDetailVC = self;
    _needInvoice = NO;
    _hasTrack = NO;
 
    [self setup];
    
}

- (void)setup {
    [self setRightNav];
    // fake data
    [self defaultData];
    [self createTableViewAndRegisterCells];
    [self createBottomFloatView];
     [self fetchPreFillData];
      [self getRoomInfo];
     [self getValidRoomCountWithCheckInDate:[self.checkInDate dateWithFormat:@"yyyy-MM-dd"] checkOutDate:[self.checkOutDate dateWithFormat:@"yyyy-MM-dd"]];
}

-(void)setRightNav{
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

-(void)defaultData{
    
    if (!self.checkInDate || !self.checkInDate ) {
        if ([self isBetweenFromHour:0 toHour:6]) {
            self.checkInDate = [NSDate  dateYesterday];
            self.checkOutDate = [NSDate date];
        }else{
            self.checkInDate = [NSDate date];
            self.checkOutDate = [NSDate dateTomorrow];
        }
    }

    LYZOrderGuestInfoModel *guestInfo = [[LYZOrderGuestInfoModel alloc] init];
    guestInfo.roomCount = @"1";
    LYZContactsModel *contactModel1 = [[LYZContactsModel alloc] init];
    contactModel1.name = @"";
    guestInfo.guests = @[contactModel1];
    if ([LoginManager instance].appUserID) {
        guestInfo.phoneNum = [LoginManager instance].userInfo.phone;
    }else{
        guestInfo.phoneNum = @"";
    }
    self.guestInfoModel = guestInfo;
    OrderInvoiceModel *orderInvoice = [[OrderInvoiceModel alloc] init];
    orderInvoice.type = OrderInvoiceType_none;
    self.invoiceModel = orderInvoice;
    
    self.prefillCoupon = [[PreFillCouponModel alloc] init];
}

-(void)getValidRoomCountWithCheckInDate:(NSString *)checkInTime checkOutDate:(NSString *)checkOutTime{
    if (!checkInTime || !checkOutTime) {
        checkInTime = [[NSDate date] dateWithFormat:@"yyyy-MM-dd"];
        checkOutTime = [[[NSDate date] dateByAddingDays:1] dateWithFormat:@"yyyy-MM-dd"];
    }
    [[LYZNetWorkEngine sharedInstance]  getValidRoomAmount:VersionCode devicenum:DeviceNum fromtype:FromType checkInTime:checkInTime checkOutTime:checkOutTime hotelRoomID:self.roomTypeID block:^(int event, id object) {
        if (event == 1) {
            GetValidRoomAmountResponse *response = (GetValidRoomAmountResponse *)object;
            NSDictionary *count = response.roomCout;
            NSNumber *roomsize = [count objectForKey:@"validRoomSize"];
            self.roomCountView.roomCount = roomsize.integerValue > 0 ? roomsize.integerValue : 0;
            }else if (event == 100){
            GetValidRoomAmountResponse *response = (GetValidRoomAmountResponse *)object;
                YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:response.msg delegate:self buttonTitles:@"知道了",nil];
                [alert Show];
                self.roomCountView.roomCount = 0;
            }else{
            YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:object delegate:self buttonTitles:@"知道了",nil];
            [alert Show];
        }}];
}

-(void)countMoney{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *checkIn_str = [formatter stringFromDate:self.checkInDate];
    NSString *checkOut_str = [formatter stringFromDate:self.checkOutDate];
    NSString *payNum = self.guestInfoModel.roomCount; //几个人
    NSString *couponID = self.prefillCoupon.coupondetatilid ? :@"";

   [[LYZNetWorkEngine sharedInstance] countMoneyWithRoomTypeID:self.roomTypeID payNum:payNum checkInDate:checkIn_str checkOutDate:checkOut_str  coupondetatilid:couponID block:^(int event, id object) {
       if(event == 1){
           CountMoneyResponse *countMoneyResponse = (CountMoneyResponse*)object;
           CountMoneyModel *moneyModel = countMoneyResponse.countMoney;
           self.countMoneyModel = moneyModel;
           [GCDQueue executeInMainQueue:^{
               [self updateMoneyWithModel:moneyModel];
             
           }];
           LYLog(@"countMoney success : %@" , object);
       }else{
           LYLog(@"countMoney failure: %@" , object);
           [Public showJGHUDWhenError:self.view msg:object];
       }
   }];
}

-(void)getRoomInfo{
    [[LYZNetWorkEngine sharedInstance] getHotelRoomDetailWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType roomID:self.roomTypeID block:^(int event, id object) {
        if (event == 1) {
            GetHotelRoomDetailsResponse *response = (GetHotelRoomDetailsResponse*)object;
            self.roomInfo = response.hotelRoomDetail;
            [self createDataSource];
            [self getRoomPrice];//获取到roomTypeID后再获取价格
        }else{
            [Public showJGHUDWhenError:self.view msg:object];
        }
    }];
}

-(void)getRoomPrice{
    [[LYZNetWorkEngine sharedInstance] getRoomPriceWithCheckInDate:[self.checkInDate dateWithFormat:@"yyyy-MM-dd"] checkOutDate:[self.checkOutDate dateWithFormat:@"yyyy-MM-dd"] roomTypeID:self.roomInfo.roomTypeID block:^(int event, id object) {
        if (event == 1) {
            GetRoomPriceResponse *response = (GetRoomPriceResponse *)object;
          self.priceInfo = response.roomPriceInfo;
            PreFillCouponModel *prefillCoupon = [[PreFillCouponModel alloc] init];
            prefillCoupon.coupontype = self.priceInfo.coupontype;
            prefillCoupon.coupondetatilid = self.priceInfo.coupondetatilid;
            prefillCoupon.coupondenominat = self.priceInfo.coupondenominat;
            prefillCoupon.coupondiscount = self.priceInfo.coupondiscount;
            prefillCoupon.couponName = self.priceInfo.couponName;
            self.prefillCoupon = prefillCoupon;

//            [self reloadRoomInfoCell];
            [self countMoney];
            [self createDataSource];
        }else{
            [Public showJGHUDWhenError:self.view msg:object];
        }
        
    }];
}

-(void)fetchPreFillData{
    if (self.fromOrderNO) {
        //续住传过来的
        [[LYZNetWorkEngine sharedInstance] getOrderDetailWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType orderNo:self.fromOrderNO orderType:self.fromOrderType block:^(int event, id object) {
            if (event == 1) {
                GetOrderDetailResponse *response = (GetOrderDetailResponse *)object;
                LYLog(@"the response is %@",response.baseOrderDetail);
                BaseOrderDetailModel *orderDetailModel = response.baseOrderDetail;
                NSMutableArray *temp = [NSMutableArray array];
                for (int i = 0; i  < orderDetailModel.childOrderInfoJar.count; i ++) {
                    LYZContactsModel *model = [[LYZContactsModel alloc] init];
                    OrderCheckInsModel *checkinModel =  orderDetailModel.childOrderInfoJar[i];
                    model.name = checkinModel.liveUserName;
                    model.phone = checkinModel.liveUserPhone;
                    [temp addObject:model];
                }
                
                self.guestInfoModel.guests = [NSArray arrayWithArray:temp];
                self.guestInfoModel.roomCount = [NSString stringWithFormat:@"%@",orderDetailModel.orderJson.payNum];
                self.guestInfoModel.phoneNum = orderDetailModel.orderJson.phone;
               
                [self createDataSource];
            }else{
                LYLog(@"fail");
            }
        }];

        
    }else{
        //没有传值过来，即 不是续住等跳过来的
       
        [[LYZNetWorkEngine sharedInstance] preFillOrderBlock:^(int event, id object) {

            if (event == 1) {
                PreFilledOrderResponse *response = (PreFilledOrderResponse *)object;
                OrderPreFillModel *prefill = response.prefillModel;
                LYLog(@"the model  is %@",prefill);
                self.guestInfoModel.phoneNum = prefill.phone;
                LYZContactsModel *model = [[LYZContactsModel alloc] init];
                model.name = prefill.name;
                model.paperworkType = prefill.paperworkType;
                model.paperworkNum = prefill.paperworkNum;
                model.phone = prefill.livePhone;
                model.contactsID = prefill.liveUserId;
                
//                PreFillCouponModel *prefillCoupon = [[PreFillCouponModel alloc] init];
//                prefillCoupon.coupontype = prefill.coupontype;
//                prefillCoupon.coupondetatilid = prefill.coupondetatilid;
//                prefillCoupon.coupondenominat = prefill.coupondenominat;
//                prefillCoupon.coupondiscount = prefill.coupondiscount;
//                self.prefillCoupon = prefillCoupon;
                self.guestInfoModel.guests = @[model];
                self.guestInfoModel.roomCount = @"1";
//                [self countMoney];
                [self createDataSource];
            }else if (event == 2){
                //没有数据
                LYLog(@"no prefill data");
                   [self countMoney];
                return ;
            }else{
                [Public showJGHUDWhenError:self.view msg:object];
            }
        }];

    }
    
}

-(void)createBottomFloatView{
    self.floatView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT  - 60 - 64, SCREEN_WIDTH, 60)];
    self.floatView.backgroundColor = [UIColor whiteColor];
    self.floatView.layer.shadowOffset = CGSizeMake(0, 0);
    self.floatView.layer.shadowColor = LYZTheme_warmGreyFontColor.CGColor;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = kLineColor;
    [self.floatView addSubview:line];
  
    self.totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 0, SCREEN_WIDTH - 165, 35)]; //165 提交按钮宽度
    self.totalPriceLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:22];
    self.totalPriceLabel.textColor = LYZTheme_paleBrown;
    self.totalPriceLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.floatView addSubview:self.totalPriceLabel];
    
    self.depositLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, self.totalPriceLabel.bottom - 5,  SCREEN_WIDTH - 165, 25)];
    self.depositLabel.textColor = LYZTheme_greyishBrownFontColor;
    self.depositLabel.textAlignment = NSTextAlignmentLeft;
    self.depositLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:13.0f];
    [self.floatView addSubview:self.depositLabel];
    
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(SCREEN_WIDTH - 165, 0.5, 165, 59.5);
    [payBtn setBackgroundColor:LYZTheme_paleBrown];
    [payBtn setTitle:@"立即支付" forState:UIControlStateNormal];
    [payBtn addTarget:self action:@selector(payBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.floatView addSubview:payBtn];
 
    
    UIButton *paymentDetailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    paymentDetailBtn.frame = CGRectMake(0, 0, 80, 60);
    paymentDetailBtn.right = SCREEN_WIDTH - 165;
    paymentDetailBtn.y = 0;
    [paymentDetailBtn setTitle:@"金额明细" forState:UIControlStateNormal];
    paymentDetailBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:13];
    [paymentDetailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [paymentDetailBtn addTarget:self action:@selector(showPaymentDetail) forControlEvents:UIControlEventTouchUpInside];
    [self.floatView addSubview:paymentDetailBtn];
    
    [self.view insertSubview:self.floatView atIndex:1001];
    
}


-(ChooseRoomCountView *)roomCountView{
    if (!_roomCountView) {
        _roomCountView = [[ChooseRoomCountView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kRoomCountViewHeight)];
        WEAKSELF;
        _roomCountView.chooseRoomCountHandler = ^(NSInteger count){
        //选择房间数回调
            weakSelf.guestInfoModel.roomCount = [NSString stringWithFormat:@"%li",count];
            if (count > self.guestInfoModel.guests.count) {
                //增加房间时，直接添加空的入住人
                NSMutableArray *origin = [NSMutableArray arrayWithArray:weakSelf.guestInfoModel.guests];
                for (int i = 0; i < count - weakSelf.guestInfoModel.guests.count; i++) {
                    LYZContactsModel *emptyModel = [[LYZContactsModel alloc] init];
                    emptyModel.name = @"";
                    [origin addObject:emptyModel];
                }
                weakSelf.guestInfoModel.guests = [NSArray arrayWithArray:origin];
                
            }
            if (count < self.guestInfoModel.guests.count) {
                NSMutableArray *origin = [NSMutableArray arrayWithArray:weakSelf.guestInfoModel.guests];
                for (int i = 0; i < weakSelf.guestInfoModel.guests.count - count; i++) {
                    [origin removeLastObject];
                }
                weakSelf.guestInfoModel.guests = [NSArray arrayWithArray:origin];
            }
            
            [weakSelf createDataSource];
            [weakSelf countMoney];
            [weakSelf dissMissRoomCountView];
        };
        _roomCountView.phoneCall = ^(){
            [weakSelf phoneCall];
        };
    }
    return _roomCountView;
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

//-(OrderCommitMoneyDetailView *)moneyDetailView{
//    if (!_moneyDetailView) {
//        _moneyDetailView = [[OrderCommitMoneyDetailView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kMoneyDetalViewHeight)];
//        WEAKSELF;
//        _moneyDetailView.wxPay= ^(){
//              [[ThirdPayManager instance] weixinRequest:weakSelf.orderNo orderType:@"1"];
//        };
//        _moneyDetailView.aliPay =^(){
//             [[ThirdPayManager instance] createAliOrder:weakSelf.orderNo orderType:@"1"];
//        };
//    }
//    return _moneyDetailView;
//}

-(PaymentView *)paymentView{
    if (!_paymentView) {
        _paymentView = [[PaymentView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kMoneyDetalViewHeight)];
            WEAKSELF;
            _paymentView.wxPay= ^(){
                  [[ThirdPayManager instance] weixinRequest:weakSelf.orderNo orderType:@"1"];
            };
            _paymentView.aliPay =^(){
                 [[ThirdPayManager instance] createAliOrder:weakSelf.orderNo orderType:@"1"];
            };
    }
    return _paymentView;
}


-(PaymentDetailView *)paymentDetailView{
    if (!_paymentDetailView) {
        _paymentDetailView = [[PaymentDetailView alloc] initWithFrame: [UIScreen mainScreen].bounds];
    }
    return _paymentDetailView;
}

//Deprecated
-(void)reloadRoomInfoCell{
    
    NSDictionary *dic;
    NSString *isExact = [self.checkOutDate daysAfterDate:self.checkInDate] == 1 ? @"Y":@"N";
    if (self.roomInfo && !self.priceInfo) {
        dic = @{@"roomInfo":self.roomInfo, @"price":self.roomInfo.price, @"vipprice":self.roomInfo.vipprice,@"exact":isExact};
    }else if (self.roomInfo && self.priceInfo){
        dic = @{@"roomInfo":self.roomInfo, @"price":self.priceInfo.minPrice, @"vipprice":self.priceInfo.vipMinPrice,@"exact":isExact};
    }
 
    [self.adapters replaceObjectAtIndex:2 withObject:[OrderCommitRoomInfoCell dataAdapterWithData:dic cellHeight:OrderCommitRoomInfoCell.cellHeight]];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
}

-(void)updateMoneyWithModel:(CountMoneyModel *)model{
    self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%@",model.actualPayment];
    if([UIDevice currentDevice].systemVersion.floatValue >= 10.0f){
        NSString *str = [NSString stringWithFormat:@"含押金￥%@",model.depositSum];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
        [string addAttribute:NSForegroundColorAttributeName value:LYZTheme_paleBrown range:NSMakeRange(3,str.length - 3)];
        [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Medium" size:16.0f] range:NSMakeRange(3,str.length - 3)];
        self.depositLabel.attributedText = string;
    }else{
           self.depositLabel.text =  [NSString stringWithFormat:@"含押金￥%@",model.depositSum];
    }
    [self.paymentView configureWithMoneyModel:model hotelName:self.roomInfo.hotelname roomType:self.roomInfo.roomType];
}



#pragma mark - UITableView related.

- (void)createDataSource {
    if (!self.adapters) {
        self.adapters = [NSMutableArray array];
    }
    if (self.adapters.count > 0) {
        [self.adapters removeAllObjects];
    }
    [self.adapters addObject:[OrderCommitHotelNameCell dataAdapterWithData:self.roomInfo cellHeight:OrderCommitHotelNameCell.cellHeight]];
    [self.adapters addObject:[self lineType:kLongType height:0.5]];
    NSDictionary *dic;
    NSString *isExact = [self.checkOutDate daysAfterDate:self.checkInDate] == 1 ? @"Y":@"N";
    if (self.roomInfo && !self.priceInfo) {
        dic = @{@"roomInfo":self.roomInfo, @"price":self.roomInfo.price, @"vipprice":self.roomInfo.vipprice,@"exact":isExact};
    }else if (self.roomInfo && self.priceInfo){
        dic = @{@"roomInfo":self.roomInfo, @"price":self.priceInfo.minPrice, @"vipprice":self.priceInfo.vipMinPrice,@"exact":isExact};
    }
    [self.adapters addObject:[OrderCommitRoomInfoCell dataAdapterWithData:dic cellHeight:OrderCommitRoomInfoCell.cellHeight]];
     [self.adapters addObject:[OrderCommitNoTraceCell dataAdapterWithData:nil cellHeight:OrderCommitNoTraceCell.cellHeight]];
    [self.adapters addObject:[self lineType:kSpace height:15]];
    NSDictionary *dateDic = @{@"checkIn":self.checkInDate, @"checkOut":self.checkOutDate};
    [self.adapters addObject:[OrderCommitDateCell dataAdapterWithData:dateDic cellHeight:OrderCommitDateCell.cellHeight]];
    if ([[LSTimeSlot sharedTimeSlot] isStockTradingBeginHour:0 andBeginMinus:00 andEndHour:6 andEndMinus:00 andIsEarlyBack:NO andEarlyBackMinus:0]) {
        [self.adapters addObject:[LYZHotelWarmCell dataAdapterWithData:nil cellHeight:35.5]];
    }else{
        [self.adapters addObject:[self lineType:kSpace height:0]];
    }
    [self.adapters addObject:[self lineType:kSpace height:15]];
    [self.adapters addObject:[OrderCommitRoomCountCell dataAdapterWithData:self.guestInfoModel cellHeight:OrderCommitRoomCountCell.cellHeight]];
    [self.adapters addObject:[self lineType:kLongType height:0.5]];
    for (int i = 0; i < self.guestInfoModel.guests.count ; i ++) {
        LYZContactsModel *model = self.guestInfoModel.guests[i];
        model.index = i + 1; //加1 是为了title 展示 从 1 开始
        [self.adapters addObject:[OrderCommitGuestInfoCell dataAdapterWithData:model cellHeight:OrderCommitGuestInfoCell.cellHeight]];
        if (i == self.guestInfoModel.guests.count - 1) {
            [self.adapters addObject:[self lineType:kLongType height:0.5]];
            break;
        }
        [self.adapters addObject:[self lineType:kShortType height:0.5]];
    }
    [self.adapters addObject:[LYZAlertCellTableViewCell dataAdapterWithData:nil cellHeight:LYZAlertCellTableViewCell.cellHeight]];
    [self.adapters addObject:[self lineType:kSpace height:15]];
    [self.adapters addObject:[OrderCommitCouponCell dataAdapterWithData:self.prefillCoupon cellHeight:OrderCommitPhoneCell.cellHeight]];
    [self.adapters addObject:[self lineType:kSpace height:15]];
    [self.adapters addObject:[OrderCommitChooseInvoiceCell dataAdapterWithData:self.invoiceModel cellHeight:OrderCommitChooseInvoiceCell.cellHeight]];
    if (self.needInvoice) {
        [self.adapters addObject:[self lineType:kLongType height:0.5]];
        [self.adapters addObject:[OrderCommitInvoiceInfoCell dataAdapterWithData:self.invoiceModel cellHeight:[OrderCommitInvoiceInfoCell cellHeightWithData:self.invoiceModel]]];
    }
    [self.adapters addObject:[OrderCommitNoticeCell dataAdapterWithData:nil cellHeight:OrderCommitNoticeCell.cellHeight]];
    
    [GCDQueue executeInMainQueue:^{
         [self.tableView reloadData];
    }];
}
     
- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {
         if (type == kSpace) {
             return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" :LYZTheme_BackGroundColor} cellHeight:height];
         } else if (type == kLongType) {
             return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :[UIColor colorWithHexString:@"E8E8E8"]} cellHeight:0.5f];
         } else if (type == kShortType) {
             return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" : [UIColor colorWithHexString:@"E8E8E8"], @"leftGap" : @(25.f)} cellHeight:0.5f];
         } else {
             return nil;
         }
}

- (void)createTableViewAndRegisterCells {
    
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 60 - 64 )]; // 多 -5  底部留点空白
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    [ColorSpaceCell  registerToTableView:self.tableView];
    [OrderCommitHotelNameCell registerToTableView:self.tableView];
    [OrderCommitRoomInfoCell registerToTableView:self.tableView];
    [OrderCommitDateCell registerToTableView:self.tableView];
    [LYZHotelWarmCell registerToTableView:self.tableView];
    [OrderCommitRoomCountCell registerToTableView:self.tableView];
    [OrderCommitGuestInfoCell registerToTableView:self.tableView];
//    [OrderCommitPhoneCell registerToTableView:self.tableView];
    [OrderCommitCouponCell registerToTableView:self.tableView];
    [OrderCommitChooseInvoiceCell registerToTableView:self.tableView];
    [OrderCommitInvoiceInfoCell registerToTableView:self.tableView];
    [OrderCommitNoticeCell registerToTableView:self.tableView];
    [OrderCommitNoTraceCell registerToTableView:self.tableView];
    [LYZAlertCellTableViewCell registerToTableView:self.tableView];
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
    
    NSLog(@"%ld",indexPath.row);
    if ([[LSTimeSlot sharedTimeSlot] isStockTradingBeginHour:0 andBeginMinus:00 andEndHour:6 andEndMinus:00 andIsEarlyBack:NO andEarlyBackMinus:0]) {
        if (indexPath.row == 5) {
            [Calendar showManualHiddenMessageViewInKeyWindowWithMessageObject:nil delegate:self viewTag:111];
        }else if (indexPath.row == 6){
            NSLog(@"shanchu");
            NSLog(@"%ld",self.adapters.count);
            [self.adapters replaceObjectAtIndex:6 withObject:[self lineType:kSpace height:0]];
            NSLog(@"%ld",self.adapters.count);
            [self.tableView reloadData];
        }else if (indexPath.row == self.adapters.count - 6){
            [self.adapters replaceObjectAtIndex:self.adapters.count - 6 withObject:[self lineType:kSpace height:0]];
            NSLog(@"%ld",self.adapters.count);
            [self.tableView reloadData];
        }
    }else{
        if (indexPath.row == 5) {
            [Calendar showManualHiddenMessageViewInKeyWindowWithMessageObject:nil delegate:self viewTag:111];
        }else if (indexPath.row == self.adapters.count - 6){
            [self.adapters replaceObjectAtIndex:self.adapters.count - 6 withObject:[self lineType:kSpace height:0]];
            NSLog(@"%ld",self.adapters.count);
            [self.tableView reloadData];
        }
    }
}

#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {
    LYLog(@"%@", event);
}

#pragma mark --Cells Btn Actions

-(void)showPaymentDetail{
    if ([_paymentDetailView superview]) {
        [_paymentDetailView dismiss];
    }else{
        [self.paymentDetailView configureWithMoneyModel:self.countMoneyModel];
        [self.view insertSubview:self.paymentDetailView belowSubview:self.floatView];
    }
 
    
}

-(void)chooseCoupon{
    CouponViewController *vc = [[CouponViewController alloc] init];
    vc.price = self.priceInfo.realPrice;
    WEAKSELF;
    vc.couponCallBack = ^(id coupon){
        if (!coupon) {
             PreFillCouponModel *prefill = [[PreFillCouponModel alloc] init];
            prefill.coupontype = @4;
            weakSelf.prefillCoupon = prefill;
            [weakSelf createDataSource];
        }else{
            CouponModel *model = (CouponModel *)coupon;
            PreFillCouponModel *prefill = [[PreFillCouponModel alloc] init];
            prefill.coupondetatilid = model.couponID;
            prefill.coupondenominat = model.denominat;
            prefill.coupontype = model.coupontype;
            prefill.coupondiscount = model.discount;
            prefill.couponName = model.name;
            weakSelf.prefillCoupon = prefill;
            [weakSelf createDataSource];
        }
        [weakSelf countMoney];
    };
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)chooseLocalContact{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusNotDetermined:
            NSLog(@"用户还没有决定是否可以访问");
            [self requestDetermain];
            break;
        case CNAuthorizationStatusDenied:
            NSLog(@"不可以访问联系人数据库");
            break;
        case CNAuthorizationStatusAuthorized:
            NSLog(@"可以访问联系人数据库");
            [self toMyLocalContacts];
            break;
        case CNAuthorizationStatusRestricted:
            NSLog(@"这个状态说明应用不仅不能够访问联系人数据，并且用户也不能在设置中改变这个状态");
            break;
        default:
            break;
    }
}

//请求授权提示框
-(void)requestDetermain{
    CNContactStore *store = [[CNContactStore alloc] init];
    [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //获取联系人
            [self toMyLocalContacts];
        }
    }];
}

//Deprecated
-(void)toMyLocalContacts{
    CNContactPickerViewController *contactVC = [CNContactPickerViewController new];
    contactVC.delegate = self;
    [self presentViewController:contactVC animated:YES completion:^{
        
    }];
}

-(void)trackSwitch:(BOOL)isOn{
    self.hasTrack = isOn;
}

-(void)addGuest:(NSInteger)index{
    
    LYLog(@"----->add  a new guest");
    LYZChooseGuestViewController *vc = [[LYZChooseGuestViewController alloc] init];
     LYZContactsModel *selectedGuestModel = self.guestInfoModel.guests[index - 1];
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray: self.guestInfoModel.guests];
    for (LYZContactsModel *model in self.guestInfoModel.guests) {
        //如果选择的是空的 或者 选中的已填写的用户 则删掉 ， 剩下的则为不能选中用户
        if ( !model.contactsID || [model.contactsID isEqualToString:selectedGuestModel.contactsID]) {
            [arr removeObject:model];
        }
    }
    vc.filledContacts = arr.copy;
    //以下是回填
    WEAKSELF;
    vc.completeBlock = ^(LYZContactsModel *model ){
//        LYZContactsModel *selectedGuestModel = weakSelf.guestInfoModel.guests[index];
        NSMutableArray *origin = [NSMutableArray arrayWithArray:weakSelf.guestInfoModel.guests];
           [origin replaceObjectAtIndex:index -1 withObject:model];
         weakSelf.guestInfoModel.guests = [NSArray arrayWithArray:origin];
//        for (int i = 0; i < origin.count; i++) {
//            if (i < arr.count ) {
//                [origin replaceObjectAtIndex:i withObject:arr[i]];
//            }else{
//                LYZContactsModel *contactModel = [[LYZContactsModel alloc] init];
//                contactModel.name = @"";
//                [origin replaceObjectAtIndex:i withObject:contactModel];
//            }
//        }
//
        [weakSelf createDataSource];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)toInvoiceDetail{
    LYZInvoiceViewController *vc = [[LYZInvoiceViewController alloc] init];
    WEAKSELF;
    vc.popBlock = ^(OrderInvoiceModel *model){
        weakSelf.invoiceModel = model;
        [weakSelf createDataSource];
    };
    if (self.invoiceModel.type != OrderInvoiceType_none) {
        vc.invoiceModel = self.invoiceModel;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)needInvoice:(BOOL)need{
    self.needInvoice = need;
    if (self.needInvoice) {
        //push to invoice view
        LYZInvoiceViewController *vc = [[LYZInvoiceViewController alloc] init];
        WEAKSELF;
        vc.popBlock = ^(OrderInvoiceModel *model){
            weakSelf.invoiceModel = model;
            [weakSelf createDataSource];
        };
        vc.callback = ^(){
            weakSelf.needInvoice = NO;
            OrderInvoiceModel *orderInvoice = [[OrderInvoiceModel alloc] init];
            orderInvoice.type = OrderInvoiceType_none;
            weakSelf.invoiceModel = orderInvoice;
            [weakSelf createDataSource];
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

//-(void)selectDate:(BOOL)isCheckIn{
//     LYLog(@"----> select date %i",isCheckIn);
//    LYZCalederViewController *vc = [[LYZCalederViewController alloc] init];
//    WEAKSELF;
//    vc.optionCalederBlock = ^(NSArray *arr){
//        weakSelf.checkInDate = [arr firstObject];
//        weakSelf.checkOutDate = [arr lastObject];
//        if (weakSelf.checkInDate == weakSelf.checkOutDate) {
//            weakSelf.checkOutDate = [weakSelf.checkInDate dateByAddingDays:1];
//        }
//        [weakSelf countMoney];
//        [weakSelf createDataSource];
//        //获取房间数
//        NSString *inDate = [weakSelf.checkInDate dateWithFormat:@"yyyy-MM-dd"];
//        NSString *outDate = [weakSelf.checkOutDate dateWithFormat:@"yyyy-MM-dd"];
//        [weakSelf getValidRoomCountWithCheckInDate:inDate checkOutDate:outDate];
//
//    };
//    [self presentViewController:vc animated:YES completion:^{
//
//    }];
//
//}

-(void)selectDate:(BOOL)isCheckIn{
    [Calendar showManualHiddenMessageViewInKeyWindowWithMessageObject:nil delegate:self viewTag:111];
}


-(void)chooseRoomCount{
    LYLog(@"----> choose room count");
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    UIWindow *keyWindow  = delegate.window;
    [keyWindow addSubview:self.alphaBlackView];
    [keyWindow addSubview:self.roomCountView];
    [UIView animateWithDuration:0.3 animations:^{
        self.alphaBlackView.alpha = 0.5;
        self.roomCountView.frame = CGRectMake(0,SCREEN_HEIGHT - kRoomCountViewHeight, SCREEN_WIDTH, 300);
    } completion:^(BOOL finished) {
        
    }];
    
}

-(void)dissMissRoomCountView{
    [UIView animateWithDuration:0.5 animations:^{
        self.alphaBlackView.alpha = 0;
        if (_roomCountView) {
            self.roomCountView.frame = CGRectMake(0,SCREEN_HEIGHT, SCREEN_WIDTH, kRoomCountViewHeight);
        }
        if (_paymentView) {
            self.paymentView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kMoneyDetalViewHeight);
        }
    } completion:^(BOOL finished) {
        if (self.alphaBlackView.superview) {
            [_alphaBlackView removeFromSuperview];
        }
        if (self.roomCountView.superview) {
            [_roomCountView removeFromSuperview];
        }
        if (_paymentView.superview) {
            [_paymentView removeFromSuperview];
        }
    }];
}

//Deprecated
-(void)chooseGuest:(NSInteger)index{
    LYLog(@"-----> choose guest at %li ",index);
    LYZContactsModel *model = self.guestInfoModel.guests[index];
    WEAKSELF;
    AddNewContactViewController *vc = [[AddNewContactViewController alloc] init];
    if (model.name && ![model.name isEqualToString:@""]) {
        vc.fromContactsModel = model;
    }
    vc.callbackToCommitBlock = ^(id data){
        NSMutableArray *temp = [NSMutableArray arrayWithArray:weakSelf.guestInfoModel.guests];
        [temp replaceObjectAtIndex:index - 1 withObject:(LYZContactsModel *)data];
        weakSelf.guestInfoModel.guests = [NSMutableArray arrayWithArray:temp];
        if (![LoginManager instance].appUserID) {
            if (index == 1) {
                weakSelf.guestInfoModel.phoneNum = ((LYZContactsModel *)data).phone;
            }
        }
        [weakSelf createDataSource];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- current View Btn Actions 

- (BOOL)isValidateMobile:(NSString *)mobile{
    //手机号以13、15、18开头，八个\d数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

-(void)payBtnClick:(UIButton *)sender{
    LYLog(@" phone is %@",self.guestInfoModel.phoneNum);
    if(self.guestInfoModel.phoneNum.length == 0 || [self.guestInfoModel.phoneNum isEqualToString:@""]){
        [Public showJGHUDWhenError:self.view msg:@"手机号不能为空"];
        return;
    }
    
    if(self.guestInfoModel.phoneNum.length < 11 || self.guestInfoModel.phoneNum.length > 11){
        [Public showJGHUDWhenError:self.view msg:@"手机号码输入不正确"];
        return;
    }
    
    for (NSUInteger index = 0; index < self.guestInfoModel.guests.count; index ++) {
        LYZContactsModel *model =self.guestInfoModel.guests[index] ;
        if ( [model.name isEqualToString:@""]) {
            [Public showJGHUDWhenError:self.view msg:@"请认真填写联系人信息"];
            return;
        }
    }
    //如果订单存在,则删掉该订单
    if (self.orderNo) {
        [[LYZNetWorkEngine sharedInstance] deleteOrder:VersionCode devicenum:DeviceNum fromtype:FromType orderNO:self.orderNo orderType:@"1" block:^(int event, id object) {

            if (event == 1) {
                self.orderNo = nil;
                [self generateOrderForm];
            }else if (event == 19){
                DeleteOrderResponse *response = (DeleteOrderResponse *)object;
                YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:response.msg delegate:self buttonTitles:@"知道了",nil];
                [alert Show];
                
            }else{
                
                [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                    if(buttonIndex == 1){
                        //                            [weakSelf.tabBarController setSelectedViewController:weakSelf.tabBarController.viewControllers[1]];
                    }
                } title:@"提示信息" message:object cancelButtonName:NULL otherButtonTitles:@"确定", nil];
//                WEAKSELF;
//                [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
//
//                    if(buttonIndex == 1){
//                    [weakSelf.tabBarController setSelectedViewController:weakSelf.tabBarController.viewControllers[1]];
//                    }
//                } title:@"提示信息" message:@"您的订单已经存在，请前往查看您的入住信息" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
                return;
            }
        }];
    }else{
        [self generateOrderForm];
    }
}


-(void)generateOrderForm{
    //生成数据模型
    NSMutableArray *checkInsArray = [NSMutableArray array];
    for (NSUInteger index = 0; index < self.guestInfoModel.guests.count; index ++) {
        LYZContactsModel *model =self.guestInfoModel.guests[index] ;
        if([model isKindOfClass:[LYZContactsModel class]]){
            NSString *name = model.name;
            NSString *card = model.paperworkNum;
            if(name.length == 0){
                name = @"";
            }
            if(card.length == 0){
                card = @"";
            }
            NSDictionary *dict = @{@"name":name,@"paperworkNum":card , @"paperworkType":[NSString stringWithFormat:@"%@",model.paperworkType],@"livePhone":model.phone};
            [checkInsArray addObject:dict];
        }
    }
    
    NSArray *checkInsArr_para = [NSArray arrayWithArray:checkInsArray];
    
    NSString *invoiceType ;
    NSDictionary *invoiceInfoDic;
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
        NSNumber *lookuptype =[NSNumber numberWithInt: (int)invoiceModel.title.type + 1];
        NSString *lookUp = invoiceModel.title.taxTitle;
        NSString *taxNum = invoiceModel.title.taxNum;
        NSString *recipient = invoiceModel.recieverInfo.recipient;
        NSString *phone = invoiceModel.recieverInfo.phone;
        NSString *address = invoiceModel.recieverInfo.address;
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
        
        [infoDict setValue:invoiceDetails forKey:@"invoiceDetail"];
        [infoDict setValue:invoiceremark forKey:@"invoiceremark"];
        [infoDict setValue:invoiceLookupID forKey:@"invoiceLookupId"];
        [infoDict setValue:addressID forKey:@"invoiceAddressId"];
        [infoDict setValue:mailType forKey:@"mailType"];
        [infoDict setValue:email forKey:@"email"];
        [infoDict setValue:lookuptype forKey:@"lookuptype"];
        [infoDict setValue:lookUp forKey:@"lookUp"];
        [infoDict setValue:taxNum forKey:@"taxNumber"];
        [infoDict setValue:recipient forKey:@"recipient"];
        [infoDict setValue:phone forKey:@"phone"];
        [infoDict setValue:address forKey:@"address"];
        invoiceInfoDic = [NSDictionary dictionaryWithDictionary:infoDict];
    }
    if(invoiceModel.type == OrderInvoiceType_Electronic){
        //TODO:电子发票暂时没开放
        invoiceType = @"1";
        NSString *invoiceDetails = invoiceModel.detail;
        NSString *invoiceLookupID = invoiceModel.title.lookUpID;
        NSString *addressID = invoiceModel.recieverInfo.invoiceAddressID;
        NSString *mailType = @"1";
        NSString *email = @"323251655@qq.com";//电子发票暂时没开放 先设置为固定值
        
        NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
        
        [infoDict setValue:invoiceDetails forKey:@"invoiceDetail"];
        [infoDict setValue:invoiceLookupID forKey:@"invoiceLookupId"];
        [infoDict setValue:addressID forKey:@"invoiceAddressId"];
        [infoDict setValue:mailType forKey:@"mailType"];
        [infoDict setValue:email forKey:@"email"];
        invoiceInfoDic = [NSDictionary dictionaryWithDictionary:infoDict];
    }
    
    //创建订单
    NSString *appUserId = [LoginManager instance].appUserID;
    if (!appUserId) {
        appUserId = @"";
    }
    NSString *inDate = [self.checkInDate dateWithFormat:@"yyyy-MM-dd"];
    NSString *outDate = [self.checkOutDate dateWithFormat:@"yyyy-MM-dd"];
    JGProgressHUD *hud = [Public hudWhenRequest];
    [hud showInView:self.view];
    NSString *track = self.hasTrack? @"1":@"0";
    NSString *couponID = self.prefillCoupon.coupondetatilid ? : @"";
    [[LYZNetWorkEngine sharedInstance] createOrderWithHotelRoomID:self.roomTypeID  checkInTime:inDate checkOutTime:outDate payNum:[NSString stringWithFormat:@"%@",self.countMoneyModel.payNum] phone:self.guestInfoModel.phoneNum checkIns:checkInsArr_para  invoiceType:invoiceType invoiceInfo:invoiceInfoDic isOpenPrivacy:track coupondetatilid:couponID block:^(int event, id object) {
        [hud dismissAnimated:YES];
        if(event == 1){
        
            CreateOrderResponse *orderResponse = (CreateOrderResponse*)object;
            createOrderModel *orderModel = orderResponse.order;
            LYLog(@"orderNo : %@" , orderModel.orderNo);
            self.orderNo = orderModel.orderNo;
            self.orderType = [NSString stringWithFormat:@"%@", orderModel.orderType];
            
            if ([_paymentDetailView superview]) {
                [_paymentDetailView dismiss];
            }
            [GCDQueue executeInMainQueue:^{
                AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UIWindow *keyWindow  = delegate.window;
                [keyWindow addSubview:self.alphaBlackView];
                [keyWindow addSubview:self.paymentView];
                [UIView animateWithDuration:0.3 animations:^{
                    self.alphaBlackView.alpha = 0.5;
                    self.paymentView.frame = CGRectMake(0,SCREEN_HEIGHT - kMoneyDetalViewHeight, SCREEN_WIDTH, kMoneyDetalViewHeight);
                } completion:^(BOOL finished) {
                    
                }];
            }];
        }else if(event == 15){
            CreateOrderResponse *orderResponse = (CreateOrderResponse*)object;
           self.existOrderModel = orderResponse.order;
            NSString *title = @"发现您还有一个待支付订单";
            NSString *content                     = @"您可以查看待支付订单并支付，继续支付将删除原待支付订单";
            NSArray  *buttonTitles                =  @[AlertViewNormalStyle(@"查看订单"), AlertViewRedStyle(@"继续支付")] ;
            AlertViewMessageObject *messageObject = MakeAlertViewMessageObject(title,content, buttonTitles);
            [AlertView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag: 101];
        }else if(event == 100){
              CreateOrderResponse *orderResponse = (CreateOrderResponse*)object;
             [Public showJGHUDWhenError:self.view msg:orderResponse.msg];
        }else if(event == 19001){
            [Public showJGHUDWhenError:self.view msg:@"此时段不可订房"];
        }else if(event == 100){
            CreateOrderResponse *orderResponse = (CreateOrderResponse*)object;
            YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:orderResponse.msg delegate:self buttonTitles:@"知道了",nil];
            [alert Show];
        }else if(event == 102){
            CreateOrderResponse *orderResponse = (CreateOrderResponse*)object;
            YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:orderResponse.msg delegate:self buttonTitles:@"知道了",nil];
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
    //提交订单查看房间数
    
    
    if (messageView.tag == 101) {
        if ([event isEqualToString:@"查看订单"]) {
            LYZOrderFormViewController *orderForm = [LYZOrderFormViewController new];
            orderForm.orderType =  [NSString stringWithFormat:@"%@",self.existOrderModel.orderType];
            orderForm.orderNo = self.existOrderModel.orderNo;
            [self.navigationController pushViewController:orderForm animated:YES];
        }else if ([event isEqualToString:@"继续支付"]){
            [[LYZNetWorkEngine sharedInstance] deleteOrder:VersionCode devicenum:DeviceNum fromtype:FromType orderNO:self.existOrderModel.orderNo orderType:@"1" block:^(int event, id object) {
                
                if (event == 1) {
                    [self generateOrderForm];
                }else{
                    
//                    WEAKSELF;
                    [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
                        if(buttonIndex == 1){
//                            [weakSelf.tabBarController setSelectedViewController:weakSelf.tabBarController.viewControllers[1]];
                        }
                    } title:@"提示信息" message:object cancelButtonName:NULL otherButtonTitles:@"确定", nil];
                    return;
                }
            }];
        }

    }
    
    if (messageView.tag ==  111) {
        NSArray *arr = (NSArray *)event;
        self.checkInDate = [arr firstObject];
        self.checkOutDate = [arr lastObject];
        [self countMoney];
        [self createDataSource];
        
        //获取房间数
        NSString *inDate = [self.checkInDate dateWithFormat:@"yyyy-MM-dd"];
        NSString *outDate = [self.checkOutDate dateWithFormat:@"yyyy-MM-dd"];
        [self getValidRoomCountWithCheckInDate:inDate checkOutDate:outDate];
        [self getRoomPrice];
    }
    
    [messageView hide];
    
}



-(void)phoneCall{
    [LYZPhoneCall noAlertCallPhoneStr:CustomerServiceNum withVC:self];
}






#pragma mark -- Third Pay delegate

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
            payVC.orderNumber = self.orderNo;
            payVC.orderType =  self.orderType;
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
            payVC.orderNumber = self.orderNo;
            payVC.orderType = self.orderType;
            [self.navigationController pushViewController:payVC animated:YES];
            
        });
        
    }else{
        JGProgressHUD *hud  = [Public hudWHenFailure];
        hud.textLabel.text = @"支付失败！";
        [hud showInView:self.view];
        
        [hud dismissAfterDelay:2.0 animated:YES];
    }
}

#pragma mark - CNContactViewControllerDelegate代理
//选择一个联系人的时候调用
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    //1.姓名
    NSLog(@"%@-%@",contact.givenName,contact.familyName);
    //2.获取电话   --->泛型，会在遍历数组帮很大忙。
    for (CNLabeledValue *labelValue in contact.phoneNumbers) {
        NSLog(@"电话标签: %@",labelValue.label);
        CNPhoneNumber *phoneNumber = labelValue.value;
        NSLog(@"电话号码: %@",phoneNumber.stringValue);
        self.guestInfoModel.phoneNum = [phoneNumber.stringValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [self createDataSource];
    }
}

//取消选择联系人的时候调用
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    
}

-(void)checkVxPaySuccess:(NSNotification *)noti{
    //获取订单状态
   [[LYZNetWorkEngine sharedInstance] getOrderDetailWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType orderNo:self.orderNo orderType:self.orderType block:^(int event, id object) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)dealloc{
    LYLog(@"dealloc");
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationCheckVxPaySuccess object:nil];
}

@end
