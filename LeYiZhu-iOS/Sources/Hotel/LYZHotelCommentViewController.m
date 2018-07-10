//
//  LYZHotelCommentViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZHotelCommentViewController.h"
#import "CellDataAdapter.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "Masonry.h"
#import "LYZCommentDetailCell.h"
#import "GCD.h"
#import "MJRefresh.h"
#import "EmptyManager.h"

@interface LYZHotelCommentViewController ()<UITableViewDelegate, UITableViewDataSource,CustomCellDelegate>

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) NSArray <HotelCommentsModel *> *comments
;

@end

@implementation LYZHotelCommentViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];
    [self fetchComments];
}

-(void)configUI{
    [self createTableViewAndRegisterCells];
    [self addFloatBtn];
}

-(void)addFloatBtn{
    [self.view insertSubview:self.headView atIndex:1001];
}

-(void)fetchComments{
    
    [[LYZNetWorkEngine sharedInstance] getHotelCommentWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType hotelID:self.hotelId limit:@"1000" pages:@"1" tagid:@"" block:^(int event, id object) {
        [self.tableView.mj_header endRefreshing];
        if (event == 1) {
            GetHotelCommentResponse * response = (GetHotelCommentResponse *)object;
            BaseCommentModel * baseCommnet = response.baseComment;
            self.comments = baseCommnet.comments;
            if (self.comments.count) {
                 [self createDataSource];
            }else{
                UIImage *img = [UIImage imageNamed:@"no_live"];
               [[EmptyManager sharedManager] showEmptyOnView:self.tableView withImage:img explain:@"暂无评论" operationText:@"" operationBlock:nil];
            }
           
        }else{
            LYLog(@"error ---> %@",object);
        }
    }];
}

-(void)createDataSource{
    if (!self.adapters) {
        self.adapters = [NSMutableArray array];
    }
    if (self.adapters.count > 0) {
        [self.adapters removeAllObjects];
    }
    for (int i = 0; i < self.comments.count; i ++) {
        [self.adapters addObject:[self lineType:kLongType height:0.5]];
        [self.adapters addObject:[LYZCommentDetailCell dataAdapterWithData:_comments[i] cellHeight:[LYZCommentDetailCell cellHeightWithData:_comments[i]]]];
    }
    [GCDQueue executeInMainQueue:^{
        [self.tableView reloadData];
    }];
}

-(void)createTableViewAndRegisterCells{
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT -64 - 40)];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
//    self.tableView.tableHeaderView = self.headView;
    WEAKSELF;
    __weak UITableView *weakTable = self.tableView;
    weakTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf fetchComments];
    }];

    [self.view addSubview:_tableView];
    [LYZCommentDetailCell registerToTableView:self.tableView];
    [ColorSpaceCell registerToTableView:self.tableView];
    
}


- (CellDataAdapter *)lineType:(ELineTypeValue)type height:(CGFloat)height {
    if (type == kSpace) {
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" :LYZTheme_BackGroundColor} cellHeight:15.f];
    } else if (type == kLongType) {
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" :kLineColor} cellHeight:0.5f];
    } else if (type == kShortType) {
        return [ColorSpaceCell dataAdapterWithData:@{@"backgroundColor" : [UIColor whiteColor], @"lineColor" : kLineColor, @"leftGap" : @(20.f)} cellHeight:0.5f];
    } else {
        return nil;
    }
}

-(UIView *)headView{
    if (!_headView) {
        _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _headView.backgroundColor = [UIColor whiteColor];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , _headView.height)];
        titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:17];
        titleLabel.textColor = LYZTheme_BrownishGreyFontColor;
        titleLabel.text = [NSString stringWithFormat:@"全部评价(%.1f)",self.averageScore.floatValue];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:titleLabel];
        
        UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        closeBtn.frame = CGRectMake(SCREEN_WIDTH - 10 - 20, 10, 20, 20);
        [closeBtn setImage:[UIImage imageNamed:@"pay_icon_close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:closeBtn];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, _headView.height - 0.5, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = kLineColor;
        [_headView addSubview:line];
    }
    return _headView;
}

#pragma mark --Tableview Delegate

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

#pragma mark -- Btn Actions

-(void)closeBtnClick:(UIButton *)sender{
    [self disMiss];
}

#pragma mark -- show VC

- (void)showInViewController:(UIViewController *)vc{
    if (vc) {
        [vc addChildViewController:self];
        [vc.view addSubview:self.view];
        [self show];
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
}

-(void)show{
    [self addKeyAnimation];
}

- (void)addKeyAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.calculationMode = kCAAnimationCubic;
    animation.values = @[@1.07,@1.06,@1.05,@1.03,@1.02,@1.01,@1.0];
    animation.duration = 0.4;
    [self.view.layer addAnimation:animation forKey:@"transform.scale"];
}

- (void)disMiss {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    LYLog(@"dealloc");
}



@end
