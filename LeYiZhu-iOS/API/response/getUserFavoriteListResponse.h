//
//  getUserFavoriteListResponse.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/9.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "BaseFavoriteListModel.h"

@interface getUserFavoriteListResponse : AbstractResponse

@property (nonatomic ,readonly, strong) BaseFavoriteListModel * baseFavoriteList;

@end
