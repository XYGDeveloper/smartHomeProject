//
//  GetValidRoomAmountRequest.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/2/25.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface GetValidRoomAmountRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property (nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *checkInDate;

@property (nonatomic, copy) NSString *checkOutDate;

@property (nonatomic, copy) NSString *roomTypeID;

@end
