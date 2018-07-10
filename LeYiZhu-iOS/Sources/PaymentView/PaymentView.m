//
//  PaymentView.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/7.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "PaymentView.h"
#import "CountMoneyModel.h"
#import "UIView+SetRect.h"
#import "RoomPriceModel.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "paymentDetailCommonCell.h"
#import "GCD.h"
#import "RenewRoomInfoModel.h"
#import "CountRefillLiveMoneyModel.h"
#import "NSDate+Utilities.h"
#import "BaseOrderDetailModel.h"

#define kPayBtnScale 0.096
#define kLeftSpace  (0.093 * SCREEN_WIDTH)
#define kPayBtnWidth  (SCREEN_WIDTH * kPayBtnScale)

#define kCellHeightYScale 0.075
#define kCellHeight (kCellHeightYScale * SCREEN_HEIGHT)

#define kFootViewYScale 0.12



@interface PaymentView ()<UITableViewDelegate, UITableViewDataSource,CustomCellDelegate>

@property (nonatomic, strong) UITableView *paymentTable;

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@property (nonatomic,strong) UIView *footView;
@property (nonatomic, strong) UILabel *headTitleLabel;
@property (nonatomic, strong) UILabel *paymoneyTitleLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, assign) CGFloat tableHeight;


@end

@implementation PaymentView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.headTitleLabel];
        [self addSubview:self.paymentTable];
        self.paymoneyTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.paymoneyTitleLabel.textColor = RGB(51, 51, 51);
        CGFloat moneyFont = iPhone5_5s ? 14 : 16;
        self.paymoneyTitleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:moneyFont];
        [self addSubview:self.paymoneyTitleLabel];
        
        self.moneyLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.moneyLabel.textColor = RGB(51, 51, 51);
        self.moneyLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:moneyFont];
        [self addSubview:self.moneyLabel];
        
        [self addSubview:self.footView];

    }
    return self;
}

-(UITableView *)paymentTable{
    if (!_paymentTable) {
        _paymentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headTitleLabel.bottom, SCREEN_WIDTH, 0)];
        _paymentTable.delegate        = self;
        _paymentTable.dataSource      = self;
        _paymentTable.backgroundColor = [UIColor clearColor];
        _paymentTable.separatorStyle  = UITableViewCellSeparatorStyleNone;
        [ColorSpaceCell registerToTableView:_paymentTable];
        [paymentDetailCommonCell registerToTableView:_paymentTable];
        
    }
    return _paymentTable;
}

-(UILabel *)headTitleLabel{
    if (!_headTitleLabel) {
        _headTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kCellHeight)];
        _headTitleLabel.textColor = RGB(51, 51, 51);
        CGFloat titleFont = iPhone5_5s ? 14.0f : 16.0f;
        _headTitleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:titleFont];
        _headTitleLabel.backgroundColor = [UIColor whiteColor];
        _headTitleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _headTitleLabel;
}



-(UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kFootViewYScale *SCREEN_HEIGHT)];
        _footView.backgroundColor = [UIColor whiteColor];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = [UIColor colorWithHexString:@"E8E8E8"];
        [_footView addSubview:line];
        
        UIImageView *wxImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kPayBtnWidth, kPayBtnWidth)];
        wxImg.x = kLeftSpace;
        wxImg.centerY =_footView.height / 2.0;
        wxImg.image = [UIImage imageNamed:@"pay_icon_weixin"];
        [_footView addSubview:wxImg];

        UILabel *wxLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(wxImg.right +8, wxImg.y, 100, kPayBtnWidth)
        wxLabel.textColor = [UIColor blackColor];
        CGFloat payFont = iPhone5_5s ? 16 : 18;
        wxLabel.font = [UIFont fontWithName:LYZTheme_Font_Medium size:payFont];
        wxLabel.text = @"微信支付";
        [wxLabel sizeToFit];
        wxLabel.x = wxImg.right + 8;
        wxLabel.centerY = wxImg.centerY;
        [_footView addSubview:wxLabel];

        UIButton *wxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        wxBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH/2.0, _footView.height);
        [wxBtn addTarget:self action:@selector(wxPay:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:wxBtn];


        UILabel *AliLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        AliLabel.textColor = [UIColor blackColor];
        AliLabel.font = [UIFont fontWithName:LYZTheme_Font_Medium size:payFont];
        AliLabel.text = @"支付宝支付";
        [AliLabel sizeToFit];
        AliLabel.right = SCREEN_WIDTH -  kLeftSpace;
        AliLabel.centerY = wxImg.centerY;
        [_footView addSubview:AliLabel];

        UIImageView *AliImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kPayBtnWidth, kPayBtnWidth)];
        AliImg.right = AliLabel.x - 8;
        AliImg.centerY = wxImg.centerY;
        AliImg.image = [UIImage imageNamed:@"pay_icon_zhifubao"];
        [_footView addSubview:AliImg];


        UIButton *aliBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        aliBtn.frame = CGRectMake(SCREEN_WIDTH/2.0, 0, SCREEN_WIDTH/2.0, _footView.height);
        [aliBtn addTarget:self action:@selector(AliPay:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:aliBtn];
    }
    return _footView;
}

#pragma mark - Data Config
//订单详情页面弹出是调用
- (void)configureWithLocalMoneyModel:(BaseOrderDetailModel*)moneyModel{
    if (!self.adapters) {
        _adapters= [NSMutableArray array];
    }
    if (self.adapters.count) {
        [_adapters removeAllObjects];
    }
    NSArray *renewArr = moneyModel.childOrderInfoJar;
    for (int i = 0; i <  renewArr.count; i ++) {
         [_adapters addObject:[self lineType:kLongType height:0.5]];
        RenewRoomInfoModel *renewModel = renewArr[i];
        RoomPriceModel *startModel = [renewModel.roomPrice firstObject];
        RoomPriceModel *endModel = [renewModel.roomPrice lastObject];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDateFormatter *formatter_1 = [[NSDateFormatter alloc] init];
        [formatter_1 setDateFormat:@"MM.dd"];
        NSDate *checkInDate = [formatter dateFromString:startModel.checkInDate];
        NSDate *checkOutDate = [[formatter dateFromString:endModel.checkInDate] dateByAddingDays:1];
        NSString *dateStr = [NSString stringWithFormat:@"%@ - %@",[formatter_1 stringFromDate:checkInDate], [formatter_1 stringFromDate:checkOutDate]];
        NSString *livedayStr = [NSString stringWithFormat:@"共%@天",renewModel.liveDay];
        NSDictionary *dateDic = @{@"left":dateStr, @"right":livedayStr};
        [_adapters addObject:[paymentDetailCommonCell dataAdapterWithData:dateDic cellHeight:kCellHeight]];
        [_adapters addObject:[self lineType:kShortType height:0.5]];
        NSString *roomCount = [NSString stringWithFormat:@"%@间",@"1"];
        NSDictionary *roomDic = @{@"left":moneyModel.hotelJson.roomType,@"right":roomCount};
        [_adapters addObject:[paymentDetailCommonCell dataAdapterWithData:roomDic cellHeight:kCellHeight]];
        if (i == renewArr.count - 1) {
            [_adapters addObject:[self lineType:kLongType height:0.5]];
        }
    }
    self.headTitleLabel.text = moneyModel.hotelJson.hotelName;
    self.paymoneyTitleLabel.text = @"支付金额";
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",moneyModel.orderJson.actualPayment];
    
    self.tableHeight = renewArr.count > 1 ? renewArr.count *( 2 *kCellHeight + 1.5): ( 2 *kCellHeight + 1.5)   ;
    [GCDQueue executeInMainQueue:^{
        [self layoutSubviews];
        [self.paymentTable reloadData];
    }];
}

- (void)configureWithMoneyModel:(CountMoneyModel*)moneyModel hotelName:(NSString *)hotelName roomType:(NSString *)roomType{
    
    if (!self.adapters) {
        _adapters= [NSMutableArray array];
    }
    if (self.adapters.count) {
        [_adapters removeAllObjects];
    }
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    
    RoomPriceModel *startModel = [moneyModel.roomPrice firstObject];
    RoomPriceModel *endModel = [moneyModel.roomPrice lastObject];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter_1 = [[NSDateFormatter alloc] init];
    [formatter_1 setDateFormat:@"MM.dd"];
    NSDate *checkInDate = [formatter dateFromString:startModel.checkInDate];
    NSDate *checkOutDate = [[formatter dateFromString:endModel.checkInDate] dateByAddingDays:1];
    NSString *dateStr = [NSString stringWithFormat:@"%@ - %@",[formatter_1 stringFromDate:checkInDate], [formatter_1 stringFromDate:checkOutDate]];
    NSString *livedayStr = [NSString stringWithFormat:@"共%@天",moneyModel.liveDay];
    NSDictionary *dateDic = @{@"left":dateStr, @"right":livedayStr};
    [_adapters addObject:[paymentDetailCommonCell dataAdapterWithData:dateDic cellHeight:kCellHeight]];
    [_adapters addObject:[self lineType:kShortType height:0.5]];
    NSString *roomCount = [NSString stringWithFormat:@"%@间",moneyModel.payNum];
    NSDictionary *roomDic = @{@"left":roomType ? : @"",@"right":roomCount};
    [_adapters addObject:[paymentDetailCommonCell dataAdapterWithData:roomDic cellHeight:kCellHeight]];
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    self.headTitleLabel.text = hotelName;
    self.paymoneyTitleLabel.text = @"支付金额";
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",moneyModel.actualPayment];
    self.tableHeight =  2 *kCellHeight + 1.5;
    
    [GCDQueue executeInMainQueue:^{
        [self layoutSubviews];
        [self.paymentTable reloadData];
    }];
}



- (void)configureWithRenewMoneyModel:(CountRefillLiveMoneyModel*)moneyModel hotelName:(NSString *)hotelName roomType:(NSString *)roomType{
    
    if (!self.adapters) {
        _adapters= [NSMutableArray array];
    }
    if (self.adapters.count) {
        [_adapters removeAllObjects];
    }
   
    NSArray *renewArr = moneyModel.childOrderInfoJar;
    for (int i = 0; i <  renewArr.count; i ++) {
         [_adapters addObject:[self lineType:kLongType height:0.5]];
        RenewRoomInfoModel *renewModel = renewArr[i];
        RoomPriceModel *startModel = [renewModel.roomPrice firstObject];
        RoomPriceModel *endModel = [renewModel.roomPrice lastObject];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDateFormatter *formatter_1 = [[NSDateFormatter alloc] init];
        [formatter_1 setDateFormat:@"MM.dd"];
        NSDate *checkInDate = [formatter dateFromString:startModel.checkInDate];
        NSDate *checkOutDate = [[formatter dateFromString:endModel.checkInDate] dateByAddingDays:1];
        NSString *dateStr = [NSString stringWithFormat:@"%@ - %@",[formatter_1 stringFromDate:checkInDate], [formatter_1 stringFromDate:checkOutDate]];
        NSString *livedayStr = [NSString stringWithFormat:@"共%@天",renewModel.liveDay];
        NSDictionary *dateDic = @{@"left":dateStr, @"right":livedayStr};
        [_adapters addObject:[paymentDetailCommonCell dataAdapterWithData:dateDic cellHeight:kCellHeight]];
        [_adapters addObject:[self lineType:kShortType height:0.5]];
        NSString *roomCount = [NSString stringWithFormat:@"%@间",@"1"];
        NSDictionary *roomDic = @{@"left":roomType,@"right":roomCount};
        [_adapters addObject:[paymentDetailCommonCell dataAdapterWithData:roomDic cellHeight:kCellHeight]];
       
        if (i == renewArr.count - 1) {
           [_adapters addObject:[self lineType:kLongType height:0.5]];
        }
    }
    self.headTitleLabel.text = hotelName;
    self.paymoneyTitleLabel.text = @"支付金额";
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",moneyModel.actualPayment];
    
    self.tableHeight =renewArr.count > 1 ? renewArr.count *( 2 *kCellHeight + 1) + 0.5 : ( 2 *kCellHeight + 1.5) ;
    [GCDQueue executeInMainQueue:^{
        [self layoutSubviews];
        [self.paymentTable reloadData];
    }];
    
}

#pragma mark - UI Update

-(void)layoutSubviews{

        self.headTitleLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, kCellHeight);
        self.paymentTable.frame = CGRectMake(0, self.headTitleLabel.bottom, SCREEN_WIDTH, self.tableHeight);
        [self.paymoneyTitleLabel sizeToFit];
        self.paymoneyTitleLabel.x = DefaultLeftSpace;
        self.paymoneyTitleLabel.centerY = self.paymentTable.bottom + kCellHeight /2.0;
        [self.moneyLabel sizeToFit];
        self.moneyLabel.right = SCREEN_WIDTH - DefaultLeftSpace;
        self.moneyLabel.centerY = self.paymoneyTitleLabel.centerY;
        self.footView.frame = CGRectMake(0, self.paymentTable.bottom + kCellHeight, SCREEN_WIDTH, kFootViewYScale *SCREEN_HEIGHT);
        self.height = self.paymoneyTitleLabel.height + self.paymentTable.height + kCellHeight + self.footView.height;
}

#pragma mark - TableView Related

- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height{
    if (type == kSpace) {
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" :LYZTheme_BackGroundColor} cellHeight:15.f];
    } else if (type == kLongType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :[UIColor colorWithHexString:@"E8E8E8"]} cellHeight:0.5f];
        
    } else if (type == kShortType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" : [UIColor colorWithHexString:@"E8E8E8"], @"leftGap" : @(20.f)} cellHeight:0.5f];
        
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
    
    [cell loadContent];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark -- Btn Actions

-(void)wxPay:(UIButton *)sender{
    if (self.wxPay) {
        self.wxPay();
    }
}

-(void)AliPay:(UIButton *)sender{
    if (self.aliPay) {
        self.aliPay();
    }
}

@end
