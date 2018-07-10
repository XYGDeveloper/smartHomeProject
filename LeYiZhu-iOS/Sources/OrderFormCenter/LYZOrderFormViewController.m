//
//  LYZOrderFormViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZOrderFormViewController.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "GCD.h"
#import "LYZOrderStatusCell.h"
#import "LYZOrderNoCell.h"
#import "LYZOrderSumPaymentCell.h"
#import "LYZOrderPayDetailCell.h"
#import "LYZOrderHotelInfoCell.h"
#import "LYZOrderCheckInDateCell.h"
#import "LYZGuestInfoCell.h"
#import "LYZGuestPhoneCell.h"
#import "LYZOrderInvoiceCell.h"
#import "LYZOrderELecInvoiceCell.h"
#import "LYZOrderPaperInvoiceCell.h"
#import "MJRefresh.h"
#import "AppDelegate.h"
#import "LYZPayScuessViewController.h"
//#import "OrderCommitMoneyDetailView.h"
#import "ThirdPayManager.h"
#import "Public+JGHUD.h"
#import "HotelMapViewController.h"
#import "LYZOrderCommitRoomInfoModel.h"
#import "NSDate+Utilities.h"
#import "LYZRenewOrderLiveUserInfoCell.h"
//#import "LYZRenewPayMoneyDetailView.h"
#import "PaymentView.h"
#import "NSArray+YYAdd.h"
#import "CountRefillLiveMoneyModel.h"
#import "LYZCountRenewMoneyModel.h"
#import "LYZPhoneCall.h"
#import "LYZHotelViewController.h"
#import "PaymentDetailViewController.h"
#define kPaymentViewHeightYScale 0.417
#define kMoneyDetalViewHeight (kPaymentViewHeightYScale * SCREEN_HEIGHT)

@interface LYZOrderFormViewController ()<UITableViewDelegate, UITableViewDataSource, CustomCellDelegate>

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) BaseOrderDetailModel *orderDetailModel;
@property (nonatomic, strong) UIButton *floatBtn;
@property(nonatomic, strong) UIView *alphaBlackView;//选择房间数时弹出
@property(nonatomic, strong)PaymentView *moneyDetailView;
@property (nonatomic, strong) PaymentView *renewmoneyDetailView;
@property (nonatomic ,assign)CGFloat renewMoneyDetailViewHeight;

@property (nonatomic, strong) UILabel *timerLabel;

//创建dispatch_source_t类型的timer, 用于处理定时任务
@property (nonatomic, strong) dispatch_source_t timer;
////开启专门的线程处理timer
@property (nonatomic, strong) dispatch_queue_t timerQueue;

@end

@implementation LYZOrderFormViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
     [self.tableView.mj_header beginRefreshing];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
    
    [self dissMissRoomCountView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (self.orderType.integerValue == 2 || self.orderType.integerValue == 3) {
        self.title = @"续住订单";
    }else{
        self.title = @"订单详情";
    }
    
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    WEAKSELF;
    AppDelegate *dele = (AppDelegate*)[UIApplication sharedApplication].delegate;
    dele.orderFormVC = weakSelf;
    [self setUp];
}

-(void)setUp{
    [self setLeftNav];
    [self createTableViewAndRegisterCells];
//    [self fetchOrderData];
    [self createBottomFloatView];
    [self createTimerLabel];
}

-(void)setPayView{
    if (self.payNow) {
        if (self.orderType.integerValue == 2 || self.orderType.integerValue == 3) {
            [GCDQueue executeInMainQueue:^{
                AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UIWindow *keyWindow  = delegate.window;
                [keyWindow addSubview:self.alphaBlackView];
                [keyWindow addSubview:self.renewmoneyDetailView];
                [UIView animateWithDuration:0.3 animations:^{
                    self.alphaBlackView.alpha = 0.5;
                    self.renewmoneyDetailView.frame = CGRectMake(0,SCREEN_HEIGHT -kMoneyDetalViewHeight, SCREEN_WIDTH, kMoneyDetalViewHeight);
                } completion:^(BOOL finished) {
                }];
            }];

        }else{
            [GCDQueue executeInMainQueue:^{
                AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
                UIWindow *keyWindow  = delegate.window;
                [keyWindow addSubview:self.alphaBlackView];
                [keyWindow addSubview:self.moneyDetailView];
                [UIView animateWithDuration:0.3 animations:^{
                    self.alphaBlackView.alpha = 0.5;
                    self.moneyDetailView.frame = CGRectMake(0,SCREEN_HEIGHT - kMoneyDetalViewHeight, SCREEN_WIDTH, kMoneyDetalViewHeight);
                } completion:^(BOOL finished) {
                    
                }];
            }];
        }
       
    }
}

-(void)countMoney{

    NSString *payNum = [NSString stringWithFormat:@"%@",self.orderDetailModel.orderJson.payNum] ; //几个人
    NSString *couponID = self.orderDetailModel.orderJson.coupondetatilid ?: @"";
    [[LYZNetWorkEngine sharedInstance] countMoneyWithRoomTypeID:self.orderDetailModel.hotelJson.roomTypeID payNum:payNum checkInDate:self.orderDetailModel.orderJson.checkInDate checkOutDate:self.orderDetailModel.orderJson.checkOutDate coupondetatilid:couponID block:^(int event, id object) {
        if(event == 1){
            CountMoneyResponse *countMoneyResponse = (CountMoneyResponse*)object;
            CountMoneyModel *moneyModel = countMoneyResponse.countMoney;
            [GCDQueue executeInMainQueue:^{
                [self.moneyDetailView configureWithMoneyModel:moneyModel hotelName: self.orderDetailModel.hotelJson.hotelName  roomType:self.orderDetailModel.hotelJson.roomType];
            }];
            LYLog(@"countMoney success : %@" , object);
        }else{
            LYLog(@"countMoney failure: %@" , object);
            [Public showJGHUDWhenError:self.view msg:object];
        }
    }];
    
    

}

-(void)countRenewMoney{
    
    [GCDQueue executeInMainQueue:^{
        [self setPayView];
        [self.renewmoneyDetailView configureWithLocalMoneyModel:self.orderDetailModel];
                            }];
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
        _moneyDetailView = [[PaymentView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kMoneyDetalViewHeight)];
        WEAKSELF;
        _moneyDetailView.wxPay= ^(){
            [[ThirdPayManager instance] weixinRequest:weakSelf.orderDetailModel.orderJson.orderNO orderType:weakSelf.orderType];
        };
        _moneyDetailView.aliPay =^(){
            [[ThirdPayManager instance] createAliOrder:weakSelf.orderDetailModel.orderJson.orderNO orderType:weakSelf.orderType];
        };
    }
    return _moneyDetailView;
}

-(PaymentView *)renewmoneyDetailView{
    if (!_renewmoneyDetailView) {
        _renewmoneyDetailView = [[PaymentView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH,kMoneyDetalViewHeight)];
        WEAKSELF;
        _renewmoneyDetailView.wxPay= ^(){
            [[ThirdPayManager instance] weixinRequest:weakSelf.orderDetailModel.orderJson.orderNO orderType:@"2"];
        };
        _renewmoneyDetailView.aliPay =^(){
            [[ThirdPayManager instance] createAliOrder:weakSelf.orderDetailModel.orderJson.orderNO orderType:@"2"];
        };
    }
    return _renewmoneyDetailView;
}


-(void)dissMissRoomCountView{
    [UIView animateWithDuration:0.5 animations:^{
        self.alphaBlackView.alpha = 0;
        if (_moneyDetailView) {
            self.moneyDetailView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kMoneyDetalViewHeight);
        }
        if (_renewmoneyDetailView) {
            self.renewmoneyDetailView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kMoneyDetalViewHeight);
        }
    } completion:^(BOOL finished) {
        if (self.alphaBlackView.superview) {
            [_alphaBlackView removeFromSuperview];
        }
        if (self.moneyDetailView.superview) {
            [_moneyDetailView removeFromSuperview];
        }
        if (self.renewmoneyDetailView.superview) {
            [_renewmoneyDetailView removeFromSuperview];
        }
    }];
}

-(void)setLeftNav{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightBtn.bounds = CGRectMake(0, 0, 60, 30);
    UIImage * phoneImg = [[UIImage imageNamed:@"icon_phone_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [rightBtn setImage:phoneImg forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(phoneCall) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = - 20;
    self.navigationItem.rightBarButtonItems = @[spaceItem,rightItem];
}

-(void)fetchOrderData{
    [[LYZNetWorkEngine sharedInstance] getOrderDetailWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType orderNo:self.orderNo orderType:self.orderType block:^(int event, id object) {
        if (event == 1) {
            GetOrderDetailResponse *response = (GetOrderDetailResponse *)object;
            LYLog(@"the response is %@",response.baseOrderDetail);
             self.orderDetailModel = response.baseOrderDetail;
            if (response.baseOrderDetail.orderJson.orderType.integerValue == 2 || response.baseOrderDetail.orderJson.orderType.integerValue == 3) {
                [self endRefresh];
                [self createDataSource];
                [self configBottomFloatBtnTitle];
                if (self.payNow) {
                    [self countRenewMoney];
                }
            }else{
            
                [self endRefresh];
                [self createDataSource];
                [self configBottomFloatBtnTitle];
                if (self.payNow) {
                    [self setPayView];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self countMoney];
                    });
                }
            }
        }else if(event == 2){
            [self endRefresh];
             GetOrderDetailResponse *response = (GetOrderDetailResponse *)object;
            [Public showJGHUDWhenError:self.view msg:response.msg];
        }else{
            
            [self endRefresh];
            [Public showJGHUDWhenError:self.view msg:object];
        }
    }];
}

-(void)endRefresh{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


-(void)createBottomFloatView{
    self.floatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.floatBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 64 - 60, SCREEN_WIDTH, 60);
    self.floatBtn.backgroundColor = LYZTheme_paleBrown;
    [self.floatBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.floatBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:17];
    [ self.floatBtn addTarget:self action:@selector(floatBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:self.floatBtn atIndex:1001];
}

-(void)createTimerLabel{
    _timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64 - 60 - 30, SCREEN_WIDTH, 30)];
    _timerLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    _timerLabel.backgroundColor = RGB(232, 226, 219);
    _timerLabel.textAlignment = NSTextAlignmentCenter;
    _timerLabel.textColor = LYZTheme_warmGreyFontColor;
    _timerLabel.hidden = YES;
    [self.view insertSubview:_timerLabel atIndex:1002];
}

-(void)configBottomFloatBtnTitle{
    NSString *btnTitle = nil;
    if (self.orderDetailModel.orderJson.hostStatus.integerValue == 1) {
        switch (self.orderDetailModel.orderJson.childStatus.intValue) {
            case 0:
                btnTitle = @"立即支付";
                break;
            case 1:
                btnTitle = @"酒店导航";
                break;
            case 2:
                btnTitle = @"续住";
                break;
            case 3:
                btnTitle = @"续住";
                break;
            case 4:
            case 5:
                btnTitle = @"再次预订";
                break;
            default:
                break;
        }
    }else{
        btnTitle = @"重新预订";
    }
    [self.floatBtn setTitle:btnTitle forState:UIControlStateNormal];
    [self configTimerLabel];
}

-(void)configTimerLabel{
    self.timerLabel.hidden = YES;
    if (self.orderDetailModel.orderJson.hostStatus.intValue == 1) {
            if (self.orderDetailModel.orderJson.childStatus.intValue == 0) {
                self.timerLabel.hidden = NO;
                if (self.orderDetailModel.orderJson.paid.intValue != 0) {
                    self.timerLabel.hidden = YES;
                }else{
                    [self getUnpaidOrderRemainTime:self.orderDetailModel.orderJson.createTime];
                }
            }
        }
    
}

-(void)showRemainTime:(NSArray *)minute_second{
    NSNumber *minute = minute_second.firstObject;
    NSNumber *second = minute_second.lastObject;
    NSString *minute_str = [NSString stringWithFormat:@"%@",minute];
    NSString *second_str = [NSString stringWithFormat:@"%@",second];
    //补零
    if (minute.integerValue == 0 && second.integerValue > 0) {
        minute_str = @"00";
        if (second.integerValue < 10) {
            second_str = [NSString stringWithFormat:@"0%@",second];
        }
    }else if(minute.integerValue < 0 || second.integerValue < 0){
        [self.timerLabel removeFromSuperview];
        dispatch_source_cancel(self.timer);
        if (self.orderDetailModel.orderJson.paid.intValue != 0) {
        }else{
            [self cancelOrder:self.orderNo orderType:self.orderType];
        }
    }else{
        if (minute.integerValue < 10) {
            minute_str = [NSString stringWithFormat:@"0%@",minute];
        }
        if (second.integerValue < 10) {
            second_str = [NSString stringWithFormat:@"0%@",second];
        }
    }
    
    //中间插入空格
    NSMutableString *minuteMutstr = [[NSMutableString alloc] initWithString:minute_str];
    [minuteMutstr insertString:@" " atIndex:1];
    minute_str = minuteMutstr;
    
    NSMutableString *secondMutstr = [[NSMutableString alloc] initWithString:second_str];
    [secondMutstr insertString:@" " atIndex:1];
    second_str = secondMutstr;
    
    NSString *str = [NSString stringWithFormat:@"订单保留 %@ : %@  请尽快支付",minute_str,second_str];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str];
    [string addAttribute:NSForegroundColorAttributeName value:RGB(208, 0, 27) range:NSMakeRange(5,1)];
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:LYZTheme_Font_Bold size:15.0f] range:NSMakeRange(5,1)];
    [string addAttribute:NSForegroundColorAttributeName value:RGB(208, 0, 27) range:NSMakeRange(7,1)];
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:LYZTheme_Font_Bold size:15.0f] range:NSMakeRange(7,1)];
    [string addAttribute:NSForegroundColorAttributeName value:LYZTheme_BrownishGreyFontColor range:NSMakeRange(9,1)];
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:LYZTheme_Font_Bold size:15.0f] range:NSMakeRange(9,1)];
    [string addAttribute:NSForegroundColorAttributeName value:RGB(208, 0, 27) range:NSMakeRange(11,1)];
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:LYZTheme_Font_Bold size:15.0f] range:NSMakeRange(11,1)];
    [string addAttribute:NSForegroundColorAttributeName value:RGB(208, 0, 27) range:NSMakeRange(13,1)];
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:LYZTheme_Font_Bold size:15.0f] range:NSMakeRange(13,1)];
    self.timerLabel.attributedText = string;
}

-(void)getUnpaidOrderRemainTime:(NSString *)createTime{
    //创建定时器
    if (self.timer) {
        dispatch_source_cancel(self.timer);
    }
    WEAKSELF;
    //开启专门的线程处理timer
    self.timerQueue = dispatch_queue_create("TimerQueue", 0);
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _timerQueue);
   
    /*----打出dispatch_s直接就出现下边的代码块了---------*/
    /**
     *  第一个参数: dispatch_source_t, Dispatch Source
     *  第二个参数: 开始时刻;
     *  第三个参数: 间隔<例子中是一秒>;
     *  第四个参数: 精度<最高精度将之设置为0>
     */
    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    //函数回调
    dispatch_source_set_event_handler(self.timer, ^{
        //回主线刷新UI
        //计算剩余时间
        NSArray* xminute_second = [weakSelf dateTimeDifferenceWithStartTime:createTime];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf  showRemainTime:xminute_second];
        });
    });
    //默认的dispatch_source_t是暂停, 开始监听
    dispatch_resume(self.timer);
    /*----打出dispatch_s直接就出现上边的代码块了---------*/
    
}

////计算当前时间与订单生成时间的时间差，转化成分钟
//-(NSArray *)dateTimeDifferenceWithStartTime:(NSString *)startTime
//{
//    NSDate *date = [NSDate date] ;
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
//    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    //TODO:
//    NSDate *startDate =[[formatter dateFromString:startTime] dateByAddingMinutes:1];
//    NSInteger startInterval = [zone secondsFromGMTForDate: startDate];
//    NSDate *startLocaleDate = [startDate  dateByAddingTimeInterval: startInterval];
//    
//    NSString *nowstr = [formatter stringFromDate:localeDate];
//    NSDate *nowDate = [formatter dateFromString:nowstr];
//    
//    NSTimeInterval start = [startLocaleDate timeIntervalSince1970]*1;
//    NSTimeInterval end = [nowDate timeIntervalSince1970]*1;
//    NSTimeInterval value = start - end;
//    
//    int second = (int)value %60;//秒
//    int minute = (int)value /60%60;
//    int house = (int)value / (24 * 3600)%3600;
//    int day = (int)value / (24 * 3600);
//    NSString *str;
//    NSInteger time;//剩余时间为多少分钟
//    if (day != 0) {
//        str = [NSString stringWithFormat:@"耗时%d天%d小时%d分%d秒",day,house,minute,second];
//        time = day*24*60+house*60+minute;
//    }else if (day==0 && house != 0) {
//        str = [NSString stringWithFormat:@"耗时%d小时%d分%d秒",house,minute,second];
//        time = house*60+minute;
//    }else if (day == 0 && house== 0 && minute!=0) {
//        str = [NSString stringWithFormat:@"耗时%d分%d秒",minute,second];
//        time = minute;
//    }else{
//        str = [NSString stringWithFormat:@"耗时%d秒",second];
//    }
//    return @[[NSNumber numberWithInteger:time],[NSNumber numberWithInteger:second]];
//}

-(NSArray *)dateTimeDifferenceWithStartTime:(NSString *)startTime{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss.0";
    
    // 截止时间字符串格式
    NSString *expireDateStr = startTime;
    // 当前时间字符串格式
    NSString *nowDateStr = [dateFomatter stringFromDate:nowDate];
    // 截止时间data格式
    NSDate *expireDate = [[dateFomatter dateFromString:expireDateStr] dateByAddingMinutes:15];
    // 当前时间data格式
    nowDate = [dateFomatter dateFromString:nowDateStr];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:nowDate toDate:expireDate options:0];
    return @[[NSNumber numberWithInteger:dateCom.minute], [NSNumber numberWithInteger:dateCom.second]];
}



#pragma mark - UITableView related.

- (void)createDataSource {
    if (!self.adapters) {
        self.adapters = [NSMutableArray array];
    }
    if (self.adapters.count > 0) {
        [self.adapters removeAllObjects];
    }
    if (self.orderType.integerValue == 2  || self.orderType.integerValue == 3) {
        //续住订单数据
        [self.adapters addObject:[LYZOrderNoCell dataAdapterWithData:self.orderDetailModel cellHeight:LYZOrderNoCell.cellHeight]];
        [self.adapters addObject:[self lineType:kLongType height:0.5]];
        [self.adapters addObject:[LYZOrderStatusCell dataAdapterWithData:self.orderDetailModel cellHeight:LYZOrderStatusCell.cellHeight]];
        [self.adapters addObject:[self lineType:kSpace height:15]];
        [self.adapters addObject:[LYZOrderSumPaymentCell dataAdapterWithData:self.orderDetailModel cellHeight:LYZOrderSumPaymentCell.cellHeight]];
        [self.adapters addObject:[self lineType:kShortType height:0.5]];
        [self.adapters addObject:[LYZOrderPayDetailCell dataAdapterWithData:self.orderDetailModel cellHeight:LYZOrderPayDetailCell.cellHeight]];
        [self.adapters addObject:[self lineType:kSpace height:15]];
        [self.adapters addObject:[LYZOrderHotelInfoCell dataAdapterWithData:self.orderDetailModel cellHeight:LYZOrderHotelInfoCell.cellHeight]];
        [self.adapters addObject:[self lineType:kLongType height:0.5]];
        for (int i = 0; i < self.orderDetailModel.childOrderInfoJar.count; i ++) {
            [self.adapters addObject:[LYZRenewOrderLiveUserInfoCell  dataAdapterWithData:@{@"roomNum":[NSNumber numberWithInt:i + 1],@"Model":self.orderDetailModel.childOrderInfoJar[i]} cellHeight:LYZGuestInfoCell.cellHeight]];
            if (i == self.orderDetailModel.childOrderInfoJar.count -1) {
                break;
            }
            [self.adapters addObject:[self lineType:kShortType height:0.5]];
        }
        [self.adapters addObject:[self lineType:kLongType height:0.5]];
        [self.adapters addObject:[LYZGuestPhoneCell dataAdapterWithData:self.orderDetailModel cellHeight:LYZGuestPhoneCell.cellHeight]];
        [self.adapters addObject:[self lineType:kLongType height:0.5]];
        if (self.orderDetailModel.invoiceJson.invoiceType.intValue == 1) {
            //电子发票
            [self.adapters addObject:[LYZOrderInvoiceCell dataAdapterWithData:@{@"invoiceType":@"电子发票"} cellHeight:LYZOrderInvoiceCell.cellHeight]];
            [self.adapters addObject:[self lineType:kShortType height:0.5]];
            [self.adapters  addObject:[LYZOrderELecInvoiceCell dataAdapterWithData:self.orderDetailModel cellHeight:LYZOrderELecInvoiceCell.cellHeight]];
        }else if (self.orderDetailModel.invoiceJson.invoiceType.intValue == 2){
            //纸质发票
            [self.adapters addObject:[LYZOrderInvoiceCell dataAdapterWithData:@{@"invoiceType":@"纸质发票"} cellHeight:LYZOrderInvoiceCell.cellHeight]];
            [self.adapters addObject:[self lineType:kShortType height:0.5]];
            [self.adapters addObject:[LYZOrderPaperInvoiceCell dataAdapterWithData:self.orderDetailModel.invoiceJson cellHeight:[LYZOrderPaperInvoiceCell cellHeightWithData:self.orderDetailModel.invoiceJson]]];
        }
           [self.adapters addObject:[self lineType:kSpace height:20]];
    }else{
        [self.adapters addObject:[LYZOrderNoCell dataAdapterWithData:self.orderDetailModel cellHeight:LYZOrderNoCell.cellHeight]];
        [self.adapters addObject:[self lineType:kLongType height:0.5]];
        [self.adapters addObject:[LYZOrderStatusCell dataAdapterWithData:self.orderDetailModel cellHeight:LYZOrderStatusCell.cellHeight]];
        [self.adapters addObject:[self lineType:kSpace height:15]];
        [self.adapters addObject:[LYZOrderSumPaymentCell dataAdapterWithData:self.orderDetailModel cellHeight:LYZOrderSumPaymentCell.cellHeight]];
        [self.adapters addObject:[self lineType:kShortType height:0.5]];
        [self.adapters addObject:[LYZOrderPayDetailCell dataAdapterWithData:self.orderDetailModel cellHeight:LYZOrderPayDetailCell.cellHeight]];
        [self.adapters addObject:[self lineType:kSpace height:15]];
        [self.adapters addObject:[LYZOrderHotelInfoCell dataAdapterWithData:self.orderDetailModel cellHeight:LYZOrderHotelInfoCell.cellHeight]];
        [self.adapters addObject:[self lineType:kLongType height:0.5]];
        [self.adapters addObject:[LYZOrderCheckInDateCell dataAdapterWithData:self.orderDetailModel cellHeight:LYZOrderCheckInDateCell.cellHeight]];
        [self.adapters addObject:[self lineType:kShortType height:0.5]];
        for (int i = 0; i < self.orderDetailModel.childOrderInfoJar.count; i ++) {
            [self.adapters addObject:[LYZGuestInfoCell  dataAdapterWithData:@{@"roomNum":[NSNumber numberWithInt:i + 1],@"Model":self.orderDetailModel.childOrderInfoJar[i]} cellHeight:LYZGuestInfoCell.cellHeight]];
            if (i == self.orderDetailModel.childOrderInfoJar.count -1) {
                break;
            }
            [self.adapters addObject:[self lineType:kShortType height:0.5]];
        }
        [self.adapters addObject:[self lineType:kLongType height:0.5]];
        [self.adapters addObject:[LYZGuestPhoneCell dataAdapterWithData:self.orderDetailModel cellHeight:LYZGuestPhoneCell.cellHeight]];
        [self.adapters addObject:[self lineType:kLongType height:0.5]];
        if (self.orderDetailModel.invoiceJson.invoiceType.intValue == 1) {
            //电子发票
            [self.adapters addObject:[LYZOrderInvoiceCell dataAdapterWithData:@{@"invoiceType":@"电子发票"} cellHeight:LYZOrderInvoiceCell.cellHeight]];
            [self.adapters addObject:[self lineType:kShortType height:0.5]];
            [self.adapters  addObject:[LYZOrderELecInvoiceCell dataAdapterWithData:self.orderDetailModel cellHeight:LYZOrderELecInvoiceCell.cellHeight]];
        }else if (self.orderDetailModel.invoiceJson.invoiceType.intValue == 2){
            //纸质发票
            [self.adapters addObject:[LYZOrderInvoiceCell dataAdapterWithData:@{@"invoiceType":@"纸质发票"} cellHeight:LYZOrderInvoiceCell.cellHeight]];
            [self.adapters addObject:[self lineType:kShortType height:0.5]];
            [self.adapters addObject:[LYZOrderPaperInvoiceCell dataAdapterWithData:self.orderDetailModel.invoiceJson cellHeight:[LYZOrderPaperInvoiceCell cellHeightWithData:self.orderDetailModel.invoiceJson]]];
        }
         [self.adapters addObject:[self lineType:kSpace height:20]];
       
    }
       [GCDQueue  executeInMainQueue:^{
        [self.tableView reloadData];
    }];
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

- (void)createTableViewAndRegisterCells {
    
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 60 - 64)]; 
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [ColorSpaceCell  registerToTableView:self.tableView];
    [LYZOrderStatusCell registerToTableView:self.tableView];
    [LYZOrderNoCell registerToTableView:self.tableView];
    [LYZOrderSumPaymentCell registerToTableView:self.tableView];
    [LYZOrderPayDetailCell registerToTableView:self.tableView];
    [LYZOrderHotelInfoCell registerToTableView:self.tableView];
    [LYZOrderCheckInDateCell registerToTableView:self.tableView];
    [LYZGuestInfoCell registerToTableView:self.tableView];
    [LYZGuestPhoneCell registerToTableView:self.tableView];
    [LYZOrderInvoiceCell registerToTableView:self.tableView];
    [LYZOrderPaperInvoiceCell registerToTableView:self.tableView];
    [LYZOrderELecInvoiceCell registerToTableView:self.tableView];
    [LYZRenewOrderLiveUserInfoCell registerToTableView:self.tableView];
    __weak UITableView *tableView = self.tableView;
    __weak typeof(self)weakSelf = self;
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchOrderData];
    }];
    

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
    WEAKSELF;
    if ([cell isKindOfClass:[LYZOrderHotelInfoCell class]]) {
        LYZOrderHotelInfoCell *hotelInfoCell = (LYZOrderHotelInfoCell *)cell;
        hotelInfoCell.toHotel = ^(){
            [weakSelf jumpToHotel];
        };
    }
    [cell loadContent];
    // WEAKSELF;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {
    LYLog(@"%@", event);
   
}


#pragma mark - Btn Action

-(void)showPaymentDetail{
    PaymentDetailViewController *vc = [[PaymentDetailViewController alloc] init];
    vc.orderDetail = self.orderDetailModel;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)jumpToHotel{
    WEAKSELF;
    LYZHotelViewController *vc = [[LYZHotelViewController alloc] init];
    vc.i_hotelId = weakSelf.orderDetailModel.hotelJson.hotelID;
    [weakSelf.navigationController pushViewController:vc animated:YES];
}

-(void)phoneCall{
    [LYZPhoneCall noAlertCallPhoneStr:CustomerServiceNum withVC:self];
}



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
            payVC.orderNumber = self.orderDetailModel.orderJson.orderNO;
            payVC.orderType =[NSString stringWithFormat:@"%@",self.orderDetailModel.orderJson.orderType];
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
           
            payVC.orderNumber = self.orderDetailModel.orderJson.orderNO;
            
            payVC.orderType =  [NSString stringWithFormat:@"%@",self.orderDetailModel.orderJson.orderType];
            [self.navigationController pushViewController:payVC animated:YES];
        });
        
    }else{
        JGProgressHUD *hud  = [Public hudWHenFailure];
        hud.textLabel.text = @"支付失败！";
        [hud showInView:self.view];
        [hud dismissAfterDelay:2.0 animated:YES];
    }
}


-(void)floatBtnClick:(id)sender{
    
    NSDateFormatter *formatter_1 = [[NSDateFormatter alloc] init];
    [formatter_1 setDateFormat:@"yyyy-MM-dd"];
    if (self.orderDetailModel.orderJson.hostStatus.integerValue == 1) {
        if (self.orderDetailModel.orderJson.childStatus.intValue == 0) {
            //立即支付
            self.payNow = YES;
            [self  setPayView];
            if (self.orderDetailModel.orderJson.orderType.integerValue == 1) {
                [self countMoney];
            }else{
                [self countRenewMoney];
            }
            
        }else if (self.orderDetailModel.orderJson.childStatus.intValue == 1){
            //导航
            HotelMapViewController *vc = [[HotelMapViewController alloc] init];
            vc.ilatidute = self.orderDetailModel.hotelJson.latitude;
            vc.ilongitude = self.orderDetailModel.hotelJson.longitude;
            vc.address = self.orderDetailModel.hotelJson.address;
            vc.hotelName = self.orderDetailModel.hotelJson.hotelName;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (self.orderDetailModel.orderJson.childStatus.intValue == 2){
            LYZRenewViewController *vc = [[LYZRenewViewController alloc] init];
            vc.orderNo = self.orderDetailModel.orderJson.orderNO;
            vc.orderType = [NSString stringWithFormat:@"%@",self.orderDetailModel.orderJson.orderType];
            vc.roomTypeID = self.orderDetailModel.hotelJson.roomTypeID;
            [self.navigationController pushViewController:vc animated:YES];
        }else if (self.orderDetailModel.orderJson.childStatus.intValue == 3){
            //续住
            LYZRenewViewController *vc = [[LYZRenewViewController alloc] init];
            vc.orderNo = self.orderDetailModel.orderJson.orderNO;
            vc.orderType = [NSString stringWithFormat:@"%@",self.orderDetailModel.orderJson.orderType];
            vc.roomTypeID = self.orderDetailModel.hotelJson.roomTypeID;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            //再次预订
            LYZOrderCommitViewController *vc = [[LYZOrderCommitViewController alloc] init];
            vc.fromOrderNO =self.orderDetailModel.orderJson.orderNO;
            vc.fromOrderType = [NSString stringWithFormat:@"%@",self.orderDetailModel.orderJson.orderType];
            vc.checkInDate = [formatter_1 dateFromString:self.orderDetailModel.orderJson.checkInDate];
            vc.checkOutDate =  [formatter_1 dateFromString:self.orderDetailModel.orderJson.checkOutDate];
            vc.roomTypeID =  self.orderDetailModel.hotelJson.roomTypeID;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        LYZOrderCommitViewController *vc = [[LYZOrderCommitViewController alloc] init];
        vc.fromOrderNO =self.orderDetailModel.orderJson.orderNO;
        vc.fromOrderType = [NSString stringWithFormat:@"%@",self.orderDetailModel.orderJson.orderType];
        vc.checkInDate = [formatter_1 dateFromString:self.orderDetailModel.orderJson.checkInDate];
        vc.checkOutDate =  [formatter_1 dateFromString:self.orderDetailModel.orderJson.checkOutDate];
        vc.roomTypeID =  self.orderDetailModel.hotelJson.roomTypeID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

-(void)cancelOrder:(NSString *)orderNo orderType:(NSString *)orderType{
    JGProgressHUD *hud = [Public hudWhenRequest];
    [hud showInView:self.view animated:YES];
    [[LYZNetWorkEngine sharedInstance] recallOrder:VersionCode devicenum:DeviceNum fromtype:FromType orderNO:orderNo orderType:orderType  block:^(int event, id object) {
        [hud dismissAnimated:YES];
        if (event == 1) {
            self.payNow = NO;
            [self fetchOrderData];
        }else if (event == 18){
            [Public showJGHUDWhenError:self.view msg:@"订单无法取消"];
        }else if (event == 17){
            [Public showJGHUDWhenError:self.view msg:@"订单已支付"];
        }
        else{
            [Public showJGHUDWhenError:self.view msg:object];
        }
    }];
}

-(void)dealloc{
    NSLog(@"dealloc");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
