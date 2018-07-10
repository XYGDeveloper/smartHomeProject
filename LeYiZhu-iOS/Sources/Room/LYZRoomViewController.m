//
//  LYZRoomViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/31.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZRoomViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "WaterfallCell.h"
#import "WaterfallHeaderView.h"
#import "WaterfallFooterView.h"
#import "WaterfallPictureModel.h"
#import "GCD.h"
#import "UIImage+SizeWithURL.h"
#import "Mantle.h"
#import "FileManager.h"
#import "LYZOrderCommitViewController.h"
#import "LYZOrderCommitRoomInfoModel.h"

#import "NSDate+Formatter.h"
#import "NSDate+Utilities.h"
#import "Public+JGHUD.h"
#import "UIButton+LYZLoginButton.h"
#import "NSDate+Utilities.h"
#import "NSDate+Formatter.h"
#import "YQAlertView.h"
static NSString *kroomImgKey = @"roomImg";

static NSString *cellIdentifier   = @"WaterfallCell";
static NSString *headerIdentifier = @"WaterfallHeader";
static NSString *footerIdentifier = @"WaterfallFooter";

@interface LYZRoomViewController ()<UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout,YQAlertViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray   <WaterfallPictureModel *> *dataSource;
@property (nonatomic, strong) LYZHotelRoomDetailModel *roomModel;

@property (nonatomic, strong) UILabel * roomTypeLabel;
@property (nonatomic, strong) UILabel *roomInfoLabel;

@property (nonatomic, strong) UIButton *orderbtn;//底部btn

@end

@implementation LYZRoomViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     self.automaticallyAdjustsScrollViewInsets = NO;
     self.title = @"房间详情";
    self.view.backgroundColor = [UIColor whiteColor];
  
    // 数据源
    _dataSource = [NSMutableArray new];
    
    [self setUp];
  
}

-(void)setUp{
    [self setWaterFallCollectionView];
    [self getPictureData];
    [self configHeadView];
     [self configBottomView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- Config UI

-(void)configHeadView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    headView.backgroundColor = [UIColor blackColor];
    headView.alpha = 0.6;
    self.roomTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    self.roomTypeLabel.textColor = [UIColor whiteColor];
    self.roomTypeLabel.textAlignment = NSTextAlignmentCenter;
    self.roomTypeLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    [headView addSubview:self.roomTypeLabel];
    
    self.roomInfoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.roomTypeLabel.bottom- 2, SCREEN_WIDTH, 20)];
    self.roomInfoLabel.textColor = [UIColor whiteColor];
    self.roomInfoLabel.textAlignment = NSTextAlignmentCenter;
    self.roomInfoLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    [headView addSubview:self.roomInfoLabel];
    
    [self.view insertSubview:headView atIndex:1000];
    
}

-(void)configBottomView{
    self.orderbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.orderbtn.frame = CGRectMake(0, SCREEN_HEIGHT - 64 - 50, SCREEN_WIDTH, 50);
    self.orderbtn.backgroundColor = LYZTheme_paleBrown;
    [self.orderbtn setTitle:@"立即预订" forState:UIControlStateNormal];
    self.orderbtn.needLogin = YES;
    [self.orderbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.orderbtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
    [self.orderbtn addTarget:self action:@selector(orderNow:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:self.orderbtn atIndex:1001];
}

-(void)updateBottomBtn{
    if ([self.roomModel.openstatus.uppercaseString isEqualToString:@"Y"]) {
        if ([self.hotelRoomslModel.roomTypeStatus intValue]== 1) {
            self.orderbtn.backgroundColor = LYZTheme_paleBrown;
            [self.orderbtn setTitle:@"立即预订" forState:UIControlStateNormal];
            self.orderbtn.enabled = YES;
        }else if ([self.hotelRoomslModel.roomTypeStatus intValue]== 2){
            self.orderbtn.backgroundColor = LYZTheme_PinkishGeryColor;
            [self.orderbtn setTitle:@"满房" forState:UIControlStateNormal];
            self.orderbtn.enabled = YES;
        }else{
            self.orderbtn.backgroundColor = LYZTheme_PinkishGeryColor;
            [self.orderbtn setTitle:@"部分满房" forState:UIControlStateNormal];
            self.orderbtn.enabled = YES;
        }

    }else{
        self.orderbtn.backgroundColor = LYZTheme_PinkishGeryColor;
        [self.orderbtn setTitle:@"即将营业" forState:UIControlStateNormal];
        self.orderbtn.enabled = NO;
    }
}

-(void)setWaterFallCollectionView{
    // 初始化布局
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    
    // 设置布局
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.headerHeight = 0;            // headerView高度
    layout.footerHeight = 0;             // footerView高度
    layout.columnCount  = 1;             // 几列显示
    layout.minimumColumnSpacing    = 0;  // cell之间的水平间距
    layout.minimumInteritemSpacing = 0;  // cell之间的垂直间距
    
    // 初始化collectionView
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -50 )
                                         collectionViewLayout:layout];
    _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _collectionView.dataSource       = self;
    _collectionView.delegate         = self;
    _collectionView.backgroundColor  = [UIColor clearColor];
    
    // 注册cell以及HeaderView，FooterView
    [_collectionView registerClass:[WaterfallCell class] forCellWithReuseIdentifier:cellIdentifier ];
    [_collectionView registerClass:[WaterfallHeaderView class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader
               withReuseIdentifier:headerIdentifier];
    [_collectionView registerClass:[WaterfallFooterView class]
        forSupplementaryViewOfKind:CHTCollectionElementKindSectionFooter
               withReuseIdentifier:footerIdentifier];
    
    // 添加到视图当中
    [self.view addSubview:_collectionView];
}

#pragma mark -- Data Source

-(void)getPictureData{
    
    [[LYZNetWorkEngine sharedInstance] getHotelRoomDetailWithVersioncode:VersionCode devicenum:DeviceNum fromtype:FromType roomID:self.roomID block:^(int event, id object) {
        if (event == 1) {
            GetHotelRoomDetailsResponse *response = (GetHotelRoomDetailsResponse*)object;
           self.roomModel = response.hotelRoomDetail;
            [GCDQueue executeInMainQueue:^{
                self.roomTypeLabel.text = response.hotelRoomDetail.roomType;
                self.roomInfoLabel.text = [NSString stringWithFormat:@"%@m²,%@",self.roomModel.roomSize,_roomModel.bedType];
            }];
            [GCDQueue executeInGlobalQueue:^{
            NSMutableArray *arr_urls = [NSMutableArray array];
            for (NSDictionary * dic in response.hotelRoomDetail.roomTypeImgs) {
                NSString * url = [dic objectForKey:@"imgPath"];
                NSNumber *img_width = [dic objectForKey:@"width"];
                NSNumber *img_height = [dic objectForKey:@"height"];
                if (url) {
                    WaterfallPictureModel *model = [WaterfallPictureModel new];
                    model.isrc = url;
                    model.iwd = img_width.floatValue > SCREEN_WIDTH  ? [NSNumber numberWithFloat:SCREEN_WIDTH] : img_width ;
                    model.iht = img_width.floatValue > SCREEN_WIDTH?[NSNumber numberWithFloat: SCREEN_WIDTH *img_height.floatValue / img_width.floatValue]:img_height;
                    [arr_urls addObject:model];
                }
            }
              NSArray *temp = [NSArray arrayWithArray:arr_urls];
            //本地保存
            // 获取数据
            [GCDQueue executeInMainQueue:^{
                NSMutableArray *indexPaths = [NSMutableArray array];
                for (int i = 0; i < temp.count; i++) {
                    [_dataSource addObject:temp[i]];
                    [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
                }
                [_collectionView insertItemsAtIndexPaths:indexPaths];
            }];
        }];
            [self updateBottomBtn];
        }else{
            
        }
    }];
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"点击了 %@", _dataSource[indexPath.row]);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [_dataSource count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WaterfallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.data           = _dataSource[indexPath.row];
    [cell loadContent];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
        
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:headerIdentifier
                                                                 forIndexPath:indexPath];
        
    } else if ([kind isEqualToString:CHTCollectionElementKindSectionFooter]) {
        
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                          withReuseIdentifier:footerIdentifier
                                                                 forIndexPath:indexPath];
    }
    
    return reusableView;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    WaterfallPictureModel *pictureModel = _dataSource[indexPath.row];
    return CGSizeMake(pictureModel.iwd.floatValue, pictureModel.iht.floatValue);
}

#pragma mark -- Btn Action

-(void)orderNow:(UIButton *)sender{
    NSString *checkinTime;
    NSString *checkoutTime;
    if ([self isBetweenFromHour:0 toHour:6]) {
        checkinTime = [[NSDate dateYesterday] dateWithFormat:@"yyyy-MM-dd"] ;
        checkoutTime = [[NSDate date]  dateWithFormat:@"yyyy-MM-dd"];
    }else{
        checkinTime = [[NSDate date] dateWithFormat:@"yyyy-MM-dd"] ;
        checkoutTime = [[NSDate dateTomorrow]  dateWithFormat:@"yyyy-MM-dd"];
    }
    
    [[LYZNetWorkEngine sharedInstance]  getValidRoomAmount:VersionCode devicenum:DeviceNum fromtype:FromType checkInTime:checkinTime checkOutTime:checkoutTime hotelRoomID:self.roomID block:^(int event, id object) {
        NSLog(@"%d",event);
        if (event == 1) {
            GetValidRoomAmountResponse *response = (GetValidRoomAmountResponse *)object;
            NSDictionary *count = response.roomCout;
            NSNumber *roomsize = [count objectForKey:@"validRoomSize"];
            if ( roomsize.intValue > 0) {
                [GCDQueue executeInMainQueue:^{
                    LYZOrderCommitViewController *vc = [[LYZOrderCommitViewController alloc] init];
                    vc.checkInDate =  [NSDate date];
                    vc.checkOutDate =  [[NSDate date] dateByAddingDays:1];
                    vc.roomTypeID = self.roomModel.roomTypeID;
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                }];
            }else{
//                [GCDQueue executeInMainQueue:^{
//                    YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:object delegate:self buttonTitles:@"知道了",nil];
//                    [alert Show];
//                }];
            }
        }else if (event == 100){
            
            GetValidRoomAmountResponse *response = (GetValidRoomAmountResponse *)object;
            YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:response.msg delegate:self buttonTitles:@"知道了",nil];
            [alert Show];
        }else if (event == 102){
          
//            dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
//            dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//                [self.navigationController popViewControllerAnimated:YES];
//            });
        }else{
            YQAlertView *alert = [[YQAlertView alloc] initWithTitle:@"" message:object delegate:self buttonTitles:@"知道了",nil];
            [alert Show];
           
        }
    }];
    
}

- (void)alertView:(YQAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        [self.navigationController popViewControllerAnimated:YES];

    }
}

#pragma mark - Private

/**
 * @brief 判断当前时间是否在fromHour和toHour之间。如，fromHour=8，toHour=23时，即为判断当前时间是否在8:00-23:00之间
 */
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour {
    
    NSDate *dateFrom = [self getCustomDateWithHour:fromHour];
    NSDate *dateTo = [self getCustomDateWithHour:toHour];
    
    NSDate *currentDate = [NSDate date];
    if ([currentDate compare:dateFrom]==NSOrderedDescending && [currentDate compare:dateTo]==NSOrderedAscending) {
        // 当前时间在9点和10点之间
        return YES;
    }
    return NO;
}

/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour {
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    return [resultCalendar dateFromComponents:resultComps];
}

-(void)dealloc{
    LYLog(@"dealloc");
}

@end
