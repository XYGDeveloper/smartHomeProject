//
//  GetHotelRoomTypeListResponse.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AbstractResponse.h"
#import "BaseHotelRoomsModel.h"

@interface GetHotelRoomTypeListResponse : AbstractResponse

@property (nonatomic, readonly, strong) BaseHotelRoomsModel *baseHotelRooms;

@end
