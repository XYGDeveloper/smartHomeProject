//
//  HotelMapViewController.m
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/30.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "HotelMapViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import<BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import "YWPointAnnotation.h"
#import "YWActionPaopaoView.h"
#import "JZLocationConverter.h"
#import<CoreLocation/CoreLocation.h>
#import<MapKit/MapKit.h>
#import "MapTool.h"

#define kCalloutWidth   290
#define kCalloutHeight  70.0

@interface HotelMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
      BMKMapView                   *_mapView;//地图对象
      BMKGeoCodeSearch *_geocodesearch; //地理编码主类，用来查询、返回结果信息
}
@property (nonatomic,strong)BMKLocationService *locService;

@property (nonatomic,strong)BMKPoiSearch *search;

@property (nonatomic, strong)BMKUserLocation *myLocation;

@property (nonatomic, strong) NSArray *maps; //能打开的第三方地图应用

@end

@implementation HotelMapViewController

-(void)viewWillDisappear:(BOOL)animated{
    [ super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _mapView = nil;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [ super viewWillAppear:animated];
    [_mapView viewWillAppear];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"酒店位置";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initMapView];//初始化地图
    [self SetBasicLocation];
    CLLocationCoordinate2D coor;
    coor.latitude = [self.ilatidute doubleValue] ;
    coor.longitude = [self.ilongitude doubleValue];
//    self.maps = [self getInstalledMapAppWithAddr:self.address withEndLocation:coor];
    UIButton *locateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    locateBtn.frame = CGRectMake(DefaultLeftSpace, SCREEN_HEIGHT - 64 - 70, 40, 40);
    [locateBtn setImage:[UIImage imageNamed:@"location_selected2d"] forState:UIControlStateNormal];
    [locateBtn addTarget:self action:@selector(locatePosition:) forControlEvents:UIControlEventTouchUpInside];
    locateBtn.layer.cornerRadius = 4.0f;
    [self.view insertSubview:locateBtn atIndex:1201];
    
}


-(void)initBottomView{
    
    UIButton * navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navBtn.frame = CGRectMake(SCREEN_WIDTH/2, SCREEN_HEIGHT- 50-64 , SCREEN_WIDTH/2, 50);
    navBtn.backgroundColor = LYZTheme_paleBrown;
    navBtn.alpha = 1.0f;
    [navBtn setTitle:@"开启地图导航" forState:UIControlStateNormal];
    navBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [navBtn addTarget:self action:@selector(baiduNav:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:navBtn atIndex:1001];
        
    UIButton * sCanLine = [UIButton buttonWithType:UIButtonTypeCustom];
    sCanLine.frame = CGRectMake(0, SCREEN_HEIGHT - 50-64 , SCREEN_WIDTH/2, 50
);
    sCanLine.backgroundColor = LYZTheme_paleBrown;
    sCanLine.alpha = 1.0f;
    [sCanLine setTitle:@"查看路线规划" forState:UIControlStateNormal];
    sCanLine.titleLabel.font = [UIFont systemFontOfSize:16];
    [sCanLine addTarget:self action:@selector(openBaiduRout:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:sCanLine atIndex:1002];
    
}

#pragma mark --private Method--初始化地图

-(void)initMapView{
    
    BMKMapView  *mapView=[[ BMKMapView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    mapView.mapType=BMKMapTypeStandard;
//    mapView.userTrackingMode=BMKUserTrackingModeFollowWithHeading;
    mapView.showsUserLocation = YES;//显示定位图层
    mapView.zoomLevel=18;
    mapView.minZoomLevel=10;
    mapView.delegate=self;
    _mapView=mapView;
    [self.view addSubview:mapView];
    
    _geocodesearch = [[BMKGeoCodeSearch alloc] init];
    _geocodesearch.delegate = self;
    
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//    //启动LocationService
//    [_locService startUserLocationService];
    
}

-(void)SetBasicLocation{
    [self mapViewAddANNotations];
}

-(void)mapViewAddANNotations{
    
    CLLocationCoordinate2D coor;
    coor.latitude = [self.ilatidute doubleValue] ;
    coor.longitude = [self.ilongitude doubleValue];
    _mapView.centerCoordinate = coor;//移动到中心点
    YWPointAnnotation* annotation = [[YWPointAnnotation alloc] initWithCoordinate:coor];
    annotation.title = self.hotelName;
    annotation.subtitle=self.address;
    [_mapView addAnnotation:annotation];
    [_mapView mapForceRefresh];
    
    
}

#pragma mark-当定位信息发生改变时，
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    
    NSLog(@"heading is %@",userLocation.heading);
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    _myLocation = userLocation;
    [_mapView updateLocationData:userLocation]; //更新地图上的位置
    
    CLLocation *target = [[CLLocation alloc] initWithLatitude: [self.ilatidute doubleValue] longitude:[self.ilongitude doubleValue]];
    CLLocation *mLocation = [[CLLocation alloc] initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    [self mapViewFitAnnotations:@[mLocation,target]];

//    BMKMapPoint point1 = BMKMapPointForCoordinate(coor);
//    BMKMapPoint point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(_myLocation.location.coordinate.latitude,_myLocation.location.coordinate.latitude));
//    CLLocationDistance distance = BMKMetersBetweenMapPoints(point1,point2);

//    _mapView.centerCoordinate = userLocation.location.coordinate; //更新当前位置到地图中间
    
    //地理反编码
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    
    reverseGeocodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag){
        
        NSLog(@"反geo检索发送成功");
        
        [_locService stopUserLocationService];
        
    }else{
        
        NSLog(@"反geo检索发送失败");
        
    }}


- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    BMKAnnotationView *annotationView = [[BMKAnnotationView alloc]  initWithAnnotation:annotation reuseIdentifier:@"myAnnotation"];
    //    annotationView.animatesDrop = YES;// 设置该标注点动画显示
    annotationView.image = [UIImage imageNamed:@"icon_location_marker"];   //把大头针换成别的图片
    //自定义内容气泡
    UIView *areaPaoView= [[YWActionPaopaoView alloc] initWithFrame:CGRectMake(0, 0, kCalloutWidth, kCalloutHeight)];
    areaPaoView.center = CGPointMake(CGRectGetWidth(annotationView. bounds) / 2.f + annotationView.calloutOffset.x,-CGRectGetHeight(annotationView.bounds) / 2.f + annotationView.calloutOffset.y);
    //这张图片是做好的半透明的
//    areaPaoView.layer.contents =(id)[UIImage imageNamed:@"map_1"].CGImage;
   YWPointAnnotation* Newannotation=(YWPointAnnotation*)annotation;

    UILabel *titleLabel = [[UILabel alloc]  initWithFrame:CGRectMake(10, 10, kCalloutWidth - 2*10 - 45 , 20)];
    titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = Newannotation.title;
    
    UILabel *subTitleLabel = [[UILabel alloc]  initWithFrame:CGRectMake(10, titleLabel.bottom + 5, kCalloutWidth - 2*10 - 45 , 20)];
    subTitleLabel.numberOfLines = 0;
    subTitleLabel.font  = [UIFont fontWithName:LYZTheme_Font_Light size:13];
    subTitleLabel.textColor = LYZTheme_greyishBrownFontColor;
    subTitleLabel.text = Newannotation.subtitle;
    
    UIButton *navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navBtn.frame = CGRectMake(kCalloutWidth - 10 - 45, (kCalloutHeight -8- 25)/2.0, 45, 25);
    [navBtn setTitleColor:[UIColor colorWithHexString:@"#AF9372"] forState:UIControlStateNormal];
    [navBtn setTitle:@"导航" forState:UIControlStateNormal];
    navBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:12];
    [navBtn addTarget:self action:@selector(navBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    navBtn.layer.borderColor = [UIColor colorWithHexString:@"#AF9372"].CGColor;
    navBtn.layer.borderWidth = 1.0f;
    navBtn.layer.cornerRadius = 4;
    
    [areaPaoView addSubview:titleLabel];
    [areaPaoView addSubview:subTitleLabel];
    [areaPaoView addSubview:navBtn];
    
    //布局完之后将View整体添加到BMKActionPaopaoView上
    BMKActionPaopaoView *paopao=[[BMKActionPaopaoView alloc]initWithCustomView:areaPaoView];
    
    annotationView.paopaoView = paopao;
    annotationView.selected = YES;
        
    return annotationView;
}
    
    
- (void)mapView:(BMKMapView *)mapView annotationView:(BMKAnnotationView *)view didChangeDragState:(BMKAnnotationViewDragState)newState
   fromOldState:(BMKAnnotationViewDragState)oldState
{
    
}


#pragma mark -- Button Action

- (void)openBaiduRout:(id)sender{

    BMKNaviPara* para = [[BMKNaviPara alloc]init];
    //初始化起点节点
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    //指定起点经纬度
    CLLocationCoordinate2D coor1;
    coor1.latitude =self.locService.userLocation.location.coordinate.latitude;
    coor1.longitude =self.locService.userLocation.location.coordinate.longitude;
    start.pt = coor1;
    //指定起点名称
    start.name = @"我的位置";
    //指定起点
    para.startPoint = start;
    //初始化终点节点
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    //指定终点经纬度
    CLLocationCoordinate2D coor2;
    coor2.latitude = [self.ilatidute doubleValue];
    coor2.longitude = [self.ilongitude doubleValue];
    end.pt = coor2;
    //指定终点名称
    end.name = self.address;
    //指定终点
    para.endPoint = end;
    //指定返回自定义scheme
      para.appScheme = @"baidumapsdk://mapsdk.baidu.com";
    //调启百度地图客户端导航
    BMKOpenTransitRouteOption *rout = [[BMKOpenTransitRouteOption alloc]init];
    rout.startPoint =start;
    rout.endPoint  = end;
    [BMKOpenRoute openBaiduMapTransitRoute:rout];
}

-(void)baiduNav:(id)sender{
    
    [self openNativeNavi];
}

- (void)openNativeNavi {
    //初始化调启导航时的参数管理类
    BMKNaviPara* para = [[BMKNaviPara alloc]init];
    //初始化起点节点
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    //指定起点经纬度
    CLLocationCoordinate2D coor1;
    coor1.latitude =self.locService.userLocation.location.coordinate.latitude;
    coor1.longitude =self.locService.userLocation.location.coordinate.longitude;
    start.pt = coor1;
    //指定起点名称
    start.name = @"当前位置位置";
    //指定起点
    para.startPoint = start;
    //初始化终点节点
    BMKPlanNode* end = [[BMKPlanNode alloc] init];
    //指定终点经纬度
    CLLocationCoordinate2D coor2;
    coor2.latitude = [self.ilatidute doubleValue];
    coor2.longitude = [self.ilongitude doubleValue];
    end.pt = coor2;
    //指定终点名称
    end.name = self.address;
    //指定终点
    para.endPoint = end;
    //指定返回自定义scheme
  //  para.appScheme = @"baidumapsdk://mapsdk.baidu.com";
    //调启百度地图客户端导航
    [BMKNavigation openBaiduMapNavigation:para];
    
}

// 苹果地图

- (void)navAppleMap:(CLLocationCoordinate2D)gps

{
    CLLocationCoordinate2D converte_gps = [JZLocationConverter bd09ToWgs84:gps];
    
    MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
    
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:converte_gps addressDictionary:nil]];
    
    NSArray *items = @[currentLoc,toLocation];
    
    NSDictionary *dic = @{
                          
                          MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                          
                          MKLaunchOptionsMapTypeKey: @(MKMapTypeStandard),
                          
                          MKLaunchOptionsShowsTrafficKey: @(YES)
                          
                          };
    
    [MKMapItem openMapsWithItems:items launchOptions:dic];
    
    
  
    
}



///  第三方地图

- (void)otherMap:(NSInteger)index

{
    
    NSDictionary *dic = self.maps[index];
    
    NSString *urlString = dic[@"url"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    
}

-(void)navBtnClick:(UIButton *)sender{
    LYLog(@"导航");
//    [self baiduNav:nil];
    CLLocationCoordinate2D coor;
    coor.latitude = [self.ilatidute doubleValue] ;
    coor.longitude = [self.ilongitude doubleValue];
//    [self alertAmaps:coor];
    [[MapTool sharedMapTool] navigationActionWithCoordinate:coor WithENDName:self.address tager:self];
}

-(void)locatePosition:(UIButton *)sender{
#pragma mark-调用此类进行定位，定位信息从在于userLocal

    //启动LocationService
    [_locService startUserLocationService];
}

- (void)alertAmaps:(CLLocationCoordinate2D)gps

{
    
    if (self.maps.count == 0) {
        
        return;
        
    }
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i = 0; i < self.maps.count; i++) {
        
        if (i == 0) {
            
            [alertVC addAction:[UIAlertAction actionWithTitle:self.maps[i][@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [self navAppleMap:gps];
                
            }]];
            
        }else{
            
            [alertVC addAction:[UIAlertAction actionWithTitle:self.maps[i][@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if ([self.maps[i][@"title"]  isEqualToString:@"百度地图"]) {
                    [self openBaiduRout:nil];
                }else{
                     [self otherMap:i];
                }
               
                
            }]];
            
        }
        
    }
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
}


#pragma mark --Private

- (void)mapViewFitAnnotations:(NSArray<CLLocation *> *)locations
{
    if (locations.count < 2) return;
    
    CLLocationCoordinate2D coor = [locations[0] coordinate];
    BMKMapPoint pt = BMKMapPointForCoordinate(coor);
    
    CGFloat ltX, ltY, rbX, rbY;
    
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    
    for (int i = 1; i < locations.count; i++) {
        
        CLLocationCoordinate2D coor = [locations[i] coordinate];
        
        BMKMapPoint pt = BMKMapPointForCoordinate(coor);
        
        if (pt.x < ltX) ltX = pt.x;
        if (pt.x > rbX) rbX = pt.x;
        if (pt.y > ltY) ltY = pt.y;
        if (pt.y < rbY) rbY = pt.y;
    }
    
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    
    [_mapView setVisibleMapRect:rect];
    _mapView.zoomLevel = _mapView.zoomLevel - 0.3;
}

- (NSArray *)getInstalledMapAppWithAddr:(NSString *)addrString withEndLocation:(CLLocationCoordinate2D)endLocation

{
    
    NSMutableArray *maps = [NSMutableArray array];
    
    //苹果地图
    
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    
    iosMapDic[@"title"] = @"苹果地图";
    
    [maps addObject:iosMapDic];
    
    NSString *appStr = NSLocalizedString(@"app_name", nil);
    
    //高德地图
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        
        gaodeMapDic[@"title"] = @"高德地图";
        
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&did=BGVIS2&dname=%@&dev=0&t=2",appStr ,addrString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        
        gaodeMapDic[@"url"] = urlString;
        
        [maps addObject:gaodeMapDic];
        
    }
    
    //百度地图
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        
        baiduMapDic[@"title"] = @"百度地图";
        
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=我的位置&destination=%@&mode=walking&src=%@",addrString ,appStr] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        
        baiduMapDic[@"url"] = urlString;
        
        [maps addObject:baiduMapDic];
        
    }
    
    //腾讯地图
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        
        qqMapDic[@"title"] = @"腾讯地图";
        
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=walk&tocoord=%f,%f&to=%@&coord_type=1&policy=0",endLocation.latitude , endLocation.longitude ,addrString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        
        qqMapDic[@"url"] = urlString;
        
        [maps addObject:qqMapDic];
        
    }
    
    //谷歌地图
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        
        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
        
        googleMapDic[@"title"] = @"谷歌地图";
        
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?saddr=&daddr=%@&directionsmode=walking",addrString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
        
        googleMapDic[@"url"] = urlString;
        
        [maps addObject:googleMapDic];
        
    }
    
    return maps;
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
