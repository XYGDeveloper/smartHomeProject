//
//  LYZMineViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/31.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZMineViewController.h"
#import "CustomCell.h"
#import "UserInfo.h"
#import "ContentIconCell.h"
#import "ColorSpaceCell.h"
#import "LYZMineHeadCell.h"
#import "LoginManager.h"
#import "ChanagePhoneViewController.h"
#import "MixCellsViewController.h"
#import "MyCollectionViewController.h"
#import "YaoQingController.h"
#import "NormalProblemViewController.h"
#import "LYZOrderCenterViewController.h"
#import "LoginController.h"
#import "SetViewController.h"
#import "ContactViewController.h"
#import "UserInfo.h"
#import "UIImageView+WebCache.h"
#import "LYZPhoneCall.h"
#import "LYZFeedBackViewController.h"
#import "GCD.h"
#import "OderEntranceCell.h"
#import "LYZMineFunctionsCell.h"
#import "AlertView.h"
#import "CouponViewController.h"
#import "VipCardLevelViewController.h"
#import "VipCardMacros.h"
#import "BaseMineInfoModel.h"
#import "VipInfoModel.h"
#import "ApplyVipViewController.h"
#import "LocalMineInfo.h"
#import "UIViewController+BarButton.h"
#import "MyProfileViewController.h"
#import "Public+JGHUD.h"
#import "PointView.h"
#import "PointRecordViewController.h"
#import "LYZCommentViewController.h"
#import <Reachability.h>
#import "GCDQueue.h"
#import "Public+JGHUD.h"
@interface LYZMineViewController ()<UITableViewDelegate, UITableViewDataSource, CustomCellDelegate,UIScrollViewDelegate,BaseMessageViewDelegate>{
     LYZMineHeadCell *_headerCell;
}

@property(nonatomic,strong) UserInfo * userInfo;
@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) BaseMineInfoModel *mineInfo;
@property (nonatomic, strong) Reachability *reach;

@end

@implementation LYZMineViewController

#pragma mark - life cycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
    if ([LoginManager instance].appUserID) {
         [self fetchMineInfos];
    }else{
        self.mineInfo = nil;
        [self createDataSource];
    }
   
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的";
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setRightNavBar];
    [self createTableViewAndRegisterCells];
    [self createDataSource];
    self.reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    self.reach .unreachableBlock = ^(Reachability * reachability){
        [GCDQueue executeInMainQueue:^{
            [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
        }];
    };
   
    [self.reach  startNotifier];
}

#pragma mark - UI Config

- (void)createTableViewAndRegisterCells {
    
//    self.tableView                 = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -64)];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = self.footView;
    [self.view addSubview:_tableView];
    
    if (@available(iOS 11.0, *)){
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [LYZMineHeadCell registerToTableView:self.tableView];
    [ColorSpaceCell  registerToTableView:self.tableView];
    [OderEntranceCell registerToTableView:self.tableView];
    [LYZMineFunctionsCell registerToTableView:self.tableView];
}

-(void)setRightNavBar{
    
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    rightButton.bounds = CGRectMake(0, 0, 60, 30);
//    UIImage * image = [[UIImage imageNamed:@"me_icon_set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    [rightButton setImage:image forState:UIControlStateNormal];
//
//    [rightButton addTarget:self action:@selector(toSettings:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//    UIBarButtonItem *spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//    spaceItem.width = - 20;
//    self.navigationItem.rightBarButtonItems = @[spaceItem,rightItem];
    
     UIImage * image = [[UIImage imageNamed:@"me_icon_set"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self addRightBarButtonWithFirstImage:image action:@selector(toSettings:)];
}

-(UIView *)footView{
    if (!_footView) {
        
        CGFloat height;
        if (SCREEN_HEIGHT  < 667 ) {
            height = 667;
        }else{
            height = SCREEN_HEIGHT;
        }
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height - LYZMineHeadCell.cellHeight - OderEntranceCell.cellHeight - LYZMineFunctionsCell.cellHeight - 64)];
        
    
        _footView.backgroundColor = [UIColor whiteColor];
       
       
        UILabel *serviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 292, 65)];
        serviceLabel.center = _footView.center;
        serviceLabel.textAlignment = NSTextAlignmentCenter;
        serviceLabel.numberOfLines = 0;
        NSString *title = @"7×24小时客服";
        NSString *phone = CustomerServiceNum;
        
        NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",title,phone]];
//       NSDictionary *attriBute1 = @{NSForegroundColorAttributeName:LYZTheme_BrownishGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:15]};
        NSDictionary *attriBute1 = [NSDictionary dictionaryWithObjectsAndKeys:LYZTheme_BrownishGreyFontColor,NSForegroundColorAttributeName, [UIFont fontWithName:LYZTheme_Font_Regular size:15],NSFontAttributeName,nil];
        [attriStr addAttributes:attriBute1 range:NSMakeRange(0, title.length)];
        NSDictionary *attriBute2 = @{NSForegroundColorAttributeName:LYZTheme_warmGreyFontColor,NSFontAttributeName:[UIFont fontWithName:LYZTheme_Font_Regular size:13]};
        [attriStr addAttributes:attriBute2 range:NSMakeRange(title.length + 1, phone.length)];
        serviceLabel.attributedText = attriStr;
        
        //加虚线
        CAShapeLayer *border = [CAShapeLayer layer];
        border.strokeColor = LYZTheme_warmGreyFontColor.CGColor;
        border.fillColor = nil;
        border.path = [UIBezierPath bezierPathWithRect:serviceLabel.bounds].CGPath;
        border.frame = serviceLabel.bounds;
        border.lineWidth = 1.f;
//        border.lineCap = @"square";
        border.lineCap = @"butt";
        border.lineDashPattern = @[@5, @3];
        [serviceLabel.layer addSublayer:border];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = serviceLabel.frame;
        [btn addTarget:self action:@selector(phoneCall:) forControlEvents:UIControlEventTouchUpInside];
        [_footView addSubview:btn];
        
        [_footView addSubview:serviceLabel];
        
    }
    return _footView;
}


#pragma mark - DataSource Config

-(void)fetchMineInfos{
    [[LYZNetWorkEngine sharedInstance] getMineInfoBlock:^(int event, id object) {
        if (event == 1) {
            MineInfoResponse *response = (MineInfoResponse *)object;
//            self.mineInfo = [LocalMineInfo initWithNetworkMineinfo:response.baseMineInfo];
            self.mineInfo = response.baseMineInfo;
            [self createDataSource];
        }else{
             LYLog(@"error --- >  Request Failed");
//             [self createDataSource];
        }
    }];
//      [self createDataSource];
}

- (void)createDataSource {
    if (!self.adapters) {
        self.adapters = [NSMutableArray array];
    }
    if (self.adapters.count) {
        [self.adapters removeAllObjects];
    }
    [self.adapters addObject:[LYZMineHeadCell dataAdapterWithData:self.mineInfo cellHeight:LYZMineHeadCell.cellHeight]];
    NSNumber *unpay = self.mineInfo.todopaycount.integerValue ?self.mineInfo.todopaycount: @0;
    NSNumber *uncheckin = self.mineInfo.todocheckincount.integerValue ?self.mineInfo.todocheckincount : @0;
    NSDictionary *dic = @{@"unpay":unpay ,@"uncheckin":uncheckin};
    [self.adapters addObject:[OderEntranceCell dataAdapterWithData:dic cellHeight:OderEntranceCell.cellHeight]];
    NSString *points;
    NSString *couponCount;
    NSString *myCollectionCount;
    NSString *contacts;
    if (self.mineInfo.points.integerValue && ![self.mineInfo.points isKindOfClass:[NSNull class]]) {
        points = [NSString stringWithFormat:@"%@分",self.mineInfo.points];
    }else{
        points = @"积分换奖励哟";
    }
    if (self.mineInfo.couponcount.integerValue && ![self.mineInfo.couponcount isKindOfClass:[NSNull class]]) {
        couponCount = [NSString stringWithFormat:@"%@张",self.mineInfo.couponcount];
    }else{
        couponCount = @"关注活动送优惠券哦";
    }
    if (self.mineInfo.favoritecount.integerValue && ![self.mineInfo.favoritecount isKindOfClass:[NSNull class]]) {
        myCollectionCount = [NSString stringWithFormat:@"%@间",self.mineInfo.favoritecount];
    }else{
        myCollectionCount = @"快去收藏吧";
    }
    
    if (self.mineInfo.contactsSize.integerValue && ![self.mineInfo.contactsSize isKindOfClass:[NSNull class]]) {
        contacts = [NSString stringWithFormat:@"%@人",self.mineInfo.contactsSize];
    }else{
        contacts = @"助您快速下单";
    }
    NSArray *functions = @[@{@"icon":@"icon_integral",@"title":@"积分",@"subTitle":points},@{@"icon":@"me_icon_ticket",@"title":@"券包",@"subTitle":couponCount},@{@"icon":@"me_icon_collect",@"title":@"收藏",@"subTitle":myCollectionCount},@{@"icon":@"me_icon_invite",@"title":@"邀请好友",@"subTitle":@"获取住房金"},@{@"icon":@"mine_icon_people",@"title":@"常用入住人",@"subTitle":contacts},@{@"icon":@"me_icon_problem",@"title":@"常见问题",@"subTitle":@"快速解决99%问题"}];
    
    [self.adapters addObject:[LYZMineFunctionsCell dataAdapterWithData:functions cellHeight:LYZMineFunctionsCell.cellHeight]];
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
    if (_headerCell == nil && [cell isKindOfClass:[LYZMineHeadCell class]]) {
        _headerCell = (LYZMineHeadCell *)cell;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _adapters[indexPath.row].cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [(CustomCell *)[tableView cellForRowAtIndexPath:indexPath] selectedEvent];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [_headerCell offsetY:scrollView.contentOffset.y];
    if (scrollView.contentOffset.y > 160 -64 ) {
         [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:LYZTheme_NavTab_Color] forBarMetrics:UIBarMetricsDefault];
    }else{
         [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    }
}
#pragma mark - Btn Actions
-(void)phoneCall:(UIButton *)sender{
      [LYZPhoneCall noAlertCallPhoneStr:CustomerServiceNum withVC:self];
}

-(void)toSettings:(UIButton *)sender{
    LYLog(@"settings ");
    SetViewController *set = [SetViewController new];
    set.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:set animated:YES];
  
}

#pragma mark - Cells Actions

-(void)userSign{
    if (self.reach.currentReachabilityStatus == NotReachable) {
        [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
    }else{
        [[LYZNetWorkEngine sharedInstance] userSignblock:^(int event, id object) {
            if (event == 1) {
                //签到成功
                UserSignResponse *response = (UserSignResponse *)object;
                NSString *point = [NSString stringWithFormat:@"积分 +%@",[((NSDictionary *)response.result) objectForKey:@"points"]] ;
                PointViewMessageObject *messageObject = MakePointViewObject(@"iconIntegral",point , @"签到成功");
                [PointView showAutoHiddenMessageViewInKeyWindowWithMessageObject:messageObject];
                LYLog(@"sign success!!!");
                //            [Public showJGHUDWhenSuccess:self.view msg:@"签到成功"];
                [self fetchMineInfos];
            }else{
                LYLog(@"sign failed!!!");
                [Public showJGHUDWhenError:self.view msg:object];
            }
        }];
    }
}

-(void)toLogin{
    [[LoginManager instance] userLogin];
}

-(void)toVipLevel{
    VipCardLevelViewController *vc = [[VipCardLevelViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.currentVipType = [self vipTypeWithVipName:self.mineInfo.vipinfo.vipcode];
    vc.currentGrowingValue = self.mineInfo.vipinfo.exp;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)vipPrivilege{
    VipCardLevelViewController *vc = [[VipCardLevelViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)joinVip{
    LYLog(@"Join Vip");
    //先留着
    ApplyVipViewController *vc = [ApplyVipViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
 
}

-(void)headBtnClick{
    if (self.reach.currentReachabilityStatus == NotReachable) {
        [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
    }else{
        MyProfileViewController *vc = [[MyProfileViewController alloc] init];
        vc.facePath = self.mineInfo.facepath;
        vc.phone = self.mineInfo.phone;
        vc.nickName = self.mineInfo.username;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(void)didSelectedFunctionItemAtIndex:(NSInteger)index{
    if (index == 0) {
        //积分
        if (self.reach.currentReachabilityStatus == NotReachable) {
            [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
        }else{
            if ([LoginManager instance].isLogin) {
                PointRecordViewController *vc = [[PointRecordViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                vc.totalPoint = self.mineInfo.points;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [[LoginManager instance] userLogin:^{
                    PointRecordViewController *vc = [[PointRecordViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    vc.totalPoint = self.mineInfo.points;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
        }
       
    }else if (index == 1){
        if (self.reach.currentReachabilityStatus == NotReachable) {
            [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
        }else{
            //券包
            if ([LoginManager instance].isLogin) {
                CouponViewController *vc = [[CouponViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [[LoginManager instance] userLogin:^{
                    CouponViewController *vc = [[CouponViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
        }
    
    }else if (index == 2){
        if (self.reach.currentReachabilityStatus == NotReachable) {
            [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
        }else{
            //收藏
            if ([LoginManager instance].isLogin) {
                MyCollectionViewController * vc = [[MyCollectionViewController alloc] init];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [[LoginManager instance] userLogin:^{
                    MyCollectionViewController * vc = [[MyCollectionViewController alloc] init];
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
        }
    
    }else if (index == 3){
        if (self.reach.currentReachabilityStatus == NotReachable) {
            [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
        }else{
            //邀请好友
            YaoQingController *vc = [[YaoQingController alloc]init];
            vc.inviteCode = self.mineInfo.invitecode;
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
   
    }else if (index == 4){
        if (self.reach.currentReachabilityStatus == NotReachable) {
            [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
        }else{
            //常用入住人
            if ([LoginManager instance].isLogin) {
                ContactViewController *vc = [[ContactViewController alloc] init];
                vc.title = @"常用入住人";
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }else{
                [[LoginManager instance] userLogin:^{
                    ContactViewController *vc = [[ContactViewController alloc] init];
                    vc.title = @"常用入住人";
                    vc.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:vc animated:YES];
                }];
            }
        }
      
    }else if (index == 5){
        if (self.reach.currentReachabilityStatus == NotReachable) {
            [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
        }else{
            //常见问题
            NormalProblemViewController *vc = [[NormalProblemViewController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

-(void)didSelectedOrderTypeItemAtIndex:(NSInteger)index{
    if (self.reach.currentReachabilityStatus == NotReachable) {
        [Public showMessageWithHUD:[UIApplication sharedApplication].keyWindow message:@"当前网络没有连接，请检查网络"];
    }else{
        if ([LoginManager instance].isLogin) {
            [self toOrderCenterIndex:index];
        }else{
            [[LoginManager instance] userLogin:^{
                [self toOrderCenterIndex:index];
            }];
        }
    }
}

-(void)toOrderCenterIndex:(NSInteger)index{
    LYZOrderCenterViewController *vc = [LYZOrderCenterViewController new];
    orderStatus status;
    NSString *title;
    if (index == 0) {
        //全部订单
        status = allOrderStatus;
        title = @"全部订单";
    }else if (index == 1){
        //待支付
        status = waitingPayStatus;
        title = @"待支付订单";
    }else if (index == 2){
        //待入住
        status = payAlreadyStatus;
        title = @"待入住订单";
    }else{
        //已入住
        status = checkInStatus;
        title = @"已入住订单";
    }
    vc.status = status;
    vc.orderTitle = title;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - BaseMessageAlert Delegate

- (void)baseMessageView:(__kindof BaseMessageView *)messageView event:(id)event {
    
    if (messageView.tag == 100) {
        if ([event isEqualToString:@"知道了"]) {
           
        }
    }
    [messageView hide];
}

#pragma mark - Private

-(vipType)vipTypeWithVipName:(NSString *)vipCode{
    vipType type;
    vipCode = vipCode.uppercaseString;
    if ([vipCode isEqualToString:@"E"]) {
        type = eCardType;
    }else if ([vipCode isEqualToString:@"S"]){
        type = silverType;
    }else if ([vipCode isEqualToString:@"G"]){
        type = goldType;
    }else if ([vipCode isEqualToString:@"D"]){
        type = diamondType;
    }else{
        type = GuestType;
    }
    return type;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
