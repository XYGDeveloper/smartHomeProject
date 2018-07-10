//
//  VipCardLevelViewController.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/8.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "VipCardLevelViewController.h"
#import "LCVerticalBadgeBtn.h"
#import "UIView+SetRect.h"
#import "CardLayOut.h"
#import "VipCollectionViewCell.h"
#import "LocalVipModel.h"
#import "BaseVipLevelModel.h"
#import "VipLevelModel.h"
#import "LYZWKWebViewController.h"


@interface VipCardLevelViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) LCVerticalBadgeBtn *btn_1;
@property (nonatomic, strong) LCVerticalBadgeBtn *btn_2;
@property (nonatomic, strong) LCVerticalBadgeBtn *btn_3;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl* control;
@property (nonatomic, strong) UILabel *privilegeLabel;
@property (nonatomic, strong) UIView *line1;
@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) NSArray *collectionData;
@property (strong, nonatomic) NSIndexPath *currentIndexPath;
@property (nonatomic, strong) NSArray *allVipsPrivilegeImgs;

@property (nonatomic, strong) NSArray *allVipsPrivilege;


@end

@implementation VipCardLevelViewController

#pragma mark - life cycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.translucent = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
//    [self.headImgView removeFromSuperview];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *title;
    if (self.currentGrowingValue) {
        switch (self.currentVipType) {
            case eCardType:
                title = @"E卡会员";
                break;
            case silverType:
                title = @"银卡会员";
                break;
            case goldType:
                title = @"黄卡会员";
                break;
            case diamondType:
                title = @"钻石会员";
                break;
            default:
                break;
        }

    }else{
        title = @"会员特权";
    }
        self.title =title;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor =LYZTheme_BackGroundColor;
    [self createAllVipDatas];
    [self createBackGoundView];
//    [self createBanar];
    [self createBottomBtn];
    [self getVipLevelList];
//    [self createDefaultDataSource];
}

#pragma mark - UI Config

-(void)createBackGoundView{
    UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 190)];
    headImgView.image =  [UIImage imageNamed:@"mine_nav_bar"];
    headImgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:headImgView];
    
    float autoSizeScaleX;
    float autoSizeScaleY;
    if (SCREEN_HEIGHT >667) {
        autoSizeScaleX = SCREEN_WIDTH/375;
        autoSizeScaleY = SCREEN_HEIGHT/667;
    } else {
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }
    UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, headImgView.bottom, SCREEN_WIDTH, 320 * autoSizeScaleY)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    
    CardLayOut *layout = [CardLayOut new];
    layout.scale = 1.0;
    layout.spacing = 35;
    layout.itemSize = CGSizeMake(315 * autoSizeScaleX , 185 * autoSizeScaleY);
    layout.edgeInset = UIEdgeInsetsMake(10, (SCREEN_WIDTH - 315 * autoSizeScaleX )/2.0,10 ,(SCREEN_WIDTH -  185 * autoSizeScaleY)/2.0);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, - 185 * autoSizeScaleY /2.0 , SCREEN_WIDTH, 185 * autoSizeScaleY + 20) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[VipCollectionViewCell class] forCellWithReuseIdentifier:@"CellID"];
    [whiteView addSubview:_collectionView];
    
    self.control = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, _collectionView.bottom  + 15, 20)];
    self.control.y = _collectionView.bottom + 10;
    self.control.centerX = self.view.centerX;
    self.control.pageIndicatorTintColor = [UIColor colorWithRed:234./255. green:234./255. blue:234./255. alpha:1.];
    //    self.control.currentPageIndicatorTintColor = [UIColor colorWithRed:125./255. green:153./255. blue:255./255. alpha:1.];
    self.control.currentPageIndicatorTintColor = LYZTheme_paleBrown;
    [whiteView addSubview:self.control];
    
    self.privilegeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
     self.privilegeLabel.textColor = LYZTheme_BrownishGreyFontColor;
     self.privilegeLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16];
     self.privilegeLabel.text = @"专属福利";
    [ self.privilegeLabel sizeToFit];
     self.privilegeLabel.centerX = whiteView.centerX;
     self.privilegeLabel.y = self.control.bottom + 10;
    [whiteView addSubview: self.privilegeLabel];
    
    
   
//    UIColor *colorOne =RGB(199, 199, 199);
//    UIColor *colorTwo = RGB(144, 144, 144);
//    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil, nil];
//    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
//    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
//    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo,  nil];
    
    self.line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 65, 2)];
    self.line1.layer.cornerRadius = 1.0f;
    self.line1.centerY =  self.privilegeLabel.centerY;
    self.line1.right =  self.privilegeLabel.x - 9;
    [whiteView addSubview:self.line1];
    
    self.line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 65, 2)];
    self.line2.layer.cornerRadius = 1.0f;
     self.line2.centerY =  self.privilegeLabel.centerY;
     self.line2.x =  self.privilegeLabel.right + 9;
    [whiteView addSubview: self.line2];
    
    self.btn_1 = [LCVerticalBadgeBtn buttonWithType:UIButtonTypeCustom];
    self.btn_1.frame = CGRectMake(0,  self.privilegeLabel.bottom + 40, SCREEN_WIDTH/3.0, 80);
    self.btn_1.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    [self.btn_1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn_1.img_title_space = 10;
    [whiteView addSubview:self.btn_1];
    
    self.btn_2 = [LCVerticalBadgeBtn buttonWithType:UIButtonTypeCustom];
    self.btn_2.frame = CGRectMake(self.btn_1.right, self.btn_1.y, SCREEN_WIDTH/3.0, 80);
    self.btn_2.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    [self.btn_2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn_2.img_title_space = 10;
    [whiteView addSubview:self.btn_2];
    
    self.btn_3 = [LCVerticalBadgeBtn buttonWithType:UIButtonTypeCustom];
    self.btn_3.frame = CGRectMake(self.btn_2.right, self.btn_1.y, SCREEN_WIDTH/3.0,80);
    self.btn_3.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    [self.btn_3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.btn_3.img_title_space = 10;
    [whiteView addSubview:self.btn_3];
}

-(void)createBanar{
    CardLayOut *layout = [CardLayOut new];
    layout.scale = 1.0;
    layout.spacing = 35;
    float autoSizeScaleX;
    float autoSizeScaleY;
    if (SCREEN_HEIGHT >667) {
        autoSizeScaleX = SCREEN_WIDTH/375;
        autoSizeScaleY = SCREEN_HEIGHT/667;
    } else {
        autoSizeScaleX = 1.0;
        autoSizeScaleY = 1.0;
    }
//    CGFloat scale = 1.1;
//    CGFloat itemWidth ;
//    CGFloat itemHeight;
//    if (iPhone6_6sPlus) {
//        itemWidth = 315 * scale;
//        itemHeight = 185*scale;
//      
//    }else {
//        itemWidth = 315;
//        itemHeight = 185;
//    }
    layout.itemSize = CGSizeMake(315 * autoSizeScaleX , 185 * autoSizeScaleY);
    layout.edgeInset = UIEdgeInsetsMake(10, (SCREEN_WIDTH - 315 * autoSizeScaleX )/2.0,10 ,(SCREEN_WIDTH -  185 * autoSizeScaleY)/2.0);
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 88, SCREEN_WIDTH, 185 * autoSizeScaleY + 20) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[VipCollectionViewCell class] forCellWithReuseIdentifier:@"CellID"];
    [self.view addSubview:_collectionView];
    
    self.control = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 170, 20)];
    self.control.y = _collectionView.bottom + 5;
    self.control.centerX = self.view.centerX;
    self.control.pageIndicatorTintColor = [UIColor colorWithRed:234./255. green:234./255. blue:234./255. alpha:1.];
//    self.control.currentPageIndicatorTintColor = [UIColor colorWithRed:125./255. green:153./255. blue:255./255. alpha:1.];
    self.control.currentPageIndicatorTintColor = LYZTheme_paleBrown;
    [self.view addSubview:self.control];

}

-(void)createBottomBtn{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.font = [UIFont fontWithName:LYZTheme_Font_Regular size:14];
    label.textColor = LYZTheme_warmGreyFontColor;
    label.text = @"会员规则";
    [label sizeToFit];
    label.centerX = self.view.centerX;
    label.x -=  9;
    label.bottom = SCREEN_HEIGHT - 20;
    [self.view addSubview:label];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
    imgView.image = [UIImage imageNamed:@"icon_vip_problem"];
    imgView.x = label.right + 4;
    imgView.centerY = label.centerY;
    [self.view addSubview:imgView];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT - 54, SCREEN_WIDTH, 54);
    [btn addTarget:self action:@selector(vipRules:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - Config Data

-(void)getVipLevelList{
    
//     [self createDefaultDataSource];
    
    
    [[LYZNetWorkEngine sharedInstance] getVipLevelList:^(int event, id object) {
        if (event == 1) {
            GetVIPLevelListResponse *response = (GetVIPLevelListResponse *)object;
            self.allVipsPrivilege = response.baseVipLevel.viplevels;
            [self createDefaultDataSource];
        }else{
        
        }
    }];
}

-(void)createAllVipDatas{
    NSDictionary *eCardVip = @{@"privilegeImg":@[@"e_icon_discount",@"e_icon_time",@"e_icon_integral"],@"cardImg":@"e_bg"};
    NSDictionary *silverCardVip = @{@"privilegeImg":@[@"silver_icon_discount",@"silver_icon_time",@"silver_icon_integral"],@"cardImg":@"silver_bg"};
    NSDictionary *goldCardVip = @{@"privilegeImg":@[@"gold_icon_discount",@"gold_icon_time",@"gold_icon_integral"],@"cardImg":@"gold_bg"};
    NSDictionary *masonryCardVip = @{@"privilegeImg":@[@"masonry_icon_discount",@"masonry_icon_time",@"masonry_icon_integral"],@"cardImg":@"masonry_bg"};
    self.allVipsPrivilegeImgs = @[eCardVip,silverCardVip,goldCardVip,masonryCardVip];
}

-(void)createDefaultDataSource{
    int count = (int)self.currentVipType;
    NSMutableArray *temp = [NSMutableArray array];
    if (!self.currentGrowingValue) {
        for (int i = 0; i < self.allVipsPrivilegeImgs.count ; i++) {
            LocalVipModel *model = [[LocalVipModel alloc] init];
            model.vipType = (vipType) i;
            VipLevelModel *vipLevelModel = self.allVipsPrivilege[i];
            model.targetGrowingValue = vipLevelModel.exp;
            model.imageName = [self.allVipsPrivilegeImgs[i] objectForKey:@"cardImg"];
            [temp addObject:model];
        }
    }else{
        for (int i = count; i < self.allVipsPrivilegeImgs.count ; i++) {
            LocalVipModel *model = [[LocalVipModel alloc] init];
            model.vipType = (vipType) i;
            model.currentVip = self.currentVipType;
            VipLevelModel *vipLevelModel = self.allVipsPrivilege[i];
            model.growingValue = self.currentGrowingValue;
            model.targetGrowingValue = vipLevelModel.exp;
            model.imageName = [self.allVipsPrivilegeImgs[i] objectForKey:@"cardImg"];
            [temp addObject:model];
        }
       
    }
    
    self.collectionData =[NSArray arrayWithArray:temp];
    self.control.numberOfPages = self.collectionData.count;
    [self.collectionView reloadData];
    [self setPrivilegeBtns:self.currentVipType];
   
}

-(void)setPrivilegeBtns:(vipType)type{
    if (type == GuestType) {
        return;
    }
    int index = (int)type;
    NSDictionary *dic = self.allVipsPrivilegeImgs[index];
    VipLevelModel *vipLevelModel = self.allVipsPrivilege[index];
    NSArray *imgs = dic[@"privilegeImg"];
    [_btn_1 setImage:[UIImage imageNamed:imgs[0]] forState:UIControlStateNormal];
    [_btn_2 setImage:[UIImage imageNamed:imgs[1]] forState:UIControlStateNormal];
    [_btn_3 setImage:[UIImage imageNamed:imgs[2]] forState:UIControlStateNormal];
    [_btn_1 setTitle:vipLevelModel.discountrule forState:UIControlStateNormal];
    [_btn_2 setTitle:vipLevelModel.checkouttimerule forState:UIControlStateNormal];
    [_btn_3 setTitle:vipLevelModel.pointsrule forState:UIControlStateNormal];
    UIColor *privilegeLabelColor;
    switch (type) {
        case eCardType:
            privilegeLabelColor = LYZTheme_BrownishGreyFontColor;
            break;
        case silverType:
            privilegeLabelColor = RGB(159, 166, 180);
            break;
        case goldType:
            privilegeLabelColor = RGB(187, 135, 82);
            break;
        case diamondType:
            privilegeLabelColor = [UIColor blackColor];
            break;
        default:
            break;
    }
    self.privilegeLabel.textColor = privilegeLabelColor;
    self.line1.backgroundColor = privilegeLabelColor;
    self.line2.backgroundColor = privilegeLabelColor;
}


#pragma mark - UICollection Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.collectionData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VipCollectionViewCell *cell =( VipCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [cell setVipModel:self.collectionData[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LYLog(@" click  index %li",indexPath.row);
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(scrollView.contentOffset.x+0.5*scrollView.bounds.size.width, 0.5*scrollView.bounds.size.height)];
    if (!indexPath || self.currentIndexPath == indexPath) {
        return;
    }
    self.currentIndexPath = indexPath;
    self.control.currentPage = indexPath.row;
    LocalVipModel *model = self.collectionData[indexPath.row];
    [self setPrivilegeBtns:model.vipType];
}

#pragma mark - Btn Actions

-(void)vipRules:(UIButton *)sender{
    LYZWKWebViewController *vc = [[LYZWKWebViewController alloc] init];
    vc.strURL = Vipregulations;
    vc.title = @"会员规则";
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    LYLog(@"dealloc");
}


@end
