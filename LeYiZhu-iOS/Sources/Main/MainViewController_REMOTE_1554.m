//
//  MainViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 16/11/21.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "MainViewController.h"
#import "LeftSlideView.h"
#import "MainView.h"
#import "YLZHotelListController.h"
#import "CityListViewController.h"
#import "OrderCenterController.h"
#import <CoreLocation/CoreLocation.h>
#import "UIAlertView+Block.h"
#import "LYZNetWorkEngine.h"
#import "GetCityDataResponse.h"
#import "CitysModel.h"
#import "ValuePickerView.h"
#import "HMDatePickView.h"
#import "NSDate+YYAdd.h"
#import "SearchForHotelsResponse.h"
#import "YaoQingController.h"
#import "MyCodeController.h"
#import "UIImage+YYAdd.h"
#import "PayTypeController.h"
#import "RoomPasswordController.h"

#import "SettingViewController.h"
#import "LoginManager.h"
#import "Public+JGHUD.h"



@interface MainViewController ()<CityListViewDelegate , CLLocationManagerDelegate>


@property (nonatomic , strong) LeftSlideView *slideView;
@property (nonatomic , strong) MainView *mainView;


@property (nonatomic , strong) CLLocationManager *locationManager;
@property (nonatomic , assign) CLLocationCoordinate2D currentCoor2d;

@property (nonatomic , strong) CitysModel *currentCityModel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.bounds = [UIScreen mainScreen].bounds;
    
    [self initUI];
    
    [self setupView];
    
    [self setupMainView];
    
//    [self setupTapGesture];
    
    [self initCoreLocation];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;

}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}



#pragma mark --初始化UI

- (void)setupTapGesture
{
    UITapGestureRecognizer *tapGeture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureClick:)];
    [self.view addGestureRecognizer:tapGeture];
}


 #pragma mark -- 系统定位
 #pragma mark -- 初始化位置
 - (void)initCoreLocation
 {
     NSLog(@"initCoreLocation");
     
     CLLocationManager *locationManager = [[CLLocationManager alloc]init];
     CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
     if(status == kCLAuthorizationStatusNotDetermined){
     //请求权限
     [locationManager requestWhenInUseAuthorization];
     //        [locationManager requestAlwaysAuthorization];
     
     }
     if(status == kCLAuthorizationStatusDenied || status == kCLAuthorizationStatusRestricted){
     //打开设置界面设置打开位置权限
          [UIAlertView alertWithCallBackBlock:^(NSInteger buttonIndex) {
              if(buttonIndex == 1){
                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
 
              }
         } title:nil message:@"打开定位" cancelButtonName:@"取消" otherButtonTitles:@"确定", nil];
                               
     }
     if(status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusAuthorizedAlways){
     NSLog(@"");
     }
     locationManager.distanceFilter = 1.0f;
     locationManager.desiredAccuracy = kCLLocationAccuracyBest;
     locationManager.delegate = self;
     [locationManager startUpdatingLocation];
     self.locationManager = locationManager;
     
 }
 
- (void)initUI
{
    //初始化背景
    self.view.backgroundColor = [[UIColor alloc]initWithPatternImage:[UIImage imageNamed:@"main_background"]];
    self.view.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setupView
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(10,20, 44, 44);
    [leftBtn setImage:[UIImage imageNamed:@"icon-side"] forState:UIControlStateNormal];
    leftBtn.adjustsImageWhenHighlighted = YES;
    [self.view addSubview:leftBtn];
    [leftBtn addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIImage *titleImg = [UIImage imageNamed:@"wore-hotel"];
    UIImageView *titleView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, titleImg.size.width, 44)];
    titleView.image = titleImg;
    titleView.contentMode = UIViewContentModeScaleAspectFit;
    titleView.center = CGPointMake(kScreenWidth * 0.5, 20 + 22);
    [self.view addSubview:titleView];
}

- (void)setupMainView
{
    MainView *mainview = [MainView MainViewFromNib];
    
    //添加搜索kuang
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, mainview.bounds.size.width, 50)];
    searchBar.center = CGPointMake(self.view.bounds.size.width * 0.5, 30 + 64);
    UIImage *bimg = [[UIImage imageWithColor:[UIColor clearColor]] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 2, 2, 2) resizingMode:UIImageResizingModeStretch];
    [searchBar setBackgroundImage:bimg];
    searchBar.placeholder = @"搜索";
    [self.view addSubview:searchBar];
    
    
    mainview.center = CGPointMake(self.view.bounds.size.width * 0.5, mainview.bounds.size.height * 0.5 + 64 + 20 + 30);
    [self.view addSubview:mainview];
    [mainview.locationBtn addTarget:self action:@selector(locationBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.mainView = mainview;
    
    [self.mainView.startDateBtn addTarget:self action:@selector(startDateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.endDateBtn addTarget:self action:@selector(endDateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mainView.priceBtn addTarget:self action:@selector(priceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.mainView.roomTypeBtn addTarget:self action:@selector(roomTypeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //搜索按钮
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.bounds = CGRectMake(0, 0, mainview.bounds.size.width, 55);
    searchBtn.center  = CGPointMake(self.view.bounds.size.width * 0.5, CGRectGetMaxY(mainview.frame) + 30);
    [self.view addSubview:searchBtn];

    [searchBtn setImage:[UIImage imageNamed:@"wore-search"] forState:UIControlStateNormal];
    UIImage *b1 = [[UIImage imageNamed:@"button-yellow"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 60, 20, 60) resizingMode:UIImageResizingModeStretch];

    [searchBtn setBackgroundImage:b1 forState:UIControlStateNormal];
    
    //事件
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)openSlideView
{
    NSLog(@"openSlideView");
    if(self.slideView == nil){
        UIView *blackView = [[UIView alloc]init];
        blackView.frame = self.view.bounds;
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.0;
        blackView.tag = 1000;
        [self.view addSubview:blackView];
        
        UITapGestureRecognizer *tapGeture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureClick:)];
        [blackView addGestureRecognizer:tapGeture];
        
        LeftSlideView *slideView = [LeftSlideView LeftSlideViewFromNib];
        slideView.parentVC = self;
        slideView.frame = CGRectMake(- slideView.bounds.size.width, 0, slideView.bounds.size.width, slideView.bounds.size.height);
//        slideView.frame = CGRectMake(0, 0, slideView.bounds.size.width, self.view.bounds.size.height);
        self.slideView = slideView;
        [self.view addSubview:slideView];
        [slideView.slideCloseBtn addTarget:self action:@selector(slideCloseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [slideView.exitBtn addTarget:self action:@selector(exitBtnClick:) forControlEvents:UIControlEventTouchUpInside];

        [UIView animateWithDuration:0.5f animations:^{
           slideView.frame = CGRectMake(0, 0, slideView.bounds.size.width, self.view.bounds.size.height);
            blackView.alpha = 0.6;

        } completion:^(BOOL finished) {
            
        }];
        
    }else{
        UIView *blackView = [[UIView alloc]init];
        blackView.frame = self.view.bounds;
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0.0;
        blackView.tag = 1000;
        [self.view insertSubview:blackView belowSubview:self.slideView];
        
        UITapGestureRecognizer *tapGeture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureClick:)];
        [blackView addGestureRecognizer:tapGeture];
        
        [UIView animateWithDuration:0.5f animations:^{
            self.slideView.frame = CGRectMake(0, 0, self.slideView.bounds.size.width, self.view.bounds.size.height);
            blackView.alpha = 0.6;
        } completion:^(BOOL finished) {
            
        }];

    }
    
}
#pragma mark -- 点击事件
- (void)startDateBtnClick:(UIButton*)sender
{
    /** 自定义日期选择器 */
    HMDatePickView *datePickVC = [[HMDatePickView alloc] initWithFrame:self.view.frame];
    //距离当前日期的年份差（设置最大可选日期）
    datePickVC.maxYear = -1;
    //设置最小可选日期(年分差)
    //    _datePickVC.minYear = 10;
    datePickVC.date = [NSDate date];
    //设置字体颜色
    datePickVC.fontColor = YellowColor;
    //日期回调
    __weak typeof(self) weakSelf = self;
    datePickVC.completeBlock = ^(NSString *selectDate) {
//        [weakSelf.mainView.startDateBtn setTitle:selectDate forState:UIControlStateNormal];
    };
    
    datePickVC.completeDateBlock = ^(NSDate *selectedDate){
        NSUInteger month = selectedDate.month;
        NSUInteger day = selectedDate.day;
        
        NSString *monthStr = [NSString stringWithFormat:@"%lu",(unsigned long)month];
        NSString *dayStr = [NSString stringWithFormat:@"%lu",day];
        
        NSLog(@"selectedDate : %@" ,selectedDate);
        [weakSelf.mainView.startDateBtn setTitle:dayStr forState:UIControlStateNormal];
        [weakSelf.mainView.startMonthLabel setText:monthStr];

    };
    
    //配置属性
    [datePickVC configuration];
    
    [self.view addSubview:datePickVC];
}

- (void)endDateBtnClick:(UIButton*)sender
{
    HMDatePickView *datePickVC = [[HMDatePickView alloc] initWithFrame:self.view.frame];
    //距离当前日期的年份差（设置最大可选日期）
    datePickVC.maxYear = -1;
    //设置最小可选日期(年分差)
    //    _datePickVC.minYear = 10;
    datePickVC.date = [NSDate date];
    //设置字体颜色
    datePickVC.fontColor = YellowColor;
    //日期回调
    __weak typeof(self) weakSelf = self;
    datePickVC.completeBlock = ^(NSString *selectDate) {
        //        [weakSelf.mainView.startDateBtn setTitle:selectDate forState:UIControlStateNormal];
    };
    
    datePickVC.completeDateBlock = ^(NSDate *selectedDate){
        NSUInteger month = selectedDate.month;
        NSUInteger day = selectedDate.day;
        
        NSString *monthStr = [NSString stringWithFormat:@"%lu",(unsigned long)month];
        NSString *dayStr = [NSString stringWithFormat:@"%lu",day];
        
        NSLog(@"selectedDate : %@" ,selectedDate);
        [weakSelf.mainView.endDateBtn setTitle:dayStr forState:UIControlStateNormal];
        [weakSelf.mainView.endMonthLabel setText:monthStr];
        
    };
    
    //配置属性
    [datePickVC configuration];
    
    [self.view addSubview:datePickVC];
}

- (void)priceBtnClick:(UIButton*)sender
{
    ValuePickerView* pickerView = [[ValuePickerView alloc]init];
    
    pickerView.dataSource =@[@"100-200",@"200-300" ,@"300-400"];
    pickerView.pickerTitle = @"价格";
    __weak typeof(self) weakSelf = self;
    pickerView.valueDidSelect = ^(NSString *value){
        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
        [weakSelf.mainView.priceBtn setTitle:stateArr[0] forState:UIControlStateNormal];
    };
    
    [pickerView show];
}


- (void)roomTypeBtnClick:(UIButton*)sender
{
    ValuePickerView* pickerView = [[ValuePickerView alloc]init];
    pickerView.tintColor = YellowColor;
    pickerView.dataSource =@[@"舒适型",@"经济型" ,@"豪华型"];
    pickerView.pickerTitle = @"房间类型";
    __weak typeof(self) weakSelf = self;
    pickerView.valueDidSelect = ^(NSString *value){
        NSArray * stateArr = [value componentsSeparatedByString:@"/"];
        [weakSelf.mainView.roomTypeBtn setTitle:stateArr[0] forState:UIControlStateNormal];
    };
    
    [pickerView show];
}

- (void)slideCloseBtnClick:(UIButton*)sender
{
    [self closeSlideViewWithAnimation];
}

- (void)exitBtnClick:(UIButton*)sender
{
   
   
}

- (void)closeSlideViewWithAnimation
{
    NSLog(@"closeSlideViewWithAnimation");
    UIView *blackView = [self.view viewWithTag:1000];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.slideView.frame = CGRectMake(- self.slideView.bounds.size.width, 0, self.slideView.bounds.size.width, self.slideView.bounds.size.height);
        blackView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [blackView removeFromSuperview];
    }];

}

- (void)closeSlideViewWithNoAnimation
{
    NSLog(@"closeSlideViewWithNoAnimation");
    UIView *blackView = [self.view viewWithTag:1000];
    [blackView removeFromSuperview];
    self.slideView.frame = CGRectMake(- self.slideView.bounds.size.width, 0, self.slideView.bounds.size.width, self.slideView.bounds.size.height);
    

}

#pragma mark -- 事件响应
- (void)tapGestureClick:(UITapGestureRecognizer*)tapGeture
{
    if(self.slideView){
        //判断位置
        CGPoint point = [tapGeture locationInView:self.view];
        
        BOOL isContain =  CGRectContainsPoint(self.slideView.frame, point);
        if(isContain){
            

        }else{
            [self closeSlideViewWithAnimation];

        }

    }
}

- (void)searchBtnClick:(UIButton*)sender
{
    NSString *cityId = self.currentCityModel.city_id;
    NSString *minprice = @"100";
    NSString *maxprice = @"2000";
    NSString *type = @"0";
    NSString *longitude = [NSString stringWithFormat:@"%f",self.currentCoor2d.longitude];
    NSString *latitude = [NSString stringWithFormat:@"%f",self.currentCoor2d.latitude];
    NSString *limit = @"";
    NSString *pages = @"";
    
    [[LYZNetWorkEngine sharedInstance] searchForHotelsWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType cityId:cityId minprice:minprice maxprice:maxprice type:type longitude:longitude latitude:latitude limit:limit pages:pages block:^(int event, id object) {
        if(event == 1){
            NSLog(@"success : %@" , object);
            SearchForHotelsResponse *hotelResponse = (SearchForHotelsResponse*)object;
            
            YLZHotelListController *vc = [[YLZHotelListController alloc]init];
            vc.hotelArray = hotelResponse.baseSearchResult.searchResult;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            NSLog(@"failure : %@" , object);
        }
        
    }];
    
    
}
- (void)leftBtnClick:(UIButton*)sender
{
    NSLog(@"leftBtnClick");
    
    [self openSlideView];
}

- (void)locationBtnClick:(UIButton*)sender
{
    //从网路请求地址
    [[LYZNetWorkEngine sharedInstance]getCityDataWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType block:^(int event, id object) {
        if(event == 1){
            NSLog(@"获取地址成功");
            GetCityDataResponse *cityData = (GetCityDataResponse*)object;
            
            NSArray *provinceList = cityData.provicesObject.provinceslist;
            
            NSLog(@"citydata count :%ld" , cityData.provicesObject.provinceslist.count);
            NSLog(@"%@" , provinceList);
            
            CityListViewController *cityListView = [[CityListViewController alloc]init];
            cityListView.arrayCitys = provinceList;
            cityListView.delegate = self;
            //热门城市列表
            cityListView.arrayHotCity = [NSMutableArray arrayWithObjects:@"广州",@"北京",@"天津",@"厦门",@"重庆",@"福州",@"泉州",@"济南",@"深圳",@"长沙",@"无锡", nil];
            //历史选择城市列表
            cityListView.arrayHistoricalCity = [NSMutableArray arrayWithObjects:@"福州",@"厦门",@"泉州", nil];
            //定位城市列表
            cityListView.arrayLocatingCity   = [NSMutableArray arrayWithObjects:@"福州", nil];
            
            [self presentViewController:cityListView animated:YES completion:nil];
            
        }else{
            NSLog(@"获取地址失败");
            NSLog(@"object:%@" , object);
        }
    }];
    
    
    
    
}

- (void)didClickedWithCityName:(NSString*)cityName cityModel:(CitysModel *)cityModel
{
    self.currentCityModel = cityModel;
    [self.mainView.locationBtn setTitle:cityName forState:UIControlStateNormal];
    
}

#pragma mark -- 左边LeftSlideView cell点击事件
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSArray *titleArray = @[@"订单中心",@"付款方式",@"我的二维码",@"我的设置",@"邀请好友",@"常见问题",@"优惠券",@"400-000-0000"];
    
    if(indexPath.row == 0){
        //订单中心 d
        OrderCenterController *vc = [[OrderCenterController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if(indexPath.row == 1){
        //付款方式 d
        PayTypeController *vc = [[PayTypeController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if(indexPath.row == 2){
        //我的房间密码
        RoomPasswordController *vc = [[RoomPasswordController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
//        MyCodeController *vc = [[MyCodeController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if(indexPath.row == 3){
        if ([LoginManager instance].isLogin) {
            //设置
            SettingViewController * settingVC = [[SettingViewController alloc] init];
            [self.navigationController pushViewController:settingVC animated:YES];
        }else{
            [[LoginManager instance] userLogin];
        
        }
       
        
        
    }
    
    if(indexPath.row == 4){
        
        //收藏
        

    }
    if(indexPath.row == 5){
        //邀请好友
        YaoQingController *vc = [[YaoQingController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(indexPath.row == 6){
        //常见问题
    }
    if(indexPath.row == 7){
        //优惠券
    }
    if(indexPath.row == 8){
        //400电话
    }
}

#pragma mark -- 定位代理
#pragma mark -- 系统定位服务 位置的更新代理
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"didUpdateLocations");
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coor2d = location.coordinate ;
    
    NSLog(@"location : %@",location);
//    NSLog(@"当前位置 : %@",);
    self.currentCoor2d = coor2d;
    //经纬度反查
    CLLocation * newLocation = location;
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    [clGeoCoder reverseGeocodeLocation:newLocation completionHandler: ^(NSArray *placemarks,NSError *error) {
        
        NSLog(@"--array--%d---error--%@",(int)placemarks.count,error);
        
        if (placemarks.count > 0) {
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
//            NSLog(@"placemark : %@" , placemark);
            NSString *province = placemark.administrativeArea;
            NSString *city = placemark.addressDictionary[@"City"];
            
            NSString *locationStr = [NSString stringWithFormat:@"%@%@",province , city];
            [self.mainView.locationBtn setTitle:locationStr forState:UIControlStateNormal];
            
            NSLog(@"%@",placemark.addressDictionary[@"Name"]);
            NSLog(@"%@",placemark.addressDictionary[@"City"]);
            NSLog(@"%@",placemark.addressDictionary[@"Country"]);

        }
    }];
    
}


/*
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    [self closeSlideViewWithAnimation];
}
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
