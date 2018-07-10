//
//  LYZSearchTableViewCell.h
//  LeYiZhu-iOS
//
//  Created by xyg on 2017/4/19.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchLoadHotelModel;
@interface LYZSearchTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *HotelNameLabel;

@property (nonatomic, strong) UILabel *distanceLabel;

- (void)refreshWithSearchHotelModel:(SearchLoadHotelModel *)hotelModel showDistance:(BOOL)isShow;


@end
