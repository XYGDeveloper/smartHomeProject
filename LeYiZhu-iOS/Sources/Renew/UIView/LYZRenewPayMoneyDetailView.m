//
//  LYZRenewPayMoneyDetailView.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/4/17.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZRenewPayMoneyDetailView.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "LYZRenewMoneyDetailCommonCell.h"
#import "LYZRenewMoneyLiveUserInfoCell.h"
#import "CountRefillLiveMoneyModel.h"
#import "RenewRoomInfoModel.h"
#import "GCD.h"
#import "LYZCountRenewMoneyModel.h"
#import "BaseOrderDetailModel.h"
#import "UIView+SetRect.h"

#define kPayBtnScale 0.096
#define kLeftSpace  (0.093 * SCREEN_WIDTH)

#define kPayBtnWidth  (SCREEN_WIDTH * kPayBtnScale)

@interface LYZRenewPayMoneyDetailView ()<UITableViewDelegate, UITableViewDataSource,CustomCellDelegate>

@property (nonatomic, strong) UITableView *moneyDetailTable;

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@property (nonatomic,strong) UIView *footView;

@end

@implementation LYZRenewPayMoneyDetailView

-(id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.moneyDetailTable];
    }
    return self;
}


-(UITableView *)moneyDetailTable{
    if (!_moneyDetailTable) {
        _moneyDetailTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _moneyDetailTable.delegate        = self;
        _moneyDetailTable.dataSource      = self;
        _moneyDetailTable.backgroundColor = [UIColor clearColor];
        _moneyDetailTable.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _moneyDetailTable.tableFooterView = self.footView;
        [ColorSpaceCell registerToTableView:_moneyDetailTable];
        [LYZRenewMoneyDetailCommonCell registerToTableView:_moneyDetailTable];
        [LYZRenewMoneyLiveUserInfoCell registerToTableView:_moneyDetailTable];

    }
    return _moneyDetailTable;
}

-(UIView *)footView{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 78)];
        _footView.backgroundColor = [UIColor whiteColor];
        UIImageView *wxImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kPayBtnWidth, kPayBtnWidth)];
        wxImg.x = kLeftSpace;
        wxImg.centerY = _footView.height /2.0;
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
        wxBtn.frame = CGRectMake(0,0, SCREEN_WIDTH/2.0, _footView.height);
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
        aliBtn.frame = CGRectMake(SCREEN_WIDTH/2.0, 0 , SCREEN_WIDTH/2.0, _footView.height);
        [aliBtn addTarget:self action:@selector(AliPay:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:aliBtn];
    }
    return _footView;
}

- (void)configureWithMoneyModel:(CountRefillLiveMoneyModel*)moneyModel{
    if (!self.adapters) {
        _adapters= [NSMutableArray array];
    }
    if (self.adapters.count) {
        [_adapters removeAllObjects];
    }
    NSString *moneystaySum = [NSString stringWithFormat:@"￥%@",moneyModel.stayMoneySum];
    [_adapters addObject:[LYZRenewMoneyDetailCommonCell dataAdapterWithData:@{@"title":@"住宿费",@"money":moneystaySum,@"textColor":[UIColor colorWithHexString:@"#666666"]} cellHeight:LYZRenewMoneyDetailCommonCell.cellHeight]];
    [_adapters addObject:[self lineType:kShortType height:0.5]];
    for (int i = 0; i < moneyModel.childOrderInfoJar.count; i ++) {
        RenewRoomInfoModel *model = moneyModel.childOrderInfoJar[i];
        NSString *title = [NSString stringWithFormat:@"%@(%@)",model.roomNum,model.liveUserName];
        NSString *money = [NSString stringWithFormat:@"￥%@",model.roomPriceSum];
        NSString *detail = [NSString stringWithFormat:@"￥%@ x%@天",model.roomPrice,model.liveDay];
        [_adapters addObject:[LYZRenewMoneyLiveUserInfoCell dataAdapterWithData:@{@"title":title,@"money":money,@"detail":detail} cellHeight:LYZRenewMoneyLiveUserInfoCell.cellHeight]];
    }
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    NSString *moneydepositSum = [NSString stringWithFormat:@"￥%@",moneyModel.depositSum];
    NSString *couponName;
    NSString *couponMoney;
    if (moneyModel.coupontype.integerValue == 0) {
        couponName = @"不使用优惠券";
        couponMoney = @"";
    }else if (moneyModel.coupontype.integerValue == 1){
        couponName = [NSString stringWithFormat:@"￥%@ 抵扣券",moneyModel.coupondenominat];
        couponMoney = [NSString stringWithFormat:@"-￥%@",moneyModel.coupondenominat];
    }else if (moneyModel.coupontype.integerValue == 2){
        couponName = [NSString stringWithFormat:@"%1.f折折扣券",moneyModel.coupondenominat.floatValue * 10];
    }
    [_adapters addObject:[LYZRenewMoneyLiveUserInfoCell dataAdapterWithData:@{@"title":@"优惠券",@"money":couponMoney,@"detail":couponName} cellHeight:LYZRenewMoneyLiveUserInfoCell.cellHeight]];
     [_adapters addObject:[self lineType:kLongType height:0.5]];
    [_adapters addObject:[LYZRenewMoneyDetailCommonCell dataAdapterWithData:@{@"title":@"押金",@"money":moneydepositSum,@"textColor":[UIColor colorWithHexString:@"#666666"]} cellHeight:LYZRenewMoneyDetailCommonCell.cellHeight]];
    
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    NSString *moneyActualPayment = [NSString stringWithFormat:@"￥%@",moneyModel.actualPayment];
    [_adapters addObject:[LYZRenewMoneyDetailCommonCell dataAdapterWithData:@{@"title":@"支付总额",@"money":moneyActualPayment,@"textColor":[UIColor blackColor]} cellHeight:LYZRenewMoneyDetailCommonCell.cellHeight]];
    [self.adapters addObject:[self lineType:kLongType height:0.5]];
    
    [GCDQueue executeInMainQueue:^{
        [_moneyDetailTable reloadData];
    }];
}

- (void)configureWithLocalMoneyModel:(BaseOrderDetailModel*)moneyModel{
    if (!self.adapters) {
        _adapters= [NSMutableArray array];
    }
    if (self.adapters.count) {
        [_adapters removeAllObjects];
    }
    NSString *moneystaySum = [NSString stringWithFormat:@"￥%@",moneyModel.orderJson.stayMoneySum];
    [_adapters addObject:[LYZRenewMoneyDetailCommonCell dataAdapterWithData:@{@"title":@"住宿费",@"money":moneystaySum,@"textColor":[UIColor colorWithHexString:@"#666666"]} cellHeight:LYZRenewMoneyDetailCommonCell.cellHeight]];
    [_adapters addObject:[self lineType:kShortType height:0.5]];
    for (int i = 0; i < moneyModel.childOrderInfoJar.count; i ++) {
        OrderCheckInsModel *userModel = moneyModel.childOrderInfoJar[i];
        NSString *title = [NSString stringWithFormat:@"%@(%@)",userModel.roomNum,userModel.liveUserName];
        NSString *money = [NSString stringWithFormat:@"￥%@",userModel.roomPriceSum];
        NSString *detail = [NSString stringWithFormat:@"￥%@ × %@天",userModel.roomPrice,userModel.liveDay];
        [_adapters addObject:[LYZRenewMoneyLiveUserInfoCell dataAdapterWithData:@{@"title":title,@"money":money,@"detail":detail} cellHeight:LYZRenewMoneyLiveUserInfoCell.cellHeight]];
    }
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    NSString *moneydepositSum = [NSString stringWithFormat:@"￥%@",moneyModel.orderJson.depositSum];
    [_adapters addObject:[LYZRenewMoneyDetailCommonCell dataAdapterWithData:@{@"title":@"押金",@"money":moneydepositSum,@"textColor":[UIColor colorWithHexString:@"#666666"]} cellHeight:LYZRenewMoneyDetailCommonCell.cellHeight]];
    
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    NSString *moneyActualPayment = [NSString stringWithFormat:@"￥%@",moneyModel.orderJson.actualPayment];
    [_adapters addObject:[LYZRenewMoneyDetailCommonCell dataAdapterWithData:@{@"title":@"支付总额",@"money":moneyActualPayment,@"textColor":[UIColor blackColor]} cellHeight:LYZRenewMoneyDetailCommonCell.cellHeight]];
    [self.adapters addObject:[self lineType:kLongType height:0.5]];
    
    [GCDQueue executeInMainQueue:^{
        [_moneyDetailTable reloadData];
    }];
}


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
