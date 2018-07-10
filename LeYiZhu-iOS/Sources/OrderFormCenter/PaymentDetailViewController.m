//
//  PaymentDetailViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "PaymentDetailViewController.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "PaymentDetailCell.h"
#import "OrderCheckInsModel.h"
#import "RoomPriceModel.h"
#import "UIView+SetRect.h"
#import "MJExtension.h"
@interface PaymentDetailViewController ()<UITableViewDelegate, UITableViewDataSource, CustomCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;

@property (nonatomic, strong) UIView *headView;

@end

@implementation PaymentDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
     [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTableViewAndRegisterCells];
    [self createDissMissBtn];
    [self createDataSource];
    
    NSLog(@"%@",self.orderDetail.mj_keyValues);
    
}



#pragma mark - UI Config

-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
        title.text = @"费用明细";
        title.textColor = [UIColor blackColor];
        title.font = [UIFont fontWithName:LYZTheme_Font_Regular size:17];
        [title sizeToFit];
        title.centerX = SCREEN_WIDTH /2.0;
        title.centerY = _headView.height /2.0 + 20;
        [_headView addSubview:title];
    }
    return _headView;
}


-(void)createDissMissBtn{
    UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissBtn.frame = CGRectMake(0, 0, 34, 34);
    dismissBtn.centerX = SCREEN_WIDTH / 2.0;
    dismissBtn.bottom = SCREEN_HEIGHT -  50;
    [dismissBtn setImage:[UIImage imageNamed:@"iconShutdown"] forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:dismissBtn atIndex:100];
}

- (void)createTableViewAndRegisterCells {
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT  )];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headView;
    [self.view addSubview:_tableView];
    [ColorSpaceCell  registerToTableView:self.tableView];
    [PaymentDetailCell registerToTableView:self.tableView];
}

#pragma mark - Data Config

-(void)createDataSource{
    if (!self.adapters) {
        self.adapters = [NSMutableArray array];
    }
    if (self.adapters.count > 0) {
        [self.adapters removeAllObjects];
    }
    NSString *actualPayment = [NSString stringWithFormat:@"￥%@",self.orderDetail.orderJson.actualPayment];
    [_adapters addObject:[PaymentDetailCell  dataAdapterWithData:@{@"leftContent":@"在线支付",@"leftColor":LYZTheme_paleBrown,@"leftFont" :@16 ,@"rightContent":  actualPayment,@"rightColor":LYZTheme_paleBrown, @"rightFont":@16} cellHeight:50]];
    
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    
  //房费
    for (int i = 0; i < self.orderDetail.childOrderInfoJar.count ; i++) {
        OrderCheckInsModel *checkInsModel =  self.orderDetail.childOrderInfoJar[i];
        NSString *title;
        //代入住情况下 是获取不到房间号的
        if (checkInsModel.roomNum.length > 0) {
           title  = [NSString stringWithFormat:@"%@号房房费",checkInsModel.roomNum];
        }else{
            title =  @"房费";
        }
       
        NSString *roomPriceTotal = [NSString stringWithFormat:@"￥%@",checkInsModel.roomPriceSum];
          [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:title leftColor:RGB(29,29,38) leftFontSize:@15 rightContent:roomPriceTotal rightColor:RGB(29,29,38) rightFontSize:@15] cellHeight:45]];
        for (int j = 0; j < checkInsModel.roomPrice.count; j ++) {
            RoomPriceModel *roomPrice = checkInsModel.roomPrice[j];
             NSString *price = [NSString stringWithFormat:@"￥%@",roomPrice.price];
            [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:roomPrice.checkInDate leftColor:LYZTheme_warmGreyFontColor leftFontSize:@14 rightContent:price rightColor:LYZTheme_warmGreyFontColor rightFontSize:@14] cellHeight:35]];
        }
    }
    [_adapters addObject:[self lineType:kShortType height:0.5]];
    //押金
    NSString *depositSum = [NSString stringWithFormat:@"￥%@",self.orderDetail.orderJson.depositSum];
    [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"押金" leftColor:RGB(29,29,38) leftFontSize:@15 rightContent:depositSum rightColor:RGB(29,29,38) rightFontSize:@15] cellHeight:45]];
    for (int i = 0; i < self.orderDetail.childOrderInfoJar.count ; i++) {
        OrderCheckInsModel *checkInsModel =  self.orderDetail.childOrderInfoJar[i];
//        NSString *title = [NSString stringWithFormat:@"%@号房押金",checkInsModel.roomNum];
        NSString *title = @"押金";
        NSString *deposit = [NSString stringWithFormat:@"￥%@",checkInsModel.deposit];
         [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:title leftColor:LYZTheme_warmGreyFontColor leftFontSize:@14 rightContent:deposit rightColor:LYZTheme_warmGreyFontColor rightFontSize:@14] cellHeight:35]];
    }
    
    [_adapters addObject:[self lineType:kShortType height:0.5]];
    //优惠
    NSString *dicount = [NSString stringWithFormat:@"-￥%@",self.orderDetail.orderJson.totalDiscount];
    NSString *deduction = [NSString stringWithFormat:@"-￥%@",self.orderDetail.orderJson.deduction];
//    NSString *systemDis = [NSString stringWithFormat:@"-￥%2.f",self.orderDetail.orderJson.customerServiceDiscount.floatValue];
    [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"优惠" leftColor:RGB(29,29,38) leftFontSize:@15 rightContent:dicount rightColor:RGB(29,29,38) rightFontSize:@15] cellHeight:45]];
    [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"优惠券" leftColor:LYZTheme_warmGreyFontColor leftFontSize:@14 rightContent:deduction rightColor:LYZTheme_warmGreyFontColor rightFontSize:@14] cellHeight:35]];
//     [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"系统减免" leftColor:LYZTheme_warmGreyFontColor leftFontSize:@14 rightContent:systemDis rightColor:LYZTheme_warmGreyFontColor rightFontSize:@14] cellHeight:35]];
    [_adapters addObject:[self lineType:kShortType height:0.5]];
    NSString *paid = [NSString stringWithFormat:@"-￥%2.f",self.orderDetail.orderJson.paid.floatValue];
    [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"已支付" leftColor:RGB(29,29,38) leftFontSize:@15 rightContent:paid rightColor:RGB(29,29,38) rightFontSize:@15] cellHeight:45]];
    [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"旧订单抵扣" leftColor:LYZTheme_warmGreyFontColor leftFontSize:@14 rightContent:paid rightColor:LYZTheme_warmGreyFontColor rightFontSize:@14] cellHeight:35]];
    [_adapters addObject:[self lineType:kLongType height:0.5]];
    
//    if (self.orderDetail.orderJson.childStatus.integerValue == 4) {
//        [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"退还金额" leftColor:LYZTheme_paleBrown leftFontSize:@16 rightContent:self.orderDetail.orderJson.returnAmount rightColor:LYZTheme_paleBrown rightFontSize:@16] cellHeight:45]];
//        [_adapters addObject:[PaymentDetailCell dataAdapterWithData:[self dictionaryWithLeftContent:@"押金" leftColor:LYZTheme_paleBrown leftFontSize:@14 rightContent:self.orderDetail.orderJson.depositSum rightColor:LYZTheme_paleBrown rightFontSize:@14] cellHeight:35]];
//    }
}

-(NSDictionary *)dictionaryWithLeftContent:(NSString *)leftContent leftColor:(UIColor *)leftColor leftFontSize:(NSNumber *)leftFontSize rightContent:(NSString *)rightContent rightColor:(UIColor *)rightColor rightFontSize:(NSNumber *)rightFontSize{
    return @{@"leftContent":leftContent,@"leftColor":leftColor,@"leftFont" :leftFontSize ,@"rightContent":  rightContent,@"rightColor":rightColor, @"rightFont":rightFontSize};
}

#pragma mark - UITableView related.

- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {
    if (type == kSpace) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" :LYZTheme_BackGroundColor} cellHeight:15.f];
        
    } else if (type == kLongType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :RGB(215, 215, 215)} cellHeight:0.5f];
        
    } else if (type == kShortType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" : RGB(215, 215, 215), @"leftGap" : @(20.f)} cellHeight:0.5f];
        
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

#pragma mark - Btn Actions

-(void)dismiss:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
