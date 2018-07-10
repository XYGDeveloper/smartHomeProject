//
//  LYZSearchResultTableViewCell.h
//  LeYiZhu-iOS
//
//  Created by L on 2017/4/20.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SearchLoadHotelModel;

@interface LYZSearchResultTableViewCell : UITableViewCell


@property (nonatomic, strong) UILabel *HotelNameLabel;

- (void)refreshWithSearchGoodsModel:(SearchLoadHotelModel *)resultModel withSearchText:(NSString *)searchText;

@end
