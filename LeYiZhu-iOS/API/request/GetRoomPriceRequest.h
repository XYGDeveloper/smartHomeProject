//
//  GetRoomPriceRequest.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IRequest.h"

@interface GetRoomPriceRequest : AbstractRequest

@property (nonatomic, copy) NSString *checkInDate;

@property (nonatomic, copy) NSString *checkOutDate;

@property (nonatomic, copy) NSString *roomTypeID;

@end
