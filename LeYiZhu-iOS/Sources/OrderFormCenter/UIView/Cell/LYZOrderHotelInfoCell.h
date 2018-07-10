//
//  LYZOrderHotelInfoCell.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/24.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "CustomCell.h"

@interface LYZOrderHotelInfoCell : CustomCell

@property (class, nonatomic, readonly) CGFloat cellHeight;

@property (nonatomic, copy) void (^toHotel)();

@end
