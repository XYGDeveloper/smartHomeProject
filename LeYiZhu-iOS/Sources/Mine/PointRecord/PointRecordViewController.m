//
//  PointRecordViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/18.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "PointRecordViewController.h"
#import "CustomCell.h"
#import "ColorSpaceCell.h"
#import "MJRefresh.h"
#import "PointsModel.h"
#import "Public+JGHUD.h"
#import "PointDetailCell.h"
#import "GCD.h"
#import "EmptyManager.h"

#define kHeadViewHeight 174

@interface PointRecordViewController ()<UITableViewDelegate, UITableViewDataSource, CustomCellDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) NSArray <PointsModel *> *points;
@property (nonatomic, strong) UILabel *totalPointLabel;
@property (nonatomic, assign) int count;

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PointRecordViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

//滚动tableview 完毕之后
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //图片高度
    CGFloat imageHeight = self.headView.frame.size.height;
    //图片宽度
    CGFloat imageWidth = kScreenWidth;
    //图片上下偏移量
    CGFloat imageOffsetY = scrollView.contentOffset.y;
    
    NSLog(@"图片上下偏移量 imageOffsetY:%f ->",imageOffsetY);
    
    //上移
    if (imageOffsetY <= 0) {
        
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
        CGFloat f = totalOffset / imageHeight;
        self.imageView.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
        self.navigationController.navigationBar.alpha = 0.3;
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
        self.navigationController.navigationBar.translucent = YES;
    }
   
    //    //下移
        if (imageOffsetY > 0) {
            self.navigationController.navigationBar.alpha = 1;
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"mine_nav_bar"] forBarMetrics:UIBarMetricsDefault];
            self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
            self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
            self.navigationController.navigationBar.translucent = YES;
           
        }
    
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    self.title = @"积分";
//    [self createHeadView];
    [self createTableViewAndRegisterCells];
    [self createDataSource];
}

#pragma mark - UI Config

//-(void)createHeadView{
//
//
//    [self.view addSubview:headView];
//}

- (void)createTableViewAndRegisterCells {
    
    //    self.tableView                 = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
  
    [self.view addSubview:_tableView];
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_HEIGHT, kHeadViewHeight)];
    self.imageView = [[UIImageView alloc] initWithFrame:self.headView.bounds];
    [self.imageView setImage:[UIImage imageNamed:@"mine_nav_bar"]];
    [self.headView addSubview:self.imageView];
    
    self.totalPointLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, self.headView.height - 64)];
    self.totalPointLabel.textColor = LYZTheme_paleBrown;
    self.totalPointLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:36];
    self.totalPointLabel.textAlignment = NSTextAlignmentCenter;
    self.totalPointLabel.text = [NSString stringWithFormat:@"%@分",self.totalPoint];
    [self.headView addSubview:self.totalPointLabel];
    
    self.tableView.tableHeaderView = self.headView;
    
    __weak UITableView *weaktableView = self.tableView;
    WEAKSELF;
    weaktableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf getPointRecord:10];
    }];
    [self.tableView.mj_header beginRefreshing];

    weaktableView.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [weakSelf getPointRecord:self.count];
    }];
    if (@available(iOS 11.0, *)){
        
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [ColorSpaceCell  registerToTableView:self.tableView];
    [PointDetailCell registerToTableView:self.tableView];
}



#pragma mark - Data Config

-(void)getPointRecord:(int)count{
    [[LYZNetWorkEngine sharedInstance] getPointsRecord:[NSString stringWithFormat:@"%d",count] pages:@"1" block:^(int event, id object) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (event == 1) {
            GetPointsRecordResponse *response = (GetPointsRecordResponse *)object;
            BasePointRecordModel *basePointRecordModel = response.pointRecord;
            self.points = basePointRecordModel.points;
            if (self.points.count) {

                [[EmptyManager sharedManager] removeEmptyFromView:self.tableView];
                [self createDataSource];
            }else{
                //空数组
                 [[EmptyManager sharedManager] showEmptyOnView:self.tableView withImage:[UIImage imageNamed:@"search_nOnresult"] explain:@"暂无积分纪录" operationText:@"" operationBlock:nil];
            }
            
        }else{
            [Public showJGHUDWhenError:self.view msg:object];
        }
        
    }];
    
    count += 10;
    self.count = count;
}

-(void)createDataSource{
    if (!self.adapters) {
        self.adapters = [NSMutableArray array];
    }
    if (self.adapters.count) {
        [self.adapters removeAllObjects];
    }
    for (int i  = 0; i < self.points.count; i ++) {
        PointsModel *model = self.points[i];
        [_adapters addObject:[PointDetailCell dataAdapterWithData:model cellHeight:PointDetailCell.cellHeight]];
        if (i == self.points.count - 1) {
            break;
        }
        [_adapters addObject:[self lineType:kLongType height:0.5 ]];
    }
    [GCDQueue executeInMainQueue:^{
        [self.tableView reloadData];
    }];
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

#pragma mark - UITableView related.

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
    cell.controller           =self;
    cell.delegate            = self;
    [cell loadContent];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
