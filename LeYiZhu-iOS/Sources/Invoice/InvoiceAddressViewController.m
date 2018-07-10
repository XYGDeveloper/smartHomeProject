//
//  InvoiceAddressViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/17.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "InvoiceAddressViewController.h"
#import "RecieverInfoModel.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "GCD.h"
#import "LoginManager.h"
#import "AddressFillInCommonlyCell.h"
#import "PrefectureFillInCell.h"
#import "AddressDetailCell.h"
#import "AddressPickerView.h"
#import "Public+JGHUD.h"

@interface InvoiceAddressViewController ()<UITableViewDelegate,UITableViewDataSource,CustomCellDelegate,AddressPickerViewDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) RecieverInfoModel *recieverInfoModel;
@property (nonatomic ,strong) AddressPickerView * pickerView;

@end

@implementation InvoiceAddressViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"填写配送地址";
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    
    if (self.fromAddressModel) {
        [self setRightNav];
    }
    [self createTableView];
    [self createDefaultData];
    [self setupBottomBtn];
    [self.view addSubview:self.pickerView];
    
}

#pragma mark -- UI Config
- (AddressPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AddressPickerView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 64 , SCREEN_WIDTH, 266)];
        _pickerView.delegate = self;
        // 关闭默认支持打开上次的结果
       _pickerView.isAutoOpenLast = NO;
    }
    return _pickerView;
}

-(void)setRightNav{
    
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
    rightButton.frame = CGRectMake(0, 0,70, 30);
    rightButton.titleLabel.textAlignment = NSTextAlignmentRight;
    [rightButton setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
    [rightButton setTitleColor:LYZTheme_paleBrown forState:UIControlStateSelected];
    [rightButton setTitle:@"删除" forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = - 10;
    self.navigationItem.rightBarButtonItems = @[spaceItem,rightItem];
}

-(void)createTableView{
    self.table               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 64 - 60)];
    self.table.delegate        = self;
    self.table.dataSource      = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.table.estimatedRowHeight = 100;
    self.table.rowHeight = UITableViewAutomaticDimension;
//    self.table.scrollEnabled = NO;
    self.table.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.table];
    [ColorSpaceCell registerToTableView:self.table];
    [AddressDetailCell registerToTableView:self.table];
    [PrefectureFillInCell registerToTableView:self.table];
    [AddressFillInCommonlyCell registerToTableView:self.table];
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

-(void)createDefaultData{
    if (self.fromAddressModel) {
        RecieverInfoModel *model = [[RecieverInfoModel alloc] init];
        model.recipient = self.fromAddressModel.recipient;
        model.phone = self.fromAddressModel.phone;
        model.province = self.fromAddressModel.province;
        model.city = self.fromAddressModel.city;
        model.area = self.fromAddressModel.area;
        model.address = self.fromAddressModel.address;
        model.invoiceAddressID = self.fromAddressModel.invoiceAddressID;
        self.recieverInfoModel = model;
        
    }else{
        //构造空数据
         RecieverInfoModel *model = [[RecieverInfoModel alloc] init];
        self.recieverInfoModel = model;
    }
    [self createDataSource];
}

-(void)createDataSource{
    if (!_adapters) {
        _adapters = [NSMutableArray array];
    }
    if (_adapters.count > 0) {
        [_adapters removeAllObjects];
    }
    [_adapters addObject:[self lineType:kSpace height:20]];
    [_adapters addObject:[AddressFillInCommonlyCell dataAdapterWithData:@{@"title":@"收件人",@"placeHolder":@"收件人姓名",@"content":self.recieverInfoModel} cellHeight:AddressFillInCommonlyCell.cellHeight]];
    [_adapters addObject:[self lineType:kShortType height:0.5]];
     [_adapters addObject:[AddressFillInCommonlyCell dataAdapterWithData:@{@"title":@"手机",@"placeHolder":@"用于接收通知",@"content":self.recieverInfoModel} cellHeight:AddressFillInCommonlyCell.cellHeight]];
    [_adapters addObject:[self lineType:kShortType height:0.5]];
    NSString *prefecture;
    if (self.recieverInfoModel.province && self.recieverInfoModel.city && self.recieverInfoModel.area) {
        prefecture  = [NSString stringWithFormat:@"%@%@%@",self.recieverInfoModel.province,self.recieverInfoModel.city,self.recieverInfoModel.area];
    }else{
        prefecture = @"";
    }
    [_adapters addObject:[PrefectureFillInCell dataAdapterWithData:@{@"title":@"所在地区",@"placeHolder":@"省/市/区",@"content":prefecture} cellHeight:[PrefectureFillInCell cellHeightWithData:prefecture]]];
    [_adapters addObject:[self lineType:kShortType height:0.5]];
    [_adapters addObject:[AddressDetailCell dataAdapterWithData:@{@"title":@"详细地址",@"placeHolder":@"不需要填写省/市/区",@"content":self.recieverInfoModel} cellHeight:[AddressDetailCell cellHeightWithData:self.recieverInfoModel.address]]];
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
    cell.controller          = self;
    cell.delegate            = self;
    [cell loadContent];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
    if (indexPath.row ==  5) {
        //选择地区
          [self.pickerView show];
    }
}


#pragma mark - AddressPickerViewDelegate
- (void)cancelBtnClick{
    NSLog(@"点击了取消按钮");
    [self.pickerView hide];
}
- (void)sureBtnClickReturnProvince:(NSString *)province City:(NSString *)city Area:(NSString *)area{
    self.recieverInfoModel.province = province;
    self.recieverInfoModel.city = city;
    self.recieverInfoModel.area = area;
    [self createDataSource];
    [self.pickerView hide];
}


#pragma mark -- Btn Actions

-(void)compelete:(UIButton *)sender{
    if (!self.recieverInfoModel.recipient || [self.recieverInfoModel.recipient isEqualToString:@""]) {
        [Public showJGHUDWhenError:self.view msg:@"请填写完整收件人信息！"];
        return;
    }
   
    if (!self.recieverInfoModel.phone || [self.recieverInfoModel.phone isEqualToString:@""]) {
        [Public showJGHUDWhenError:self.view msg:@"请填写完整税号！"];
        return;
    }
    
    if(self.recieverInfoModel.phone.length < 11 || self.recieverInfoModel.phone.length > 11){
        [Public showJGHUDWhenError:self.view msg:@"手机号码输入不正确"];
        return;
    }
  
    if (!self.recieverInfoModel.province || [self.recieverInfoModel.phone isEqualToString:@""] || !self.recieverInfoModel.city || [self.recieverInfoModel.city isEqualToString:@""] || !self.recieverInfoModel.area || [self.recieverInfoModel.area isEqualToString:@""] ) {
        [Public showJGHUDWhenError:self.view msg:@"请选择您所在的地区！"];
        return;
    }
    if (!self.recieverInfoModel.address || [self.recieverInfoModel.address isEqualToString:@""] ) {
        [Public showJGHUDWhenError:self.view msg:@"请填写您的详细地址！"];
        return;
    }
    if (self.recieverInfoModel.address.length > 100) {
        [Public showJGHUDWhenError:self.view msg:@"地址长度请限制在100字内"];
        return;
    }
    NSString *appUserID = [LoginManager instance].appUserID;
    [[LYZNetWorkEngine sharedInstance] editInvoiceAddress:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID invoiceAddressId:self.recieverInfoModel.invoiceAddressID recipient:self.recieverInfoModel.recipient phone:self.recieverInfoModel.phone province:self.recieverInfoModel.province city:self.recieverInfoModel.city area:self.recieverInfoModel.city address:self.recieverInfoModel.address block:^(int event, id object) {
        if (event == 1) {
            EditInvoiceAddressResponse *response = (EditInvoiceAddressResponse *)object;
            EditInvoiceAddressResultModel *result = response.editeInvoiceAddressResult;
            if (self.fromAddressModel) {
                [Public showJGHUDWhenSuccess:self.view msg:@"修改成功"];
                [GCDQueue executeInMainQueue:^{
                    self.popCallBack(nil);
                    [self.navigationController popViewControllerAnimated:YES];
                } afterDelaySecs:1.0];
            }else{
                self.recieverInfoModel.invoiceAddressID = result.InvoiceAddressID;
                self.popCallBack(self.recieverInfoModel);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }else{
            if (self.fromAddressModel) {
                //如果保存失败，直接返回
                [Public showJGHUDWhenError:self.view msg:@"修改失败"];
                [GCDQueue executeInMainQueue:^{
                    [self.navigationController popViewControllerAnimated:YES];
                } afterDelaySecs:(1.0f)];
            }else{
                self.popCallBack(self.recieverInfoModel);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
}

-(void)delete:(UIButton *)sender{
    NSString *appUserID = [LoginManager instance].appUserID;
    [[LYZNetWorkEngine sharedInstance] delelteInvoiceAddress:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID invoiceAddressID:self.recieverInfoModel.invoiceAddressID block:^(int event, id object) {
        if (event == 1) {
            [Public showJGHUDWhenSuccess:self.view msg:@"删除成功"];
            [GCDQueue executeInMainQueue:^{
                self.popCallBack(nil);
                [self.navigationController popViewControllerAnimated:YES];
            } afterDelaySecs:1.0];
        }else{
            [Public showJGHUDWhenError:self.view msg:@"删除失败"];
            [GCDQueue executeInMainQueue:^{
                [self.navigationController popViewControllerAnimated:YES];
            } afterDelaySecs:1.0f];
        }
    }];
  
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
