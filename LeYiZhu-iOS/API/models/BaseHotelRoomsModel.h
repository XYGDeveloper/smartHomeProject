//
//  BaseHotelRoomsModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/7.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BaseHotelRoomsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, strong) NSArray *roomTypes;

@end
