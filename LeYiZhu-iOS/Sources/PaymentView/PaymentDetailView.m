//
//  PaymentDetailView.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/13.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "PaymentDetailView.h"
#import "UIView+SetRect.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "PaymentDetailCell.h"
#import "GCD.h"
#import "CountMoneyModel.h"
#import "CountRefillLiveMoneyModel.h"
#import "RoomPriceModel.h"
#import "RenewRoomInfoModel.h"

@interface PaymentDetailView ()<UITableViewDelegate, UITableViewDataSource,CustomCellDelegate>

@property (nonatomic, strong) UITableView *paymentTable;

@property (nonatomic, strong) UIView *maskView;

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@property (nonatomic, assign) CGFloat tableHeight;

@end

@implementation PaymentDetailView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self craetUI];
    }
    return self;
}

#pragma mark - UI Config

-(void)craetUI{
    [self addSubview:self.maskView];
    [self addSubview:self.paymentTable];
}

- (UIView*)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = .5;
        _maskView.userInteractionEnabled = YES;
        
        
    }
    return _maskView;
}

-(UITableView *)paymentTable{
    if (!_paymentTable) {
        _paymentTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        _paymentTable.delegate        = self;
        _paymentTable.dataSource      = self;
        _paymentTable.backgroundColor = [UIColor clearColor];
        _paymentTable.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _paymentTable.bounces = NO;
        [ColorSpaceCell registerToTableView:_paymentTable];
        [PaymentDetailCell registerToTableView:_paymentTable];
    }
    return _paymentTable;
}

#pragma mark - Data Config

- (void)configureWithRenewMoneyModel:(CountRefillLiveMoneyModel *)moneyModel{
    
    if (!self.adapters) {
        _adapters= [NSMutableArray array];
    }
    if (self.adapters.count) {
        [_adapters removeAllObjects];
    }
    NSString *actualPaymentMoney = [NSString stringWithFormat:@"￥%@",moneyModel.actualPayment];
    [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"在线支付" leftColor:LYZTheme_paleBrown leftFontSize:@16 rightContent:actualPaymentMoney rightColor:LYZTheme_paleBrown rightFontSize:@16] cellHeight:45]];
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    
    CGFloat roomPriceHeight = 0;
    for (int i = 0; i < moneyModel.childOrderInfoJar.count; i ++) {
        RenewRoomInfoModel * renewRoomInfo = moneyModel.childOrderInfoJar[i];
        NSString *stayMoneySum = [NSString stringWithFormat:@"￥%@",renewRoomInfo.roomPriceSum];
        NSString *roomName = [NSString stringWithFormat:@"%@号房房费",renewRoomInfo.roomNum];
        [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:roomName leftColor:RGB(29,29,38) leftFontSize:@15 rightContent:stayMoneySum rightColor:RGB(29,29,38) rightFontSize:@15] cellHeight:45]];
        roomPriceHeight += 45;
        for (int j =0; j < renewRoomInfo.roomPrice.count; j ++) {
            RoomPriceModel *priceModel = renewRoomInfo.roomPrice[j];
            NSString *price = [NSString stringWithFormat:@"￥%@ ",priceModel.price];
            [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:priceModel.checkInDate leftColor:LYZTheme_warmGreyFontColor leftFontSize:@14 rightContent:price rightColor:LYZTheme_warmGreyFontColor rightFontSize:@14] cellHeight:30]];
            roomPriceHeight += 30;
        }
        if (i != moneyModel.childOrderInfoJar.count - 1) {
            [_adapters addObject:[self lineType:kShortType height:0.5]];
            roomPriceHeight += 0.5;
        }
    }
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    NSString *deposit =  [NSString stringWithFormat:@"￥%@",moneyModel.depositSum];
    [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"押金" leftColor:RGB(29,29,38) leftFontSize:@15 rightContent:deposit rightColor:RGB(29,29,38) rightFontSize:@15] cellHeight:45]];
    
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    
    NSString *discount = [NSString stringWithFormat:@"-￥%@",moneyModel.totalDiscount];
    [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"优惠" leftColor:RGB(29,29,38) leftFontSize:@15 rightContent:discount rightColor:RGB(29,29,38) rightFontSize:@15] cellHeight:45]];
    NSString *coupondenominat = [NSString stringWithFormat:@"-￥%@",moneyModel.coupondenominat];
    [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"优惠券" leftColor:LYZTheme_warmGreyFontColor leftFontSize:@14 rightContent:coupondenominat rightColor:LYZTheme_warmGreyFontColor rightFontSize:@14] cellHeight:30]];
    
    self.tableHeight = 45 * 3 + 0.5 * 3 + 30 + roomPriceHeight  > SCREEN_HEIGHT *7 /10.0 - 60 ? SCREEN_HEIGHT *7 /10.0  - 60 :   45 * 3 + 0.5 * 3 + 30 + roomPriceHeight;
    
    [GCDQueue executeInMainQueue:^{
        [self layoutSubviews];
        [self.paymentTable reloadData];
    }];
}


- (void)configureWithMoneyModel:(CountMoneyModel*)moneyModel{
    
    if (!self.adapters) {
        _adapters= [NSMutableArray array];
    }
    if (self.adapters.count) {
        [_adapters removeAllObjects];
    }
    NSString *actualPaymentMoney = [NSString stringWithFormat:@"￥%@",moneyModel.actualPayment];
    [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"在线支付" leftColor:LYZTheme_paleBrown leftFontSize:@16 rightContent:actualPaymentMoney rightColor:LYZTheme_paleBrown rightFontSize:@16] cellHeight:45]];
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    NSString *stayMoneySum = [NSString stringWithFormat:@"￥%@",moneyModel.stayMoneySum];
    [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"房费" leftColor:RGB(29,29,38) leftFontSize:@15 rightContent:stayMoneySum rightColor:RGB(29,29,38) rightFontSize:@15] cellHeight:45]];
    for (int i = 0; i < moneyModel.roomPrice.count; i ++) {
        RoomPriceModel *priceModel = moneyModel.roomPrice[i];
        NSString *price = [NSString stringWithFormat:@"￥%@ x %@间",priceModel.price,moneyModel.payNum];
         [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:priceModel.checkInDate leftColor:LYZTheme_warmGreyFontColor leftFontSize:@14 rightContent:price rightColor:LYZTheme_warmGreyFontColor rightFontSize:@14] cellHeight:30]];
    }
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    NSString *deposit =  [NSString stringWithFormat:@"￥%@ x %@间",moneyModel.deposit,moneyModel.payNum];
     [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"押金" leftColor:RGB(29,29,38) leftFontSize:@15 rightContent:deposit rightColor:RGB(29,29,38) rightFontSize:@15] cellHeight:45]];
    
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    
       NSString *discount = [NSString stringWithFormat:@"-￥%@",moneyModel.totalDiscount];
      [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"优惠" leftColor:RGB(29,29,38) leftFontSize:@15 rightContent:discount rightColor:RGB(29,29,38) rightFontSize:@15] cellHeight:45]];
    NSString *coupon = [NSString stringWithFormat:@"-￥%@",moneyModel.coupondenominat];
     [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"优惠券" leftColor:LYZTheme_warmGreyFontColor leftFontSize:@14 rightContent:coupon rightColor:LYZTheme_warmGreyFontColor rightFontSize:@14] cellHeight:30]];
    
    self.tableHeight = 45 * 4 + 0.5 * 3 + 30 + moneyModel.roomPrice.count * 30 > SCREEN_HEIGHT *7 /10.0 - 60 ? SCREEN_HEIGHT *7 /10.0  - 60 : 45 * 4 + 0.5 * 3 + 30 + moneyModel.roomPrice.count * 30;

    [GCDQueue executeInMainQueue:^{
        [self layoutSubviews];
        [self.paymentTable reloadData];
    }];
}

-(NSDictionary *)dictionaryWithLeftContent:(NSString *)leftContent leftColor:(UIColor *)leftColor leftFontSize:(NSNumber *)leftFontSize rightContent:(NSString *)rightContent rightColor:(UIColor *)rightColor rightFontSize:(NSNumber *)rightFontSize{
    return @{@"leftContent":leftContent,@"leftColor":leftColor,@"leftFont" :leftFontSize ,@"rightContent":  rightContent,@"rightColor":rightColor, @"rightFont":rightFontSize};
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.paymentTable.height = self.tableHeight;
    [self show];
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

#pragma mark - Show 、 Dismiss

- (void)show {
    _paymentTable.frame = CGRectMake(0, SCREEN_HEIGHT - 64, SCREEN_WIDTH, _paymentTable.height);
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = _paymentTable.frame;
        rect.origin.y -= _paymentTable.bounds.size.height + 60; //60 为底部支付栏高度
        _paymentTable.frame = rect;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = _paymentTable.frame;
        rect.origin.y += _paymentTable.bounds.size.height + 60;
        _paymentTable.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}


@end
