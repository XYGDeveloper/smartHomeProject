//
//  LYZHotelDetailViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/5.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZHotelDetailViewController.h"
#import "CellDataAdapter.h"
#import "CustomCell.h"
#import "LYZHotelIntroductionCell.h"
#import "LYZTagsCell.h"
#import "LYZHotelEquipmentAndNoticeCell.h"
#import "ColorSpaceCell.h"
#import "Masonry.h"
#import "LoginManager.h"
#import "HotelIntroModel.h"
#import "GCD.h"

@interface LYZHotelDetailViewController ()<UITableViewDelegate, UITableViewDataSource,CustomCellDelegate>

@property (nonatomic, strong) NSMutableArray <CellDataAdapter *> *adapters;
@property (nonatomic, strong) UITableView                        *tableView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong)  HotelIntroModel * hotelIntro;

@end

@implementation LYZHotelDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LYZTheme_BackGroundColor;
     [self setUp];
}

-(void)setUp{
     [self createTableViewAndRegisterCells];
    [self getHotelIntroData];
    [self addFloatBtn];
}

-(void)getHotelIntroData{
    NSString *appUserID = [LoginManager instance].appUserID;
    [[LYZNetWorkEngine sharedInstance] getHotelIntro:VersionCode devicenum:DeviceNum fromtype:FromType hotelID:self.hotelID appUserID:appUserID block:^(int event, id object) {
        if (event == 1) {
            GetHotelIntroResponse *response = (GetHotelIntroResponse *)object;
            self.hotelIntro = response.hotelIntro;
            [self createDataSource];
        }else{
        
        }
    }];
}

-(void)addFloatBtn{
    [self.view insertSubview:self.headView atIndex:1001];
}

-(void)createTableViewAndRegisterCells{
    self.tableView                 = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT -64 -40)];
    self.tableView.delegate        = self;
    self.tableView.dataSource      = self;
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.tableHeaderView = self.headView;
    [self.view addSubview:_tableView];
    [LYZHotelIntroductionCell registerToTableView:self.tableView];
    [LYZHotelEquipmentAndNoticeCell registerToTableView:self.tableView];
    [ColorSpaceCell registerToTableView:self.tableView];
    [LYZTagsCell registerToTableView:self.tableView];

}

-(void)createDataSource{
    if (!_adapters) {
        _adapters = [NSMutableArray array];
    }
    if (_adapters.count > 0) {
        [_adapters removeAllObjects];
    }
    [self.adapters addObject:[self lineType:kLongType height:0.5]];
    [self.adapters addObject:[LYZHotelIntroductionCell dataAdapterWithData:self.hotelIntro cellHeight:[LYZHotelIntroductionCell cellHeightWithData:self.hotelIntro.intro]]];
    [self.adapters addObject:[LYZTagsCell dataAdapterWithData:self.hotelIntro]];
    [self.adapters addObject:[self lineType:kLongType height:0.5]];
    NSString *equipmentStr = self.hotelIntro.facility? :@"";
    NSDictionary *equipment = @{@"title":@"酒店设备",@"content":equipmentStr};
    [self.adapters addObject:[LYZHotelEquipmentAndNoticeCell dataAdapterWithData:equipment cellHeight:[LYZHotelEquipmentAndNoticeCell cellHeightWithData:equipment]]];
    [self.adapters addObject:[self lineType:kLongType height:0.5]];
    NSString *noticeStr = self.hotelIntro.checkInInfo ? :@"";
    NSDictionary *notice = @{@"title":@"入住须知",@"content":noticeStr};
    [self.adapters addObject:[LYZHotelEquipmentAndNoticeCell dataAdapterWithData:notice cellHeight:[LYZHotelEquipmentAndNoticeCell cellHeightWithData:notice]]];
    [GCDQueue executeInMainQueue:^{
        [self.tableView reloadData];
    }];
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
        titleLabel.text = @"酒店详情";
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
