//
//  FriendCell2.h
//  LeYiZhu-iOS
//
//  Created by xyg on 2018/1/24.
//  Copyright © 2018年 乐易住智能科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendCircleImageView.h"
#import "HotelCommentsModel.h"
#import "LTUITools.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "CWStarRateView.h"
#import "LYZImageModel.h"
#import "MJExtension.h"

typedef void (^toThumb)();
@class HotelCommentsModel;

@interface FriendCell2 : UITableViewCell

@property (nonatomic,strong)toThumb thumb;

- (void)cellDataWithModel:(HotelCommentsModel *)model;

@end
