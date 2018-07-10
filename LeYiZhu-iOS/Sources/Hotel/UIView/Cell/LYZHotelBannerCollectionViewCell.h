//
//  LYZHotelBannerCollectionViewCell.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/30.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotelRoomsModel;
@interface LYZHotelBannerCollectionViewCell : UICollectionViewCell


@property (nonatomic, copy) void (^orderRoom)();


-(void)setHotelRoomsModel:(HotelRoomsModel *)model;

@end
