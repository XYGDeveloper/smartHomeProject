//
//  LYZHotelRoomTypeCell.m
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/5.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "LYZHotelRoomTypeCell.h"
#import "CardLayOut.h"
#import "LYZHotelBannerCollectionViewCell.h"
#import "LYZHotelDetailModel.h"
#import "LYZHotelViewController.h"
#import "UIAlertView+Block.h"

@interface LYZHotelRoomTypeCell  ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (nonatomic, strong)NSArray <HotelRoomsModel *>*hotelRooms;

@property (strong, nonatomic) NSIndexPath *currentIndexPath;

@end

#define ItemXScale  0.84
#define ItemYscale  0.9
#define CellHeightScale 0.29


@implementation LYZHotelRoomTypeCell

- (void)setupCell {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)buildSubview {
    [self addSubview:self.collectionView];
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        CardLayOut *layout = [CardLayOut new];
        layout.scale = 1.0;
        layout.spacing = 10;
//        float autoSizeScaleX;
//        float autoSizeScaleY;
//        if (SCREEN_HEIGHT >480) {
//            autoSizeScaleX = SCREEN_WIDTH/320;
//            autoSizeScaleY = SCREEN_HEIGHT/568;
//        } else {
//            autoSizeScaleX = 1.0;
//            autoSizeScaleY = 1.0;
//        }
        layout.itemSize = CGSizeMake(ItemXScale * SCREEN_WIDTH,CellHeightScale * SCREEN_HEIGHT * ItemYscale );
        layout.edgeInset = UIEdgeInsetsMake(CellHeightScale * SCREEN_HEIGHT * (1-ItemYscale) * 0.5, SCREEN_WIDTH * (1 - ItemXScale) * 0.5, CellHeightScale * SCREEN_HEIGHT *(1-ItemYscale) * 0.5,SCREEN_WIDTH * (1 - ItemXScale) * 0.5);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, [[self class] cellHeightWithData]) collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = LYZTheme_BackGroundColor;
        [_collectionView registerClass:[LYZHotelBannerCollectionViewCell class] forCellWithReuseIdentifier:@"CellID"];
    }
    return _collectionView;
}

- (void)loadContent {
    self.hotelRooms = self.data;
    [self.collectionView reloadData];
}

- (void)selectedEvent {
    
}

#pragma mark - class property.

+(CGFloat)cellHeightWithData{
    return CellHeightScale *SCREEN_HEIGHT;
}

#pragma mark - Btn Actions



#pragma mark -- UICollection Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hotelRooms.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LYZHotelBannerCollectionViewCell *cell =( LYZHotelBannerCollectionViewCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    HotelRoomsModel *model = [self.hotelRooms objectAtIndex:indexPath.row];
    WEAKSELF;
    cell.orderRoom = ^(){
        LYLog(@"order Now");
        LYZHotelViewController *vc = (LYZHotelViewController *)weakSelf.controller;
        [vc orderRoom:model];
    };
    [cell setHotelRoomsModel:model];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    LYLog(@" click  index %li",indexPath.row);
    HotelRoomsModel *model = [self.hotelRooms objectAtIndex:indexPath.row];
    NSLog(@"%@",model.roomTypeStatus);
    NSString *roomTypeStatus = [model.roomTypeStatus stringValue];
  
    LYZHotelViewController *vc = (LYZHotelViewController *)self.controller;
    if ([vc respondsToSelector:@selector(pushToRoom:)]) {
         [vc pushToRoom:model];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:CGPointMake(scrollView.contentOffset.x+0.5*scrollView.bounds.size.width, 0.5*scrollView.bounds.size.height)];
    if (!indexPath || self.currentIndexPath == indexPath) {
        return;
    }
    self.currentIndexPath = indexPath;
    HotelRoomsModel *model = [self.hotelRooms objectAtIndex:indexPath.row];
    LYZHotelViewController *vc = (LYZHotelViewController *)self.controller;
    if ([vc respondsToSelector:@selector(selectRoomType: index:)]) {
        [vc selectRoomType:model index:self.currentIndexPath.row];
    }

}





@end
