//
//  GetRoomPriceResponse.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AbstractResponse.h"

@class RoomPriceInfo;
@interface GetRoomPriceResponse : AbstractResponse

@property (nonatomic ,readonly, strong) RoomPriceInfo * roomPriceInfo;

@end
