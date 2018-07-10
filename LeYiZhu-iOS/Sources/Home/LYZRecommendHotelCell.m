//
//  LYZRecommendHotelCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZRecommendHotelCell.h"
#import "CardLayOut.h"
#import "RecommendsModel.h"
#import "LYZRecommedCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "LYZIndexController.h"
#import "NewPagedFlowView.h"
#import "PGIndexBannerSubiew.h"


@interface LYZRecommendHotelCell  ()<UICollectionViewDelegate,UICollectionViewDataSource,NewPagedFlowViewDelegate, NewPagedFlowViewDataSource>

@property (nonatomic, strong) NSArray <RecommendsModel *>*collectionData;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *hotelNameLabel;
@property (nonatomic, strong) UILabel *introductionLabel;
@property (assign, nonatomic) NSInteger currentIndexPath;

/**
 *  轮播图
 */
@property (nonatomic, strong) NewPagedFlowView *pageFlowView;


@end

static CGFloat _recommedHotelCellHeight = 525.0f;

@implementation LYZRecommendHotelCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = LYZTheme_BackGroundColor;
}


- (void)buildSubview {
    UIView *line = [[UIView alloc]  initWithFrame:CGRectMake( 105, 5, SCREEN_WIDTH - 105 *2, 1)];
    line.backgroundColor = LYZTheme_paleBrown;
    [self addSubview:line];
    
    UIView *round = [[UIView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 8)/2.0, line.y - 3.5  , 8, 8)];
    round.layer.cornerRadius = 4;
    round.backgroundColor = LYZTheme_paleBrown;
    [self addSubview:round];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, line.bottom + 15, SCREEN_WIDTH, 24)];
    titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:20];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"精品酒店推荐";
    [self addSubview:titleLabel];
    
    UIView *IntroductionView = [[UIView alloc] initWithFrame:CGRectMake(41, 142, SCREEN_WIDTH - 41 *2, 370)];
    IntroductionView.layer.borderWidth = 1.0;
    IntroductionView.layer.borderColor = kLineColor.CGColor;
    IntroductionView.backgroundColor = [UIColor whiteColor];
    [self addSubview:IntroductionView];
    
    self.hotelNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,200, IntroductionView.width, 21)];
    self.hotelNameLabel.font = [UIFont fontWithName:LYZTheme_Font_Semibold size:20];
    self.hotelNameLabel.textColor = [UIColor blackColor];
    self.hotelNameLabel.textAlignment = NSTextAlignmentCenter;
    [IntroductionView addSubview:self.hotelNameLabel];
    
    self.introductionLabel = [[UILabel alloc]  initWithFrame:CGRectMake(33, self.hotelNameLabel.bottom + 10, IntroductionView.width  - 33*2, 60)];
    self.introductionLabel.numberOfLines = 0;
    self.introductionLabel.textAlignment = NSTextAlignmentCenter;
    self.introductionLabel.font = [UIFont fontWithName:LYZTheme_Font_Light size:14];
    self.introductionLabel.textColor = LYZTheme_BrownishGreyFontColor;
    [IntroductionView addSubview:self.introductionLabel];
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreBtn.frame = CGRectMake(60, self.introductionLabel.bottom + 20, IntroductionView.width - 60 *2, 33);
    moreBtn.layer.borderWidth = 1.0;
    moreBtn.layer.borderColor = LYZTheme_paleBrown.CGColor;
    [moreBtn setTitle:@"更多详情" forState:UIControlStateNormal];
    [moreBtn setTitleColor:LYZTheme_paleBrown forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont fontWithName:LYZTheme_Font_Regular size:16.0f];
    [moreBtn addTarget:self action:@selector(moreBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [IntroductionView addSubview:moreBtn];
    
    
//    CardLayOut *layout = [CardLayOut new];
//    layout.scale = 1.0;
//    layout.spacing = 40;
//    layout.itemSize = CGSizeMake(SCREEN_WIDTH - 60*2, 253);
//    layout.edgeInset = UIEdgeInsetsMake(0, 60, 0, 60);
//
//    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, titleLabel.bottom + 20, SCREEN_WIDTH, 253) collectionViewLayout:layout];
//    self.collectionView.dataSource = self;
//    self.collectionView.delegate = self;
//    self.collectionView.showsHorizontalScrollIndicator = NO;
//    self.collectionView.showsVerticalScrollIndicator = NO;
//    self.collectionView.backgroundColor = [UIColor clearColor];
//    [self.collectionView registerClass:[LYZRecommedCollectionViewCell class] forCellWithReuseIdentifier:@"CellID"];
//    [self insertSubview:self.collectionView atIndex:101];
    NewPagedFlowView *pageFlowView = [[NewPagedFlowView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
    pageFlowView.backgroundColor = [UIColor clearColor];
    pageFlowView.delegate = self;
    pageFlowView.dataSource = self;
    pageFlowView.minimumPageAlpha = 0.4;
    pageFlowView.minimumPageScale = 0.9;
    pageFlowView.orginPageCount = 3;
    pageFlowView.isOpenAutoScroll = YES;
   
    
    /****************************
     使用导航控制器(UINavigationController)
     如果控制器中不存在UIScrollView或者继承自UIScrollView的UI控件
     请使用UIScrollView作为NewPagedFlowView的容器View,才会显示正常,如下
     *****************************/
    
    UIScrollView *bottomScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, titleLabel.bottom + 20, SCREEN_WIDTH, 260)];
    [pageFlowView reloadData];
    [bottomScrollView addSubview:pageFlowView];
    [self addSubview:bottomScrollView];
    
    [bottomScrollView addSubview:pageFlowView];
    
    self.pageFlowView = pageFlowView;
 
}


- (void)loadContent {
    self.collectionData = (NSArray <RecommendsModel *>*)self.data;
//    [self.collectionView reloadData];
    [self.pageFlowView reloadData];
    if (self.collectionData.count > 0) {
        RecommendsModel *model = self.collectionData[0];
        self.hotelNameLabel.text = model.hotelname;
        self.introductionLabel.text = model.subtitle;
    }
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+ (void)setCellHeight:(CGFloat)cellHeight {
    
    _recommedHotelCellHeight = cellHeight;
}

+ (CGFloat)cellHeight {
    
    return _recommedHotelCellHeight;
}

//#pragma mark -- Collection Delegate
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return self.collectionData.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    LYZRecommedCollectionViewCell *cell =( LYZRecommedCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
//    RecommendsModel *model = [self.collectionData objectAtIndex:indexPath.row];
//    cell.imgURL = model.imgpath;
//    return cell;
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(scrollView.contentOffset.x+0.5*scrollView.bounds.size.width, 0.5*scrollView.bounds.size.height)];
//    if (!indexPath || self.currentIndexPath == indexPath) {
//        return;
//    }
//    self.currentIndexPath = indexPath;
//    RecommendsModel *model = self.collectionData[self.currentIndexPath.row];
//    self.hotelNameLabel.text = model.hotelname;
//    self.introductionLabel.text = model.subtitle;
//
//}
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    LYLog(@" click  index %li",indexPath.row);
//    LYZIndexController *vc = (LYZIndexController *)self.controller;
//    if ([vc respondsToSelector:@selector(moreDetail:)]) {
//        RecommendsModel *model = self.collectionData[indexPath.row];
//        [vc moreDetail:model];
//    }
//    
//}

#pragma mark -- Btn Actions

-(void)moreBtnClick:(id)sender{
    
    LYZIndexController *vc = (LYZIndexController *)self.controller;
    if ([vc respondsToSelector:@selector(moreDetail:)]) {
        RecommendsModel *model = self.collectionData[self.currentIndexPath];
        [vc moreDetail:model];
    }

}

#pragma mark NewPagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(NewPagedFlowView *)flowView {
    CGFloat width = SCREEN_WIDTH - 120 > 250 ? 250 : SCREEN_WIDTH - 120;
    return CGSizeMake(width, width);
}

- (void)didSelectCell:(UIView *)subView withSubViewIndex:(NSInteger)subIndex {
    
    NSLog(@"点击了第%ld张图",(long)subIndex + 1);
        LYZIndexController *vc = (LYZIndexController *)self.controller;
        if ([vc respondsToSelector:@selector(moreDetail:)]) {
            RecommendsModel *model = self.collectionData[subIndex];
            [vc moreDetail:model];
        }
    
}

#pragma mark NewPagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(NewPagedFlowView *)flowView {
    
    return self.collectionData.count;
}

- (UIView *)flowView:(NewPagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    PGIndexBannerSubiew *bannerView = (PGIndexBannerSubiew *)[flowView dequeueReusableCell];
    if (!bannerView) {
        CGFloat width = SCREEN_WIDTH - 120 > 250 ? 250 : SCREEN_WIDTH - 120;
        bannerView = [[PGIndexBannerSubiew alloc] initWithFrame:CGRectMake(0, 1.5,width, width)];
//        bannerView.layer.borderWidth = 0.5f;
//        bannerView.layer.borderColor = LYZTheme_PinkishGeryColor.CGColor;
        bannerView.layer.shadowColor = [UIColor blackColor].CGColor;
        bannerView.layer.shadowOffset = CGSizeMake(0, 0);
        bannerView.layer.shadowOpacity = 0.7;
    }
    
    //在这里下载网络图片
    //
    RecommendsModel *model = [self.collectionData objectAtIndex:index];
    [bannerView.mainImageView sd_setImageWithURL:[NSURL URLWithString:model.imgpath] placeholderImage:nil];
    
    return bannerView;
}

- (void)didScrollToPage:(NSInteger)pageNumber inFlowView:(NewPagedFlowView *)flowView {
    
//    LYLog(@"TestViewController 滚动到了第%ld页",pageNumber);
    RecommendsModel *model = self.collectionData[pageNumber];
    self.currentIndexPath = pageNumber;
    self.hotelNameLabel.text = model.hotelname;
    self.introductionLabel.text = model.subtitle;
}


@end
