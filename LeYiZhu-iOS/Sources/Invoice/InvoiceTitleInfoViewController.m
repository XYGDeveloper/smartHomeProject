//
//  InvoiceTitleInfoViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "InvoiceTitleInfoViewController.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "InvoiceTitleModel.h"
#import "TaxTypeCell.h"
#import "TaxTilteCommonlyCell.h"
#import "Public+JGHUD.h"
#import "GCD.h"
#import "LoginManager.h"

@interface InvoiceTitleInfoViewController ()<UITableViewDelegate,UITableViewDataSource,CustomCellDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) InvoiceTitleModel *taxTitleModel;


@end


@implementation InvoiceTitleInfoViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"填写发票";
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    
    if (self.fromTitleModel) {
        [self setRightNav];
    }
    [self createTableView];
    [self createDefaultData];
    [self setupBottomBtn];
}

#pragma mark -- UI Config

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
    self.table               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 64- 60)];
    self.table.delegate        = self;
    self.table.dataSource      = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.table.estimatedRowHeight = 100;
    self.table.rowHeight = UITableViewAutomaticDimension;
    self.table.backgroundColor = [UIColor clearColor];
//    self.table.scrollEnabled = NO;
    [self.view addSubview:self.table];
    [ColorSpaceCell registerToTableView:self.table];
    [TaxTypeCell registerToTableView:self.table];
    [TaxTilteCommonlyCell registerToTableView:self.table];
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
    if (self.fromTitleModel) {
        //try
        InvoiceTitleModel *model = [[InvoiceTitleModel alloc] init];
        model.type = self.fromTitleModel.type;
        model.taxTitle = self.fromTitleModel.taxTitle;
        model.taxNum = self.fromTitleModel.taxNum;
        model.lookUpID = self.fromTitleModel.lookUpID;
        self.taxTitleModel = model;
        
    }else{
        //构造空数据
        InvoiceTitleModel *model = [[InvoiceTitleModel alloc] init];
        model.type = enterpriseType;
        self.taxTitleModel = model;
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
    [_adapters addObject:[TaxTypeCell dataAdapterWithData:self.taxTitleModel cellHeight:TaxTypeCell.cellHeight]];
    [_adapters addObject:[self lineType:kShortType height:0.5]];
    [_adapters addObject:[TaxTilteCommonlyCell dataAdapterWithData:@{@"title":@"发票抬头",@"placeHolder":@"发票抬头",@"content":self.taxTitleModel} cellHeight:[TaxTilteCommonlyCell cellHeightWithData:self.taxTitleModel.taxTitle]]];
    [_adapters addObject:[self lineType:kShortType height:0.5]];
    if (self.taxTitleModel.type == enterpriseType) {
      
        [_adapters addObject:[TaxTilteCommonlyCell dataAdapterWithData:@{@"title":@"税号",@"placeHolder":@"15位、18位或20位识别号",@"content":self.taxTitleModel} cellHeight:[TaxTilteCommonlyCell cellHeightWithData:self.taxTitleModel.taxNum]]];
        [_adapters addObject:[self lineType:kShortType height:0.5]];
    }
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
    LYLog(@"table view index 3 height is --> %f",self.adapters[3].cellHeight)
    return self.adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
}


#pragma mark -- Btn Actions

-(void)compelete:(UIButton *)sender{
    if (!self.taxTitleModel.taxTitle || [self.taxTitleModel.taxTitle isEqualToString:@""]) {
        [Public showJGHUDWhenError:self.view msg:@"请填写完整发票抬头信息！"];
        return;
    }
    if (self.taxTitleModel.type == enterpriseType) {
        if (!self.taxTitleModel.taxNum || [self.taxTitleModel.taxNum isEqualToString:@""]) {
            [Public showJGHUDWhenError:self.view msg:@"请填写完整税号！"];
            return;
        }
        //TODO: 校验税号
        
    }
    NSString *appUserID = [LoginManager instance].appUserID;
    NSNumber *invoiceTitleType = [NSNumber numberWithInt:(int)self.taxTitleModel.type + 1];
    
    [[LYZNetWorkEngine sharedInstance] editInvoiceLookup:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID lookUpID:self.taxTitleModel.lookUpID type:invoiceTitleType lookUP:self.taxTitleModel.taxTitle taxNumber:self.taxTitleModel.taxNum block:^(int event, id object) {
        if (event == 1) {
            EditInvoiceLookupResponse *response = (EditInvoiceLookupResponse *)object;
            EditLookupResultModel *result = response.editTitleResult;
            //上传成功
            if (self.fromTitleModel) {
                [Public showJGHUDWhenSuccess:self.view msg:@"修改成功"];
               [GCDQueue executeInMainQueue:^{
                   self.popCallBack(nil);
                   [self.navigationController popViewControllerAnimated:YES];
               } afterDelaySecs:1.0];
            }else{
                self.taxTitleModel.lookUpID = result.lookUpID;
                self.popCallBack(self.taxTitleModel);
                [self.navigationController popViewControllerAnimated:YES];
            }

        }else{
            if (self.fromTitleModel) {
               //如果保存失败，直接返回
                [Public showJGHUDWhenError:self.view msg:@"修改失败"];
                [GCDQueue executeInMainQueue:^{
                      [self.navigationController popViewControllerAnimated:YES];
                } afterDelaySecs:(1.0f)];
            }else{
                self.popCallBack(self.taxTitleModel);
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }];
    
}

-(void)delete:(UIButton *)sender{
    NSString *appUserID = [LoginManager instance].appUserID;
    [[LYZNetWorkEngine sharedInstance] delInvoiceLookup:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID lookUpID:self.taxTitleModel.lookUpID block:^(int event, id object) {
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

-(void)taxTypeSelected:(InvoiceTitleModel *)model{
    [self createDataSource];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
