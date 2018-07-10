//
//  LYZInvoiceViewController.m
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/3/13.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "LYZInvoiceViewController.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "OrderInvoiceModel.h"
#import "LYZInvoiceCell.h"
#import "Public+JGHUD.h"
#import "AlertView.h"
#import "InvoiceTitleInfoViewController.h"
#import "ChooseTaxTitleViewController.h"
#import "InvoiceTitleCommitCell.h"
#import "MailingAddressCommitCell.h"
#import "RecieverInfoModel.h"
#import "LoginManager.h"
#import "InvoiceAddressViewController.h"
#import "ChooseAddressViewController.h"
#import "LYZInvoceMarkTableViewCell.h"


#define kSegmentWidth 358.0f
#define kSegmentHeight 34.0f

@interface LYZInvoiceViewController ()<UITableViewDelegate, UITableViewDataSource,CustomCellDelegate,UIScrollViewDelegate,BaseMessageViewDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *iScrollview;
@property (nonatomic, strong)UITableView *electric_table;
@property (nonatomic, strong)UITableView *paper_table;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters_elec;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters_paper;
@property (nonatomic, strong) OrderInvoiceModel *elec_model;
@property (nonatomic, strong) OrderInvoiceModel *paper_model;
@property (nonatomic, strong) UIView *elec_footview;
@property (nonatomic, strong) UIView *paper_footView;

@end

@implementation LYZInvoiceViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:NavBarColor] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.title = @"填写发票";
    [self setNav];
    [self createScrollview];
    [self createTableView];
     [self createSegMentController];
    [self createBottomBtn];
    [self configInitData];
    [self createElecDataSource];
    [self createPaperDataSource];
    [self selcetIndex];
}

-(void)setNav{
    UIImage * leftImg = [[UIImage imageNamed:@"icon_returned"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem * leftNavItem = [[UIBarButtonItem alloc] initWithImage:leftImg style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = leftNavItem;
}

-(void)selcetIndex{
    if (self.invoiceModel) {
        if (self.invoiceModel.type == OrderInvoiceType_none || self.invoiceModel.type == OrderInvoiceType_Electronic) {
            [self.segmentedControl setSelectedSegmentIndex:1];
        }else{
            [self.segmentedControl setSelectedSegmentIndex:0];
        }
        self.iScrollview.contentOffset =  CGPointMake(SCREEN_WIDTH * self.segmentedControl.selectedSegmentIndex, 0.0f);
    }
}

-(void)configInitData{
    if (!self.invoiceModel) {
        //构造空数据模型
        OrderInvoiceModel *emodel = [[OrderInvoiceModel alloc] init];
        emodel.detail = @"住宿费";
        emodel.type = OrderInvoiceType_Electronic;
        self.elec_model = emodel;
        
        OrderInvoiceModel *model = [[OrderInvoiceModel alloc] init];
        model.detail = @"住宿费";
        model.postType  = @"货到付款";
        model.type = OrderInvoiceType_Paper;
        self.paper_model = model;
    }else{
        if (self.invoiceModel.type == OrderInvoiceType_Electronic) {
            self.elec_model = self.invoiceModel;
            OrderInvoiceModel *model = [[OrderInvoiceModel alloc] init];
            model.detail = @"住宿费";
            model.postType  = @"EMS到付";
            model.type = OrderInvoiceType_Paper;
            self.paper_model = model;
        }else if(self.invoiceModel.type == OrderInvoiceType_Paper){
            self.paper_model = self.invoiceModel;
            OrderInvoiceModel *emodel = [[OrderInvoiceModel alloc] init];
            emodel.detail = @"住宿费";
            emodel.type = OrderInvoiceType_Electronic;
            self.elec_model = emodel;
        }
    }
}

- (void)createElecDataSource {
    
    if (!self.adapters_elec) {
        self.adapters_elec = [NSMutableArray array];
    }
    if (self.adapters_elec.count > 0) {
        [self.adapters_elec removeAllObjects];
    }
    NSArray *arr = @[@"发票明细",@"发票抬头",@"邮箱地址"];
    NSArray *ph_arr = @[@"",@"请输入发票抬头",@"请输入邮箱地址"];
    [self.adapters_paper addObject:[self lineType:kSpace height:54]];
    for (int i = 0; i < arr.count; i ++) {
         [self.adapters_elec addObject:[LYZInvoiceCell dataAdapterWithData:@{@"title":arr[i],@"placeHolder":ph_arr[i],@"content":self.elec_model} cellHeight:60]];
        if (i == arr.count - 1) {
            break;
        }
        [self.adapters_elec addObject:[self lineType:kShortType height:0.5]];
    }
    [self.electric_table reloadData];
}

-(void)createPaperDataSource{
    if (!self.adapters_paper) {
        self.adapters_paper = [NSMutableArray array];
    }
    if (self.adapters_paper.count > 0) {
        [self.adapters_paper removeAllObjects];
    }
    [self.adapters_paper addObject:[self lineType:kSpace height:54]];
    [self.adapters_paper addObject:[LYZInvoiceCell dataAdapterWithData:@{@"title":@"发票明细",@"placeHolder":@"",@"content":self.paper_model} cellHeight:62]];
    [self.adapters_paper addObject:[self lineType:kShortType height:0.5]];
    [self.adapters_paper addObject:[InvoiceTitleCommitCell dataAdapterWithData:@{@"title":@"发票抬头",@"placeHolder":@"抬头及识别号",@"content":self.paper_model} cellHeight:[InvoiceTitleCommitCell cellHeightWithData:self.paper_model.title]]];
    [self.adapters_paper addObject:[self lineType:kShortType height:0.5]];
    [self.adapters_paper addObject:[MailingAddressCommitCell dataAdapterWithData:@{@"title":@"配送信息",@"placeHolder":@"输入配送地址",@"content":self.paper_model} cellHeight:[MailingAddressCommitCell cellHeightWithData:self.paper_model.recieverInfo]]];
    [self.adapters_paper addObject:[self lineType:kShortType height:0.5]];
    [self.adapters_paper addObject:[LYZInvoceMarkTableViewCell dataAdapterWithData:@{@"title":@"备注",@"placeHolder":@"备注说明120字以内",@"content":self.paper_model} cellHeight:120]];
    [self.adapters_paper addObject:[self lineType:kShortType height:0.5]];
    [self.adapters_paper addObject:[LYZInvoiceCell dataAdapterWithData:@{@"title":@"邮寄方式",@"placeHolder":@"货到付款",@"content":self.paper_model} cellHeight:62]];
    [self.paper_table reloadData];
}

-(void)createSegMentController{
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"纸质发票",@"电子发票",nil];
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    
    self.segmentedControl.frame = CGRectMake((SCREEN_WIDTH - kSegmentWidth)/2.0, 20, kSegmentWidth, kSegmentHeight);
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateSelected];
    [self.segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:LYZTheme_paleBrown} forState:UIControlStateNormal];
  
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.tintColor = LYZTheme_paleBrown;
    self.segmentedControl.layer.borderWidth = 0.5;
    self.segmentedControl.layer.borderColor = LYZTheme_paleBrown.CGColor;
    self.segmentedControl.layer.cornerRadius = 3.0;
    [self.segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl];
}

-(void)createScrollview{
    self.iScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 60)];
    self.iScrollview.backgroundColor = [UIColor clearColor];
    self.iScrollview.delegate = self;
    self.iScrollview.pagingEnabled = YES;
    self.iScrollview.showsHorizontalScrollIndicator = NO;
    self.iScrollview.contentSize = CGSizeMake(SCREEN_WIDTH *2 , SCREEN_HEIGHT - 64 - 60 - self.segmentedControl.bottom);
    self.iScrollview.bounces = NO;
    self.iScrollview.scrollEnabled = NO; //电子发票暂时不能用
    [self.view addSubview:self.iScrollview];
}

-(void)createTableView{
    //left tableview
    self.electric_table               = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH,self.iScrollview.height)];
    self.electric_table.delegate        = self;
    self.electric_table.dataSource      = self;
    self.electric_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.electric_table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.electric_table.backgroundColor = [UIColor clearColor];
    self.electric_table.tableFooterView = self.elec_footview;
    [self.iScrollview addSubview:self.electric_table];
    //注册cell
    [ColorSpaceCell registerToTableView:self.electric_table];
    [LYZInvoiceCell registerToTableView:self.electric_table];
    
    //right tableview
    self.paper_table               = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,self.iScrollview.height)];
    self.paper_table.delegate        = self;
    self.paper_table.dataSource      = self;
    self.paper_table.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.paper_table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.paper_table.backgroundColor = [UIColor clearColor];
    self.paper_table.tableFooterView = self.paper_footView;
    [self.iScrollview addSubview:self.paper_table];
    //注册cell
    [ColorSpaceCell registerToTableView:self.paper_table];
    [LYZInvoiceCell registerToTableView:self.paper_table];
    [InvoiceTitleCommitCell registerToTableView:self.paper_table];
    [MailingAddressCommitCell registerToTableView:self.paper_table];
    [LYZInvoceMarkTableViewCell registerToTableView:self.paper_table];
}

-(UIView *)elec_footview{
    if (!_elec_footview) {
          _elec_footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        _elec_footview.backgroundColor = [UIColor clearColor];
        UIView *roundView = [[UIView alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 20, 10, 10)];
        roundView.backgroundColor = RGB(199, 199, 204);
        roundView.layer.cornerRadius = roundView.width/2.0;
        [_elec_footview addSubview:roundView];
        
        UILabel *notice = [[UILabel alloc] initWithFrame:CGRectMake(roundView.right +8, 15, SCREEN_WIDTH - roundView.right  - 5- DefaultLeftSpace, 20)];
        notice.textColor = LYZTheme_warmGreyFontColor;
        notice.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
        notice.text = @"该房型仅提供增值税普通发票";
        [_elec_footview addSubview:notice];
    }
    return _elec_footview;
}

-(UIView *)paper_footView{
    if (!_paper_footView) {
        _paper_footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        _paper_footView.backgroundColor = [UIColor clearColor];
        UIView *roundView = [[UIView alloc] initWithFrame:CGRectMake(DefaultLeftSpace, 20, 10, 10)];
        roundView.backgroundColor = RGB(199, 199, 204);
        roundView.layer.cornerRadius = roundView.width/2.0;
        [_paper_footView addSubview:roundView];
        
        UILabel *notice = [[UILabel alloc] initWithFrame:CGRectMake(roundView.right +8, 15, SCREEN_WIDTH - roundView.right  - 5- DefaultLeftSpace, 20)];
        notice.textColor = LYZTheme_warmGreyFontColor;
        notice.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
        notice.text = @"该房型仅提供增值税普通发票";
        [_paper_footView addSubview:notice];
        
        UIView *roundView1 = [[UIView alloc] initWithFrame:CGRectMake(DefaultLeftSpace, roundView.bottom + 25, 10, 10)];
        roundView1.backgroundColor = RGB(199, 199, 204);
        roundView1.layer.cornerRadius = roundView1.width/2.0;
        [_paper_footView addSubview:roundView1];
        
        UILabel *notice1 = [[UILabel alloc] initWithFrame:CGRectMake(roundView1.right +5, roundView1.y - 2, SCREEN_WIDTH - roundView.right  - 5- DefaultLeftSpace, 0)];
        notice1.textColor = LYZTheme_warmGreyFontColor;
        notice1.numberOfLines = 0;
        notice1.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
        notice1.text = @"发票由深圳乐易住智能科技股份有限公司开具，并在离店7个工作日左右寄达给您，默认邮寄方式使用EMS";
        [notice1 sizeToFit];
        [_paper_footView addSubview:notice1];
    }
    return _paper_footView;
}

-(void)createBottomBtn{
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 60 -64, SCREEN_WIDTH, 60);
    [saveBtn setBackgroundColor:LYZTheme_paleBrown];
    [saveBtn setTitle:@"完成" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(InvoiceCompelete:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
}

#pragma mark - BaseMessageViewDelegate

- (void)baseMessageView:(__kindof BaseMessageView *)messageView event:(id)event {
    
    NSLog(@"%@, tag:%ld event:%@", NSStringFromClass([messageView class]), (long)messageView.tag, event);
    if (messageView.tag == 1111) {
        if ([event isEqualToString:@"知道了"]) {
            
        }
    }
    [messageView hide];
    
}


#pragma mark -- tableView Delegate
- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {
    
    if (type == kSpace) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor] }cellHeight:height];
        
    } else if (type == kLongType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :[UIColor colorWithHexString:@"E8E8E8"]} cellHeight:height];
        
    } else if (type == kShortType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" : [UIColor colorWithHexString:@"E8E8E8"], @"leftGap" : @(20.f)} cellHeight:height];
    } else {
        return nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.electric_table) {
        return _adapters_elec.count;
    }else{
        return _adapters_paper.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.electric_table) {
        CellDataAdapter *adapter = _adapters_elec[indexPath.row];
        CustomCell      *cell    = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
        cell.dataAdapter         = adapter;
        cell.data                = adapter.data;
        cell.indexPath           = indexPath;
        cell.tableView           = tableView;
        cell.delegate            = self;
        [cell loadContent];
        return cell;
    }else{
        CellDataAdapter *adapter = _adapters_paper[indexPath.row];
        CustomCell      *cell    = [tableView dequeueReusableCellWithIdentifier:adapter.cellReuseIdentifier];
        cell.dataAdapter         = adapter;
        cell.data                = adapter.data;
        cell.indexPath           = indexPath;
        cell.tableView           = tableView;
        cell.delegate            = self;
        [cell loadContent];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.electric_table) {
         return self.adapters_elec[indexPath.row].cellHeight;
    }else{
        return self.adapters_paper[indexPath.row].cellHeight;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
    if (tableView == self.paper_table) {
        if (indexPath.row == 3) {
            //抬头
            LYLog(@" title clicked!");
            [self toInvoiceTitleView];
        }else if (indexPath.row == 5){
            //配送信息
            LYLog(@" reciever info clicked!");
            [self toRecieverInfoView];
        }
    }
    
}



#pragma mark -- Segment Value Change

-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)seg{
    if (seg.selectedSegmentIndex == 1) {
        [self.segmentedControl setSelectedSegmentIndex:0];
        NSString *content                     = @"电子发票功能即将上线，敬请期待，如急需报销申请使用纸质发票";
        NSArray  *buttonTitles                =  @[AlertViewRedStyle(@"知道了")];
        AlertViewMessageObject *messageObject = MakeAlertViewMessageObject(nil,content, buttonTitles);
        //     AppDelegate *dele = (AppDelegate*) [UIApplication sharedApplication].delegate;
        
        [AlertView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:1111];
        return;
    }
    self.iScrollview.contentOffset =  CGPointMake(SCREEN_WIDTH * seg.selectedSegmentIndex, 0.0f);
}

#pragma mark -- ScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if ([scrollView isEqual:self.iScrollview]) {
        
        if (scrollView.contentOffset.x == SCREEN_WIDTH) {
            [self.segmentedControl  setSelectedSegmentIndex:1];
        }else{
             [self.segmentedControl  setSelectedSegmentIndex:0];
        }
    }
}

#pragma mark -- Btn Actions

-(void)InvoiceCompelete:(UIButton *)btn{
    if (self.segmentedControl.selectedSegmentIndex == 1) {
        
    }else{
        if (!self.paper_model.title) {
            [Public showJGHUDWhenError:self.view msg:@"请填写完整发票抬头信息！"];
            return;
        }
        if (!self.paper_model.recieverInfo) {
            [Public showJGHUDWhenError:self.view msg:@"请填写完整配送信息！"];
            return;
        }
        if (self.paper_model) {
            self.popBlock(self.paper_model);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//获取抬头
-(void)toInvoiceTitleView{
    NSString *appUserID = [LoginManager instance].appUserID;
    [[LYZNetWorkEngine sharedInstance] getInvoiceLookupList:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID isNeedData:@"0" limit:nil pages:nil block:^(int event, id object) {
        if (event == 1) {
            GetInvoiceLookupListResponse *response = (GetInvoiceLookupListResponse *)object;
            BaseLookupListModel *baseLookup = response.baseLookup;
            if (baseLookup.lookUpJarSize.integerValue > 0) {
                ChooseTaxTitleViewController *vc = [[ChooseTaxTitleViewController alloc] init];
                WEAKSELF;
                vc.popCallBack = ^(InvoiceTitleModel *model){
                    weakSelf.paper_model.title = model;
                    [weakSelf createPaperDataSource];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                InvoiceTitleInfoViewController *vc = [[InvoiceTitleInfoViewController alloc] init];
                WEAKSELF;
                vc.popCallBack = ^(InvoiceTitleModel *model){
                    weakSelf.paper_model.title = model;
                    [weakSelf createPaperDataSource];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            LYLog(@"request failed");
        }
    }];
}


-(void)toRecieverInfoView{
     NSString *appUserID = [LoginManager instance].appUserID;
    [[LYZNetWorkEngine sharedInstance]  getInvoiceAddressList:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserID isNeedData:@"0" limit:nil pages:nil block:^(int event, id object) {
        if (event == 1) {
            GetInvoiceAddressListResponse *response = (GetInvoiceAddressListResponse *)object;
            BaseInvoiceAddressListModel *baseAddressModel = response.baseInvoiceAddress;
            if (baseAddressModel.addressJarSize.integerValue > 0) {
                //跳常用地址列表
                ChooseAddressViewController *vc = [[ChooseAddressViewController alloc] init];
                WEAKSELF;
                vc.popCallBack = ^(RecieverInfoModel *model){
                    weakSelf.paper_model.recieverInfo = model;
                    [weakSelf createPaperDataSource];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                //跳填写页面
                InvoiceAddressViewController *vc = [[InvoiceAddressViewController alloc] init];
                WEAKSELF;
                vc.popCallBack = ^(RecieverInfoModel *model){
                    weakSelf.paper_model.recieverInfo = model;
                    [weakSelf createPaperDataSource];
                };
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            LYLog(@"request failed");
        }
    }];

}


-(void)back:(id)sender{
    if (self.callback) {
        self.callback();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
