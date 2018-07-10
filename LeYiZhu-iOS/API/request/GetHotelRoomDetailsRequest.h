//
//  GetHotelRoomDetailsRequest.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface GetHotelRoomDetailsRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property(nonatomic, copy) NSString *fromtype;

@property(nonatomic, copy) NSString * roomTypeID;

@end
