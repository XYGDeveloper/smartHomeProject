//
//  LYZOrderFormListCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/21.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZOrderFormListCell.h"
#import "BaseLYZOrders.h"
#import "LYZMyOrderViewController.h"

#define kLeftLabelWidth 250.0f
#define kRightLabelWidth 75.0f

#define kStatusTitleKey @"sTitlekey"
#define kStatusColorKey @"sColorkey"
#define kStatusBtnTitleKey @"sBtnTitleKey"
#define kWaitPayColor  [UIColor colorWithHexString:@"#d0021b"]
#define kwaitCheckInColor   [UIColor colorWithHexString:@"#e6853a"]
#define kCheckInColor   [UIColor colorWithHexString:@"#7387bc"]

@interface LYZOrderFormListCell ()

@property (nonatomic ,strong) UILabel *hotelNameLabel;
@property (nonatomic,strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *roomTypeLabel;
@property (nonatomic,strong) UILabel *roomCountLabel;
@property (nonatomic, strong) UILabel *timeRangeLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *orderBtn;
@end

static CGFloat _OrderFormListCellHeight = 134.0f;

@implementation LYZOrderFormListCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    self.hotelNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 14, kLeftLabelWidth, 20)];
    self.hotelNameLabel.textColor = [UIColor blackColor];
    self.hotelNameLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    [self addSubview:self.hotelNameLabel];
    
    self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - kRightLabelWidth, 14, kRightLabelWidth, 20)];
    self.statusLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.statusLabel];
    
    self.roomTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, self.hotelNameLabel.bottom + 6, SCREEN_WIDTH - 2*DefaultLeftSpace, 20)];
    self.roomTypeLabel.textColor =LYZTheme_BrownishGreyFontColor;
    self.roomTypeLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14];
    [self addSubview:self.roomTypeLabel];
    
//    self.roomCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.roomTypeLabel.right - 100, self.hotelNameLabel.bottom + 6, 50, 20)];
//    self.roomCountLabel.textColor =LYZTheme_BrownishGreyFontColor;
//    self.roomCountLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14];
//    [self addSubview:self.roomCountLabel];
    
    self.timeRangeLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, self.roomTypeLabel.bottom + 6, kLeftLabelWidth, 20)];
    self.timeRangeLabel.textColor =LYZTheme_BrownishGreyFontColor;
    self.timeRangeLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14];
    [self addSubview:self.timeRangeLabel];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(DefaultLeftSpace, self.timeRangeLabel.bottom + 6, kLeftLabelWidth, 28)];
    self.priceLabel.textColor =LYZTheme_paleBrown;
    self.priceLabel.font = [UIFont fontWithName:LYZTheme_Font_Medium size:18];
    [self addSubview:self.priceLabel];
    
    self.orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.orderBtn.frame = CGRectMake(SCREEN_WIDTH - DefaultLeftSpace - kRightLabelWidth, self.priceLabel.y, kRightLabelWidth, 28);
    [self.orderBtn addTarget: self action:@selector(orderBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.orderBtn setBackgroundColor:LYZTheme_paleBrown];
    self.orderBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14];
    self.orderBtn.layer.cornerRadius = 2.0f;
    [self.orderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:self.orderBtn];
    
}


- (void)loadContent {
    BaseLYZOrders *order = (BaseLYZOrders *)self.data;
    OrderModel *oModel = order.orderJson;
    OrderHotelModel *hModel = order.hotelJson;
    self.hotelNameLabel.text = hModel.hotelName;
    self.statusLabel.text = [[self getStatusTextAndTextColor:oModel.childStatus.integerValue] objectForKey:kStatusTitleKey];
    self.statusLabel.textColor = [[self getStatusTextAndTextColor:oModel.childStatus.integerValue] objectForKey:kStatusColorKey];
    if (oModel.hostStatus.integerValue == 1) {
        self.statusLabel.textColor = [[self getStatusTextAndTextColor:oModel.childStatus.integerValue] objectForKey:kStatusColorKey];
        self.statusLabel.text = [[self getStatusTextAndTextColor:oModel.childStatus.integerValue] objectForKey:kStatusTitleKey];
    }else if (oModel.hostStatus.integerValue == 0){
        self.statusLabel.textColor = LYZTheme_warmGreyFontColor;
        self.statusLabel.text = @"已取消";
    }
    self.roomTypeLabel.text = [NSString stringWithFormat:@"房型：%@       %@间",hModel.roomType,oModel.payNum];
//    self.roomCountLabel.text = [NSString stringWithFormat:@"%@间",oModel.payNum];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *formatter_1  = [[NSDateFormatter alloc] init];
    [formatter_1 setDateFormat:@"MM月dd日"];
    NSDate *checkIn = [formatter dateFromString:oModel.checkInDate];
    NSDate *checkOut = [formatter dateFromString:oModel.checkOutDate];
    if (oModel.orderType.integerValue == 2) {
        self.timeRangeLabel.text = [NSString stringWithFormat:@"入住时段:   点击查看更多"];
    }else{
        self.timeRangeLabel.text = [NSString stringWithFormat:@"入住时段：%@到%@",[formatter_1 stringFromDate:checkIn],[formatter_1 stringFromDate:checkOut]];
    }
       self.priceLabel.text = [NSString stringWithFormat:@"￥%@",oModel.actualPayment];
    NSString *btnTitle;
    if (oModel.hostStatus.integerValue == 1) {
        btnTitle = [[self getStatusTextAndTextColor:oModel.childStatus.integerValue] objectForKey:kStatusBtnTitleKey];
    }else if (oModel.hostStatus.integerValue == 0){
        btnTitle = @"重新预订";
    }
    [self.orderBtn setTitle:btnTitle forState:UIControlStateNormal];
}

-(NSDictionary *)getStatusTextAndTextColor:(NSInteger)status{
    NSDictionary *dic = nil;
    switch (status) {
        case 0:
            dic = @{kStatusTitleKey:@"待支付",kStatusColorKey:kWaitPayColor,kStatusBtnTitleKey:@"立即支付"};
            break;
        case 1:
            dic = @{kStatusTitleKey:@"待入住",kStatusColorKey:kwaitCheckInColor,kStatusBtnTitleKey:@"酒店地址"};
            break;
        case 2:
            dic = @{kStatusTitleKey:@"已入住",kStatusColorKey:kCheckInColor,kStatusBtnTitleKey:@"续住"};
            break;
        case 3:
            dic = @{kStatusTitleKey:@"已入住",kStatusColorKey:kCheckInColor,kStatusBtnTitleKey:@"续住"};
            break;
        case 4:
            dic = @{kStatusTitleKey:@"已退房",kStatusColorKey:LYZTheme_warmGreyFontColor,kStatusBtnTitleKey:@"再次预订"};
            break;
        default:
            break;
    }
    return dic;
}
- (void)selectedEvent {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(customCell:event:)]) {
        [self.delegate customCell:self event:self.data];
    }
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    _OrderFormListCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    return _OrderFormListCellHeight;
}

#pragma mark --Btn Actions

-(void)orderBtnClick:(UIButton *)sender{
    LYZMyOrderViewController *vc = (LYZMyOrderViewController *)self.controller;
    if ([vc respondsToSelector:@selector(orderBtnClicked:)]) {
        [vc orderBtnClicked:self.data];
    }
}


@end
