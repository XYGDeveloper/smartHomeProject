//
//  GetHotelRoomTypeListRequest.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/6/6.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IRequest.h"

@interface GetHotelRoomTypeListRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property (nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *hotelID;

@property (nonatomic, copy) NSString *checkInDate;

@property (nonatomic, copy) NSString *checkOutDate;

@end
