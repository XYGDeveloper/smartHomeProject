//
//  ApplyVipViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/10.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "ApplyVipViewController.h"
#import "InfiniteLoopViewBuilder.h"
#import "LoopViewCell.h"
#import "ImageModel.h"
#import "CircleNodeStateView.h"
#import "UIView+SetRect.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "VipApplyInfoModel.h"
#import "VipApplyCell.h"
#import "GCD.h"
#import "GradientImgaeGenerator.h"
#import "LYZWKWebViewController.h"
#import "Public+JGHUD.h"

@interface ApplyVipViewController ()<InfiniteLoopViewBuilderEventDelegate,UITableViewDelegate, UITableViewDataSource, CustomCellDelegate>

@property (nonatomic, strong) InfiniteLoopViewBuilder *loopView;

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) VipApplyInfoModel *vipInfo;

@end

@implementation ApplyVipViewController

#pragma mark - life cycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"加入会员";
    self.view.backgroundColor =LYZTheme_BackGroundColor;
    [self createBannerView];
    [self createTableViewAndRegisterCells];
    [self configDefaultData];
    [self createDataSource];
}

#pragma mark - UI Config

-(void)createBannerView{
    NSArray *imgNanmes = @[@"advip_banner"];
    NSMutableArray *models = [NSMutableArray array];
    for (int i = 0; i < imgNanmes.count; i++) {
        
        ImageModel *model                     = [[ImageModel alloc] init];
        model.img = [UIImage imageNamed:imgNanmes[i]];
        
        // Setup model.
        model.infiniteLoopCellClass           = [LoopViewCell class];
        model.infiniteLoopCellReuseIdentifier = [NSString stringWithFormat:@"LoopViewCell_%d", i];
        [models addObject:model];
    }
    self.loopView = [[InfiniteLoopViewBuilder alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,125)];
    self.loopView.nodeViewTemplate         = [CircleNodeStateView new];
    self.loopView.delegate                 =  self;
    self.loopView.sampleNodeViewSize       = CGSizeMake(15, 10);

    self.loopView.position                 = kNodeViewHidden; //不显示
    self.loopView.edgeInsets               = UIEdgeInsetsMake(0, 0, 15, 5);
    self.loopView.models                   = (NSArray <InfiniteLoopViewProtocol, InfiniteLoopCellClassProtocol> *)models;
    [self.loopView startLoopAnimated:NO];
    [self.view addSubview:self.loopView];
}


-(void)createTableViewAndRegisterCells{
    CGFloat height =  iPhone6_6sPlus ? 320 : 290;
    UIView *whiteBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(22.5, self.loopView.bottom + 27, SCREEN_WIDTH - 45, height)];
    whiteBackgroundView.backgroundColor = [UIColor whiteColor];
    whiteBackgroundView.layer.cornerRadius = 2.5f;
    whiteBackgroundView.layer.shadowColor = RGB(231, 231, 233).CGColor;
    whiteBackgroundView.layer.shadowOffset = CGSizeMake(0, 0);
    whiteBackgroundView.layer.shadowOpacity = 0.7;
    [self.view addSubview:whiteBackgroundView];
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, whiteBackgroundView.width, 52)];
    titleLable.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    titleLable.textColor = LYZTheme_paleBrown;
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text  = @"会员资料填写";
    [whiteBackgroundView addSubview:titleLable];
    
    UIView *line_1 = [[UIView alloc] initWithFrame:CGRectMake(0, 52, whiteBackgroundView.width, 0.5)];
    line_1.backgroundColor = kLineColor;
    [whiteBackgroundView addSubview:line_1];
    
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(23, line_1.bottom, whiteBackgroundView.width - 46, 210)];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [whiteBackgroundView addSubview:_tableView];
    [ColorSpaceCell  registerToTableView:self.tableView];
    [VipApplyCell registerToTableView:self.tableView];
    
    UIButton * registVipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registVipBtn.frame = CGRectMake(22.5, whiteBackgroundView.bottom + 25, SCREEN_WIDTH - 45, 42);
    registVipBtn.clipsToBounds = YES;
    registVipBtn.layer.cornerRadius = 3.0f;
    [registVipBtn setBackgroundImage:[GradientImgaeGenerator generatorImageWithImageSize:registVipBtn.frame.size startPoint: CGPointMake(0, 0) endPoint:CGPointMake(registVipBtn.width, 0) startColor:RGB(210, 182, 143) endColor:LYZTheme_paleBrown] forState:UIControlStateNormal];
    registVipBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:18];
    [registVipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registVipBtn setTitle:@"成为会员" forState:UIControlStateNormal];
    [registVipBtn addTarget:self action:@selector(registVip:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registVipBtn];
    //添加背景
    CALayer *layer=[[CALayer alloc]init];
    layer.frame = registVipBtn.frame;
    layer.cornerRadius=registVipBtn.layer.cornerRadius;
    layer.backgroundColor= [UIColor blackColor].CGColor;//这里必须设置layer层的背景颜色，默认应该是透明的，导致设置的阴影颜色无法显示出来
    layer.shadowColor=LYZTheme_paleBrown.CGColor;//设置阴影的颜色
    layer.shadowRadius = 5.0f;//设置阴影的宽度
    layer.shadowOffset=CGSizeMake(3 , 3);//设置偏移
    layer.shadowOpacity= 0.7f;
    [self.view.layer addSublayer:layer];
    [self.view bringSubviewToFront:registVipBtn];
   
    
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    noticeLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
    noticeLabel.textColor = LYZTheme_BrownishGreyFontColor;
    noticeLabel.text = @"注册即表示您同意乐易住章程";
    [noticeLabel sizeToFit];
    noticeLabel.x= registVipBtn.x + 8;
    noticeLabel.y = registVipBtn.bottom + 30;
    [self.view addSubview:noticeLabel];
    
    UILabel *checkVipRuleLabel =  [[UILabel alloc] initWithFrame:CGRectZero];
    checkVipRuleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14.0];
    checkVipRuleLabel.textColor = LYZTheme_paleBrown;
    checkVipRuleLabel.text = @"查看会员章程 >>";
    [checkVipRuleLabel sizeToFit];
    checkVipRuleLabel.x= noticeLabel.right + 5;
    checkVipRuleLabel.y = noticeLabel.y;
    [self.view addSubview:checkVipRuleLabel];
    
    UIButton *vipRuleBtn = [UIButton buttonWithType: UIButtonTypeCustom];
    vipRuleBtn.x = 0;
    vipRuleBtn.centerY = noticeLabel.centerY;
    vipRuleBtn.width = SCREEN_WIDTH;
    vipRuleBtn.height = 60;
    [vipRuleBtn addTarget:self action:@selector(vipRule:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:vipRuleBtn];
}

- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {
    
    if (type == kSpace) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : LYZTheme_BackGroundColor} cellHeight:height];
        
    } else if (type == kLongType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor} cellHeight:0.5f];
        
    } else if (type == kShortType) {
        
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor, @"leftGap" : @(20.f)} cellHeight:0.5f];
        
    } else {
        return nil;
    }
}

#pragma mark - Data Config

-(void)configDefaultData{
    self.vipInfo = [VipApplyInfoModel new];
}

-(void)createDataSource{
    if (!self.adapters) {
        self.adapters = [NSMutableArray array];
    }
    if (self.adapters.count) {
        [self.adapters removeAllObjects];
    }
    NSArray *arr = @[@{@"title":@"姓名",@"data":self.vipInfo},@{@"title":@"身份证号",@"data":self.vipInfo},@{@"title":@"Email(选填)",@"data":self.vipInfo},@{@"title":@"邀请码(选填)",@"data":self.vipInfo}];
    for (int i = 0; i < 4; i ++) {
        [_adapters addObject:[VipApplyCell dataAdapterWithData:arr[i] cellHeight:VipApplyCell.cellHeight]];
        [_adapters addObject:[self lineType:kLongType height:0.5]];
    }

    [GCDQueue executeInMainQueue:^{
        [self.tableView reloadData];
    }];
}

#pragma mark - TableView Delegate & DataSource Delegate
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
    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
}

#pragma mark - CustomCellDelegate

- (void)customCell:(CustomCell *)cell event:(id)event {
    LYLog(@"%@", event);
}

#pragma mark - InfiniteLoopViewBuilderEventDelegate

- (void)infiniteLoopViewBuilder:(InfiniteLoopViewBuilder *)infiniteLoopViewBuilder
                           data:(id <InfiniteLoopViewProtocol>)data
                  selectedIndex:(NSInteger)index
                           cell:(CustomInfiniteLoopCell *)cell {
    
}

- (void)infiniteLoopViewBuilder:(InfiniteLoopViewBuilder *)infiniteLoopViewBuilder
           didScrollCurrentPage:(NSInteger)index {
    
    
}

#pragma mark - Btn Actions

-(void)vipRule:(UIButton *)sender{
    LYZWKWebViewController *vc = [[LYZWKWebViewController alloc] init];
    vc.strURL = VipRules;
    vc.title = @"会员章程";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)registVip:(UIButton *)sender{
    LYLog(@"regist Vip  %@",self.vipInfo);
    if (!self.vipInfo.name || [self.vipInfo.name isEqualToString:@""]) {
        [Public showJGHUDWhenError:self.view msg:@"请填写完整姓名"];
        return;
    }
    if (!self.vipInfo.IDNum || [self.vipInfo.IDNum isEqualToString:@""]) {
        [Public showJGHUDWhenError:self.view msg:@"请填写完整身份证号"];
        return;
    }
    if (![IICommons validateIDCardNumber:self.vipInfo.IDNum]) {
        [Public showJGHUDWhenError:self.view msg:@"请填写正确的身份证号"];
        return;
    }
    NSString *email = self.vipInfo.email ? : @"";
    NSString *inviteCode = self.vipInfo.inviteCode ? :@"";
    

    [[LYZNetWorkEngine sharedInstance] applyVip:self.vipInfo.name idCard:self.vipInfo.IDNum email:email inviteCode:inviteCode block:^(int event, id object) {
        if (event == 1) {
            [Public showJGHUDWhenSuccess:self.view msg:@"恭喜你成为会员"];
            [GCDQueue executeInMainQueue:^{
                 [self.navigationController popViewControllerAnimated:YES];
            } afterDelaySecs:1.0];
        }else{
            [Public showJGHUDWhenError:self.view msg:object];
            }
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
