//
//  ChooseAddressViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/17.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "ChooseAddressViewController.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "RecieverInfoModel.h"
#import "GCD.h"
#import "Public+JGHUD.h"
#import "LoginManager.h"
#import "AddCommonlyTaxTitleCell.h"
#import "SelectAddressCell.h"
#import "InvoiceAddressModel.h"
#import "InvoiceAddressViewController.h"


@interface ChooseAddressViewController ()<UITableViewDelegate,UITableViewDataSource,CustomCellDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) NSArray <RecieverInfoModel *> *addressDatas;
@property (nonatomic ,strong) RecieverInfoModel *choosedModel;

@end

@implementation ChooseAddressViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择常用配送地址";
    self.view.backgroundColor = LYZTheme_BackGroundColor;
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    [self createTableView];
    [self setupBottomBtn];
    [self fetchAddressInfo];
}

#pragma mark -- UI Config

-(void)createTableView{
    self.table               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 64 - 60)];
    self.table.delegate        = self;
    self.table.dataSource      = self;
    self.table.alpha = 0.0f;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.table];
    [ColorSpaceCell registerToTableView:self.table];
    [AddCommonlyTaxTitleCell registerToTableView:self.table];
    [SelectAddressCell registerToTableView:self.table];
    
}

- (void)setupBottomBtn
{
    UIButton *compeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    compeleteBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 64 -60, SCREEN_WIDTH, 60);
    [compeleteBtn setBackgroundColor:LYZTheme_paleBrown];
    [compeleteBtn setTitle:@"完成" forState:UIControlStateNormal];
    [compeleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    compeleteBtn.titleLabel.font = [UIFont  fontWithName:@"PingFangSC-Regular" size:20];
    [compeleteBtn addTarget:self action:@selector(compelete:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:compeleteBtn];
}


#pragma mark -- Config Data

-(void)fetchAddressInfo{
    
    NSString *appUserID = [LoginManager instance].appUserID;
    [[LYZNetWorkEngine sharedInstance] getInvoiceAddressList:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID isNeedData:@"1" limit:nil pages:nil block:^(int event, id object) {
        if (event == 1) {
            GetInvoiceAddressListResponse *response = (GetInvoiceAddressListResponse *)object;
            BaseInvoiceAddressListModel *baseAddressList = response.baseInvoiceAddress;
            NSMutableArray *temp = [NSMutableArray array];
            for (int i = 0; i < baseAddressList.addressJar.count; i ++) {
                InvoiceAddressModel *model = baseAddressList.addressJar[i];
                RecieverInfoModel *localModel = [[RecieverInfoModel alloc] init];
                localModel.invoiceAddressID = model.invoiceAddressID;
                localModel.recipient = model.recipient;
                localModel.phone = model.phone;
                localModel.province = model.province;
                localModel.city = model.city;
                localModel.area = model.area;
                localModel.address = model.address;
                localModel.index = i;
                if (i == 0) {
                    //第一个默认被选中
                    localModel.isSelected = YES;
                    self.choosedModel = localModel;
                }
                [temp addObject:localModel];
            }
            self.addressDatas = [NSArray arrayWithArray:temp];
            [self createDataSource];

        }else{
            LYLog(@"request failed");
        }
    }];
}


-(void)createDataSource{
    if (!_adapters) {
        _adapters = [NSMutableArray array];
    }
    if (_adapters.count > 0) {
        [_adapters removeAllObjects];
    }
    [self.adapters addObject:[AddCommonlyTaxTitleCell dataAdapterWithData:@"新增常用配送地址" cellHeight:AddCommonlyTaxTitleCell.cellHeight]];
    [self.adapters addObject:[self lineType:kSpace height:20.0f]];
    [self.table reloadData];
    
    [UIView animateWithDuration:0.5f animations:^{
        
        self.table.alpha = 1.f;
        
    } completion:^(BOOL finished) {
        //TODO:
        
        for (int i = 0; i < _addressDatas.count; i ++) {
            [self.adapters addObject:[SelectAddressCell dataAdapterWithData:_addressDatas[i] cellHeight:[SelectAddressCell cellHeightWithData:_addressDatas[i]]]];
            
            if (i == _addressDatas.count - 1) {
                break;
            }
            [self.adapters addObject:[self lineType:kLongType height:0.5]];
        }
        NSMutableArray *indexPaths = [NSMutableArray array];
        [self.adapters enumerateObjectsUsingBlock:^(CellDataAdapter *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
        }];
        [indexPaths removeObjectsInRange:NSMakeRange(0, 2)];
        [self.table insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }];
    
    [GCDQueue executeInMainQueue:^{
        [self.table reloadData];
    }];
}

#pragma mark -- tableView Delegate
- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {
    
    if (type == kSpace) {
        
        return [ColorSpaceCell dataAdapterWithData:nil cellHeight:height];
        
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
    cell.controller          = self;
    [cell loadContent];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
    if (indexPath.row == 0) {
        //新增
        InvoiceAddressViewController *vc = [[InvoiceAddressViewController alloc] init];
        WEAKSELF;
        vc.popCallBack = ^(RecieverInfoModel *model){
            [weakSelf fetchAddressInfo];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        //spaceCell 不处理
    }else{
        //全设置为默认
        for (RecieverInfoModel *model in _addressDatas) {
            model.isSelected = NO;
        }
        NSInteger index = indexPath.row / 2  - 1;
        //取出对应的model
        RecieverInfoModel *model = _addressDatas[index];
        model.isSelected = YES;
        [self.table reloadData];
        self.choosedModel = model;
    }
}

#pragma mark -- Btn Actions

-(void)compelete:(UIButton *)sender{
    self.popCallBack(self.choosedModel);
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)editBtnClick:(RecieverInfoModel *)model{
    InvoiceAddressViewController *vc = [[InvoiceAddressViewController alloc] init];
    vc.fromAddressModel = model;
    WEAKSELF;
    vc.popCallBack = ^(RecieverInfoModel *model){
        [weakSelf fetchAddressInfo];
    };
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
