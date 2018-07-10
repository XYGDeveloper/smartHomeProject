//
//  MyCollectionViewController.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/13.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "UIImage+Color.h"
#import "LoginManager.h"
#import "FavoriteModel.h"
#import "MyCollectionTableViewCell.h"
#import "MyFavoriteModel.h"
#import "Public+JGHUD.h"
#import "MJRefresh.h"
#import "EmptyManager.h"
#import "LYZHotelViewController.h"
@interface MyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *table;

@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic,strong)  UIButton *rightButton;

@property (nonatomic ,assign) BOOL isDelete;

@property (nonatomic,assign)int page;
@property (nonatomic,assign)int limit;


@end

@implementation MyCollectionViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNav];
    [self.table.mj_header beginRefreshing];
//    [self getCollectionData];
    
}

- (UITableView *)table
{

        if (_table == nil) {
            
            _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
            _table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
            _table.showsVerticalScrollIndicator = NO;
            _table.backgroundColor = [UIColor clearColor];
            _table.separatorStyle = UITableViewCellSeparatorStyleNone;
            _table.delegate = self;
            _table.dataSource = self;
            [self.view addSubview:_table];
            WEAKSELF;
            __weak UITableView *weakTable = self.table;
     
            weakTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                
                [weakSelf getCollectionData:10];
                
            }];
            
            weakTable.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
                
                [weakSelf getCollectionData:self.limit];

            }];
            
            
        }
        
        return _table;
}


- (void) updateView
{
    [self.table reloadData];
}


-(void)endRefresh{
    [self.table.mj_header endRefreshing];
    [self.table.mj_footer endRefreshing];
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _isDelete = NO;
    self.view.backgroundColor = LYZTheme_BackGroundColor;
}


-(void)setNav{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"收藏";

}

-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

-(void)getCollectionData:(int)limit{
    NSString * appUserId = [LoginManager instance].appUserID;
    
    [[LYZNetWorkEngine sharedInstance] getFavoriteListWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserId limit:[NSString stringWithFormat:@"%d",limit] pages:@"1" block:^(int event, id object) {
        [self endRefresh];

        if (event == 1) {
            getUserFavoriteListResponse *response = (getUserFavoriteListResponse *)object;
            BaseFavoriteListModel  *baseFavoriteList = response.baseFavoriteList;
            NSArray * arr = baseFavoriteList.favoritelist;
            NSMutableArray * tempArr = [NSMutableArray array];

//            if (1 == self.page) { // 说明是在重新请求数据.
//                self.dataSource = nil;
//            }
            
            if (arr.count) {
                for (FavoriteModel * model in arr){
                    MyFavoriteModel * myModel = [[MyFavoriteModel alloc] init];
                    myModel.appUserFavoriteID = model.favoriteID;
                    myModel.appUserID = model.appUserID;
                    myModel.hotelID = model.hotelID;
                    myModel.imgPath = model.imgPath;
                    myModel.hotelName = model.hotelName;
                    myModel.address = model.address;
                    myModel.lowestPrice = model.lowestPrice;
                    myModel.comentSum = model.comentSum;
                    [tempArr addObject:myModel];
                }
                _dataSource = [NSMutableArray arrayWithArray:tempArr];
                
                  [self updateView];
                }
            
            [_table reloadData];
        
        }else if (event == 2)
        {
            
            [self.table.mj_header endRefreshing];
            [self.table.mj_footer endRefreshing];

            [[EmptyManager sharedManager] showEmptyOnView:self.view withImage:[UIImage imageNamed:@"no_live"] explain:@"收藏列表为空" operationText:@"" operationBlock:^{
            
                
            }];
            
        }else{
        
            [self endRefresh];
            
        }
    }];
    
    limit += 10;
    
    self.limit = limit;
    

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCollectionTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ii"];
    if (!cell) {
        cell = [[MyCollectionTableViewCell  alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ii"];
    }
    MyCollectionTableViewCell * myCell = (MyCollectionTableViewCell *)cell;
    myCell.cellIndex = indexPath.row;
    myCell.favoriteModel = _dataSource[indexPath.row];
    myCell.delBtnClick = ^(NSInteger cellIndex){
        LYLog(@"delete   delete  delete  row ---> %li",cellIndex);
        [self deleteFavoriteAtIndex:cellIndex];
        
    };
   
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return kDefaultCollectionCellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    LYZHotelViewController * v = [[LYZHotelViewController alloc] init];
       FavoriteModel *model = _dataSource[indexPath.row];
    v.i_hotelId = model.hotelID;
    [self.navigationController pushViewController:v animated:YES];
}

#pragma mark -- Action 

-(void)editBtnClick:(id)sender{
    
    _isDelete = !_isDelete;
    if (_isDelete) {
        [_rightButton setTitle:@"完成" forState:UIControlStateNormal];
    }else{
        [_rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    }
    [_table reloadData];
    
}

-(void)deleteFavoriteAtIndex:(NSInteger)index{
    MyFavoriteModel * model = _dataSource[index];
    
    JGProgressHUD *hud = [Public hudWhenRequest];
    [hud showInView:self.view animated:YES];
    
    [self.table.mj_header beginRefreshing];
    
     NSString * appUserId = [LoginManager instance].appUserID;
    [[LYZNetWorkEngine sharedInstance] updateFavoriteWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType appUserID:appUserId hotelID:model.hotelID block:^(int event, id object) {
        [hud dismissAnimated:YES];
        if (event == 1) {
            
            [_dataSource removeObjectAtIndex:index];
            NSMutableArray *indexPaths = [NSMutableArray array];
            [indexPaths addObject:[NSIndexPath indexPathForRow:index inSection:0]];
            [_table deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            [self endRefresh];
            
            [_table reloadData];
        }else{
            [Public showJGHUDWhenError:self.view msg:@"网络问题！删除失败"];
            [self endRefresh];
            
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
