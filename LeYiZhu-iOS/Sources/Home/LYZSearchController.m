
//
//  LYZSearchController.m
//  LeYiZhu-iOS
//
//  Created by L on 2017/4/20.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZSearchController.h"
#import "Masonry.h"
#import "LYZSearchModel.h"
#import "LYZSearchTableViewCell.h"
#import "Public+JGHUD.h"
#import "LYZLocalCityTableViewCell.h"
#import "LYZSearchTableViewCell.h"
#import "LYZSearchResultTableViewCell.h"
//#import <Baidu-Maps-iOS-SDK/BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import "SearchLoadHotelModel.h"
#import "BaseSearchLoadModel.h"
#import "EmptyManager.h"
#import "BaseSearchForKeywordsModel.h"
#import "LYZSearchResultTableViewCell.h"
#import "LYZKeyWordTableViewCell.h"
#import "LYZHotelViewController.h"
#import "SearchLoadCitysModel.h"
#import <objc/runtime.h>
#import "NSArray+safe.h"
#import "UIViewController+TFModalView.h"
#import "GCD.h"
#import "AlertView.h"
#import "LYZPhoneCall.h"


@interface LYZSearchController ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,BaseMessageViewDelegate>

@property (nonatomic,strong)BMKLocationService *locService;

@property (nonatomic,strong)UIButton *telephoneButton;

@property (nonatomic,strong)UIButton *keyBoardButton;


@property (nonatomic,strong)UIWindow *window;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UITableView *LocationTableview;

@property (nonatomic, strong) UIView *LocationHead;

@property (nonatomic, strong) UIView *hotHead;

@property (nonatomic, strong) UIView *hotTagView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) CGFloat longitude;
// 纬度
@property (nonatomic, assign) CGFloat latitude;
/* 当前城市名称 */
@property(nonatomic,copy)NSString *currentCityString;

@property (nonatomic, strong) BMKGeoCodeSearch *geoCode;

//初始化酒店列表
@property (nonatomic, strong)NSArray *SearchLoadCitysModelList;
//城市列表
@property (nonatomic, strong)NSArray *SearchLoadCitysList;
//搜索结果
@property (nonatomic, strong)NSMutableArray *searchResultArray;

@property (nonatomic, strong) UIView *emptyView;

@end

@implementation LYZSearchController

- (NSArray *)SearchLoadCitysModelList
{

    if (!_SearchLoadCitysModelList) {
        
        _SearchLoadCitysModelList = [NSArray array];
        
    }
    return _SearchLoadCitysModelList;
}

- (NSArray *)SearchLoadCitysList
{
    
    if (!_SearchLoadCitysList) {
        
        _SearchLoadCitysList = [NSArray array];
    }
    return _SearchLoadCitysList;
}

- (NSMutableArray *)searchResultArray{
    if (!_searchResultArray) {
        
        _searchResultArray = [NSMutableArray array];
    }
    return _searchResultArray;
    
}

- (UITableView *)LocationTableview
{
    
    if (!_LocationTableview) {
        
//        _LocationTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT - 280-40- 35) style:UITableViewStylePlain];
         _LocationTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, (SCREEN_HEIGHT - 64)*0.7 - 40 - 30 - 35) style:UITableViewStylePlain];
       
        _LocationTableview.backgroundColor = LYZTheme_BackGroundColor;
        
        _LocationTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _LocationTableview.delegate = self;
        
        _LocationTableview.dataSource  = self;
        
    }
    
    return _LocationTableview;
    
}

- (UITableView *)tableView
{
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT- 280- 60-35) style:UITableViewStylePlain];
        
        _tableView.backgroundColor = [UIColor clearColor];
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        _tableView.delegate = self;
        
        _tableView.dataSource  = self;
        
    }
    
    return _tableView;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //先加载缓存数据
    self.SearchLoadCitysModelList = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] dataForKey:@"SearchHotel"]];
    [self.LocationTableview reloadData];
    #pragma mark-调用此类进行定位，定位信息从在于userLocal
    _locService = [[BMKLocationService alloc] init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];

    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    _geoCode.delegate = nil;
    _locService = nil;
    _geoCode = nil;
    _locService.delegate = nil;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
   // [self.view addSubview:self.tableView];
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    [self.view addSubview:self.LocationTableview];
    
    self.LocationHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    
    UILabel *tjLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH, 30)];
    tjLabel.text = @"酒店推荐";
    tjLabel.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f  blue:153/255.0f  alpha:1.0f];
    tjLabel.font = [UIFont systemFontOfSize:16.0f];
    tjLabel.textColor = [UIColor colorWithRed:198/255.0f green:198/255.0f blue:198/255.0f alpha:1.0f];
    [self.LocationHead addSubview:tjLabel];
    
    [self.LocationTableview registerClass:[LYZLocalCityTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LYZLocalCityTableViewCell class])];
    [self.LocationTableview registerClass:[LYZSearchTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LYZSearchTableViewCell class])];
    
    self.LocationTableview.tableHeaderView = self.LocationHead;
    self.hotHead = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    UILabel *hotLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH, 30)];
    hotLabel.text = @"搜索结果";
    hotLabel.font = [UIFont systemFontOfSize:16.0f];
    hotLabel.textColor = [UIColor colorWithRed:198/255.0f green:198/255.0f blue:198/255.0f alpha:1.0f];
    [self.hotHead addSubview:hotLabel];

    self.tableView.tableHeaderView = self.hotHead;
    self.hotTagView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-270)];
    self.hotTagView.backgroundColor = LYZTheme_BackGroundColor;
    [self.tableView addSubview:self.hotTagView];
    self.keyBoardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.keyBoardButton setTitle:[NSString stringWithFormat:@"客服电话：%@",CustomerServiceNum] forState:UIControlStateNormal];
    self.keyBoardButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.keyBoardButton setTitleColor:[UIColor colorWithRed:198/255.0f green:198/255.0f blue:198/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [self.hotTagView addSubview:self.keyBoardButton];
    
    [self.keyBoardButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(35);
        make.bottom.mas_equalTo(-120);
    }];
    
    [self.keyBoardButton addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView registerClass:[LYZKeyWordTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LYZKeyWordTableViewCell class])];
    
    [self.tableView registerClass:[LYZSearchResultTableViewCell class] forCellReuseIdentifier:NSStringFromClass([LYZSearchResultTableViewCell class])];
    
    self.tableView.hidden = YES;
    
    self.view.backgroundColor = LYZTheme_BackGroundColor;
    
    [self.view addSubview:self.tableView];
    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 40)];
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    self.searchBar.layer.borderWidth = 1;
    self.searchBar.layer.cornerRadius = 1;
    self.searchBar.layer.borderColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0f].CGColor;
    for (UIView *view in self.searchBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UIView")]&&view.subviews.count>0) {
            view.backgroundColor = [UIColor whiteColor];
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            break;
        }
    }
    
    //以下代码为修改placeholder字体的颜色和大小
    UITextField * searchField = [_searchBar valueForKey:@"_searchField"];
    [searchField setValue:[UIColor blackColor] forKeyPath:@"_placeholderLabel.textColor"];
    [searchField setValue:[UIFont fontWithName:@"PingFangSC-Regular" size:16.0f] forKeyPath:@"_placeholderLabel.font"];
    
    self.searchBar.delegate = self;
    
    self.searchBar.placeholder = @"搜索酒店/关键字";
    
    if (self.searchBar.text.length == 0) {
        
        [self.tableView addSubview:self.hotTagView];
        
    }
    
    [self.view addSubview:self.searchBar];
    
    self.telephoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.view addSubview:self.telephoneButton];
    
    [self.telephoneButton setTitle:[NSString stringWithFormat:@"客服电话：%@",CustomerServiceNum] forState:UIControlStateNormal];
    self.telephoneButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [self.telephoneButton setTitleColor:[UIColor colorWithRed:198/255.0f green:198/255.0f blue:198/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    [self.telephoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(35);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    
    [self.telephoneButton addTarget:self action:@selector(callAction:) forControlEvents:UIControlEventTouchUpInside];
    
}



- (void)toBookRoom:(UIButton *)button{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)configHotTagViewWithTags:(NSArray *)tags {
 
    int n = (int)tags.count;
    int rrrr = n%3;
    int n1 = (rrrr==0)?n/3:n/3+1;
    UILabel *label = [[UILabel alloc]init];
    label.text = @"已开通城市";
    label.textColor = [UIColor colorWithRed:153/255.0f green:153/255.0f  blue:153/255.0f  alpha:1.0f];
    label.font = [UIFont systemFontOfSize:16.0f];
    label.frame = CGRectMake(20, 0, SCREEN_WIDTH - 40, 20);
    label.backgroundColor = LYZTheme_BackGroundColor;
    label.textAlignment = NSTextAlignmentLeft;
    [self.hotTagView addSubview:label];
    
    label.textColor = [UIColor colorWithRed:198/255.0f green:198/255.0f blue:198/255.0f alpha:1.0f];
    int row = n1 > 5 ? n1: 5;
    for (int j = 0; j<row; j++) {
        for (int i = 0; i<3; i++) {
    
            if (n>0) {
                if (j*3 + i < tags.count) {
                    UIButton *butn1 = [UIButton buttonWithType:UIButtonTypeSystem];
                    butn1.frame = CGRectMake(SCREEN_WIDTH/3*i, 25+50*j, SCREEN_WIDTH/3, 50);
                    butn1.tag = j*3 +i;
                    
                    SearchLoadCitysModel *model = [self.SearchLoadCitysList safeObjectAtIndex:j*3 +i];
                    [butn1 setTitle:model.name forState:UIControlStateNormal];
                     butn1.titleLabel.font = [UIFont systemFontOfSize:16.0f];
                    butn1.backgroundColor = [UIColor whiteColor];
                    if (model.status.integerValue == 1) {
                        [butn1 setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
                        [butn1 addTarget:self action:@selector(searchByCity:) forControlEvents:UIControlEventTouchUpInside];
                    }else{
                        [butn1 setTitleColor:LYZTheme_BlackFontColorFontColor forState:UIControlStateNormal];
                        [butn1 addTarget:self action:@selector(openingSoon:) forControlEvents:UIControlEventTouchUpInside];
                        butn1.contentEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0);
                    }
                    [self.hotTagView addSubview:butn1];
                    if (model.status.integerValue != 1) {
                        UILabel *tagLabel  = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 12)];
                        tagLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:9.0];
                        tagLabel.textColor = LYZTheme_warmGreyFontColor;
                        tagLabel.textAlignment = NSTextAlignmentCenter;
                        tagLabel.text = @"即将入驻";
                        tagLabel.layer.cornerRadius  = tagLabel.height /2.0;
                        tagLabel.layer.borderWidth = 0.5;
                        tagLabel.layer.borderColor = LYZTheme_warmGreyFontColor.CGColor;
                        tagLabel.centerX = butn1.centerX;
                        tagLabel.y = butn1.y + 30;
                        [self.hotTagView addSubview:tagLabel];
                    }
                }else{
                    UIButton *butn1 = [UIButton buttonWithType:UIButtonTypeSystem];
                    butn1.frame = CGRectMake(SCREEN_WIDTH/3*i, 25+50*j, SCREEN_WIDTH/3, 50);
                    butn1.tag = j*3 +i;
                    butn1.backgroundColor = [UIColor whiteColor];
                    [self.hotTagView addSubview:butn1];
                }
            }
        }
    }

    
}

-(void)openingSoon:(UIButton *)sender{
    [GCDQueue executeInMainQueue:^{
        NSString *content                     =  @"即将入驻！";
        NSArray  *buttonTitles                =  @[AlertViewRedStyle(@"知道了")];
        AlertViewMessageObject *messageObject = MakeAlertViewMessageObject(nil,content, buttonTitles);
        [AlertView showManualHiddenMessageViewInKeyWindowWithMessageObject:messageObject delegate:self viewTag:123];
    }];

}
#pragma mark - BaseMessageViewDelegate

- (void)baseMessageView:(__kindof BaseMessageView *)messageView event:(id)event {
    
    NSLog(@"%@, tag:%ld event:%@", NSStringFromClass([messageView class]), (long)messageView.tag, event);
    if (messageView.tag == 123) {
        if ([event isEqualToString:@"知道了"]) {
            
        }
    }
    [messageView hide];
    
}

- (void)searchByCity:(UIButton *)sender{

    UIButton *button = sender;
    
    self.searchBar.text = button.currentTitle;
    
    self.tableView.hidden = NO;
    
    [self.hotTagView removeFromSuperview];
    
    NSString *keyword = [self.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (keyword.length > 0) {
        [self.searchBar endEditing:YES];
        
        [[EmptyManager sharedManager] removeEmptyFromView:self.tableView];
        
        NSString *ilat = [NSString stringWithFormat:@"%f",self.locService.userLocation.location.coordinate.latitude];
        
        NSString *ilong = [NSString stringWithFormat:@"%f",self.locService.userLocation.location.coordinate.longitude];
        
        [[LYZNetWorkEngine sharedInstance] searchForKeyword:VersionCode devicenum:DeviceNum fromtype:FromType longitude:ilong latitude:ilat keywords:keyword limit:@"10" pages:@"1" block:^(int event, id object) {
            
            if (event == 1) {
                
                [[EmptyManager sharedManager] removeEmptyFromView:self.tableView];
                
                SearchForKeywordsResponse *response = (SearchForKeywordsResponse*)object;
                NSLog(@"%@",response);
                BaseSearchForKeywordsModel *baseModel = response.searchForKeyModel;
                
                self.searchResultArray= baseModel.hotels.mutableCopy;
                
                [self.tableView reloadData];
                
            }else if(event == 2){
                
                [[EmptyManager sharedManager]showEmptyOnView:self.tableView withImage:[UIImage imageNamed:@"search_nOnresult"] explain:@"无此相关酒店" operationText:nil operationBlock:^{
                    
                }];
                
            }
            
        }];
        //        [self.api searchGoodsWithKeyword:keyword];
    }

}


- (void)getHotelList{
    NSString *ilat;
    NSString *ilong;
    
    if (! self.locService.userLocation.location ||  !self.locService.userLocation.location) {
       ilat = @"";
        ilong = @"";
    }else{
        ilat = [NSString stringWithFormat:@"%f",self.locService.userLocation.location.coordinate.latitude];
        ilong = [NSString stringWithFormat:@"%f",self.locService.userLocation.location.coordinate.longitude];
    }
    
    [[LYZNetWorkEngine sharedInstance] getSearchLoad:VersionCode devicenum:DeviceNum fromtype:FromType longitude:ilong latitude:ilat block:^(int event, id object) {
        
        if (event == 1) {
            
            [[EmptyManager sharedManager] removeEmptyFromView:self.LocationTableview];
            NSLog(@"%@",object);
            GetSearchLoadResponse *response = (GetSearchLoadResponse*)object;
            NSLog(@"%@",response);
            
            BaseSearchLoadModel *baseModel = response.baseSearchLoadModel;
            NSArray *hotels = baseModel.hotels;
            self.SearchLoadCitysModelList  = hotels;
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:hotels] forKey:@"SearchHotel"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            
            self.SearchLoadCitysList = baseModel.citys;
            NSLog(@"%@",self.SearchLoadCitysModelList);
            if (self.SearchLoadCitysList.count > 0) {
                [GCDQueue executeInMainQueue:^{
                    [self configHotTagViewWithTags:self.SearchLoadCitysList];
                    if (! self.locService.userLocation.location ||  !self.locService.userLocation.location) {
                      [self.LocationTableview reloadData];
                    }
                }];
            }
          
        }else if(event == 2)
        {
        
            [[EmptyManager sharedManager]showEmptyOnView:self.LocationTableview withImage:[UIImage imageNamed:@"search_nOnresult"] explain:@"抱歉，没有找到相关酒店" operationText:nil operationBlock:^{
                
            }];
        
        
        }else{
        
        [[EmptyManager sharedManager] showNetErrorOnView:self.LocationTableview response:nil operationBlock:^{
            
        }];
        }
    }];

}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    self.tableView.hidden = NO;
    
    [self.hotTagView removeFromSuperview];
    
    NSString *keyword = [searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (keyword.length > 0) {
        [self.searchBar endEditing:YES];
        
        [[EmptyManager sharedManager] removeEmptyFromView:self.tableView];
        
        NSString *ilat = [NSString stringWithFormat:@"%f",self.locService.userLocation.location.coordinate.latitude];
        
        NSString *ilong = [NSString stringWithFormat:@"%f",self.locService.userLocation.location.coordinate.longitude];
        
        [[LYZNetWorkEngine sharedInstance]searchForKeyword:VersionCode devicenum:DeviceNum fromtype:FromType longitude:ilong latitude:ilat keywords:keyword limit:@"10" pages:@"1" block:^(int event, id object) {
            
            if (event == 1) {
                
                [[EmptyManager sharedManager] removeEmptyFromView:self.tableView];
                
                SearchForKeywordsResponse *response = (SearchForKeywordsResponse*)object;
                NSLog(@"%@",response);
                BaseSearchForKeywordsModel *baseModel = response.searchForKeyModel;
                
                 self.searchResultArray= baseModel.hotels.mutableCopy;
                
                [self.tableView reloadData];
                
            }else if(event == 2){
            
//            [[EmptyManager sharedManager] showEmptyOnView:self.tableView withImage:[UIImage imageNamed:@"search_nOnresult"] explain:@"抱歉，没有找到相关酒店" operationText:nil operationBlock:^{
//                
//            }];
                
            }
            
        }];
        
    }
    
}

//-(UIView *)emptyView{
//    if (!_emptyView) {
//        _emptyView = [[UIView alloc] initWithFrame:self.tableView.bounds];
//        _emptyView
//    }
//}

#pragma mark - Events
- (void)searchButtonClicked:(id)sender {
    NSString *keyword = [self.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (keyword.length > 0) {
        
        [self.searchBar endEditing:YES];
        
        NSString *ilat = [NSString stringWithFormat:@"%f",self.locService.userLocation.location.coordinate.latitude];
        
        NSString *ilong = [NSString stringWithFormat:@"%f",self.locService.userLocation.location.coordinate.longitude];
        
        [[LYZNetWorkEngine sharedInstance] searchForKeyword:VersionCode devicenum:DeviceNum fromtype:FromType longitude:ilong latitude:ilat keywords:keyword limit:@"10" pages:@"1" block:^(int event, id object) {
            
            if (event == 1) {
                
                
                
            }
            
        }];
        //        [self.api searchGoodsWithKeyword:keyword];
        
    }
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    if (tableView == self.tableView) {
        return 1;
    }else{
    
        return 1;
        
    }
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.tableView) {
    
         return self.searchResultArray.count;
 
    }else{
        
         return self.SearchLoadCitysModelList.count;

    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == self.tableView) {
        LYZSearchResultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LYZSearchResultTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
        cell.backgroundColor = [UIColor whiteColor];
        SearchLoadHotelModel *baseModel = [self.searchResultArray objectAtIndex:indexPath.row];
        NSLog(@"%@",baseModel.name);
        [cell refreshWithSearchGoodsModel:baseModel withSearchText:self.searchBar.text];
        return cell;
    }else{
        LYZSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LYZSearchTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth,0, 0);
        SearchLoadHotelModel *hotelModel = [self.SearchLoadCitysModelList objectAtIndex:indexPath.row];
        NSLog(@"%@,%@",hotelModel.name,hotelModel.distance);
        BOOL isShow = NO;
        if (self.currentCityString.length > 0 && ![self.currentCityString isEqualToString:@""] ) {
            if ([hotelModel.name containsString:[self.currentCityString substringToIndex:1]]) {
                isShow = YES;
            }
        }
        [cell refreshWithSearchHotelModel:hotelModel showDistance:isShow];
        return cell;
    }
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    self.LocationTableview.hidden = YES;
    
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    [self.searchResultArray removeAllObjects];
    [self.tableView addSubview:self.hotTagView];
    [self.tableView reloadData];
    
    self.tableView.hidden = NO;
    self.hotTagView.hidden = NO;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    
    self.tableView.hidden = NO;
    
    if (searchBar.text.length == 0) {
        
        self.tableView.hidden = YES;
        
        self.LocationTableview.hidden = NO;
        
    }
    
    return YES;
}
//


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    self.tableView.hidden = NO;
    self.hotTagView.hidden = YES;
    if (searchBar.text.length == 0) {
        
        self.tableView.hidden = YES;
        
        self.LocationTableview.hidden = NO;
        
    }
    
    
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (tableView == self.tableView) {
   
            SearchLoadHotelModel *baseModel = [self.searchResultArray objectAtIndex:indexPath.row];

            LYZHotelViewController *hotel = [LYZHotelViewController new];
            hotel.hidesBottomBarWhenPushed = YES;
            hotel.i_hotelId = baseModel.hotelID;
        [self hiddenTFModalViewControllerWithHiddenCompletionBlock:^{
            
        }];
            UINavigationController *nav = self.tabBarController.viewControllers[0];
            [nav pushViewController:hotel animated:YES];
      
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dismiss" object:nil];

    }else{
        
            SearchLoadHotelModel *hotelModel = [self.SearchLoadCitysModelList objectAtIndex:indexPath.row];

                LYZHotelViewController *hotel = [LYZHotelViewController new];
            hotel.hidesBottomBarWhenPushed = YES;
                hotel.i_hotelId = hotelModel.hotelID;
        [self hiddenTFModalViewControllerWithHiddenCompletionBlock:^{
            
        }];
        UINavigationController *nav = self.tabBarController.viewControllers[0];
        [nav pushViewController:hotel animated:YES];
        [self hiddenTFModalViewControllerWithHiddenCompletionBlock:nil];
        

    }

}

#pragma mark 开始定位

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    NSLog(@"%@",userLocation.title);
    self.latitude = userLocation.location.coordinate.latitude;
    self.longitude = userLocation.location.coordinate.longitude;
    
    [self getHotelList];
    [self outputAdd];
}

/**
 *在地图View停止定位后，会调用此函数
 */
- (void)didStopLocatingUser
{
    [self.LocationTableview reloadData];
}

/**
 *定位失败后，会调用此函数
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
     [self getHotelList];
}

#pragma mark geoCode的Get方法，实现延时加载
- (BMKGeoCodeSearch *)geoCode
{
    if (!_geoCode)
    {
        _geoCode = [[BMKGeoCodeSearch alloc] init];
        _geoCode.delegate = self;
    }
    return _geoCode;
}

//#pragma mark 获取地理位置按钮事件
- (void)outputAdd
{
    // 初始化反地址编码选项（数据模型）
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
    // 将数据传到反地址编码模型
    option.reverseGeoPoint = CLLocationCoordinate2DMake(self.latitude, self.longitude);
    NSLog(@"%f - %f", option.reverseGeoPoint.latitude, option.reverseGeoPoint.longitude);
    // 调用反地址编码方法，让其在代理方法中输出
    [self.geoCode reverseGeoCode:option];
}

#pragma mark 代理方法返回反地理编码结果
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (result) {
        
        self.currentCityString = [NSString stringWithFormat:@"%@%@",result.addressDetail.city,result.addressDetail.district];  ;
        
        // 定位一次成功后就关闭定位
        [_locService stopUserLocationService];

        
    }else{
        NSLog(@"%@", @"找不到相对应的位置");
    }
    
}


#pragma mark 代理方法返回地理编码结果
- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (result) {
        NSString *locationString = [NSString stringWithFormat:@"经度为：%.2f   纬度为：%.2f", result.location.longitude, result.location.latitude];
        NSLog(@"经纬度为：%@ 的位置结果是：%@", locationString, result.address);
        //        NSLog(@"%@", result.address);
    }else{
        //        self.location.text = @"找不到相对应的位置";
        NSLog(@"%@", @"找不到相对应的位置");
    }
}


- (void)callAction:(UIButton *)call{
    [LYZPhoneCall noAlertCallPhoneStr:CustomerServiceNum withVC:self];
}


//- (void)push:(NSDictionary *)params
//{
//    // 类名
//    NSString *class =[NSString stringWithFormat:@"%@", params[@"LYZHotelViewController"]];
//    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
//    
//    // 从一个字串返回一个类
//    Class newClass = objc_getClass(className);
//    if (!newClass)
//    {
//        // 创建一个类
//        Class superClass = [NSObject class];
//        newClass = objc_allocateClassPair(superClass, className, 0);
//        // 注册你创建的这个类
//        objc_registerClassPair(newClass);
//        
//    }
//    // 创建对象
//    id instance = [[newClass alloc] init];
//    
//    // 对该对象赋值属性
//    NSDictionary * propertys = params[@"property"];
//    [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        // 检测这个对象是否存在该属性
//        /*
//        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
//             利用kvc赋值
//            [instance setValue:obj forKey:key];
//        }
//         */
//        
//    }];
//    
//    // 获取导航控制器
//    UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
//    UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
//    // 跳转到对应的控制器
//    [pushClassStance pushViewController:instance animated:YES];
//}



-(void)dealloc{
    LYLog(@"dealloc !!");
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    _geoCode.delegate = nil;
    _locService = nil;
    _geoCode = nil;
    _locService.delegate = nil;
    _tableView = nil;
    _LocationTableview = nil;
}

@end
