//
//  userRoomPwdsModel.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 17/1/17.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface userRoomPwdsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy)NSString *hotelRoomPwdID;

@property (nonatomic, readonly, copy)NSString *hotelRoomNumID;

@property (nonatomic, readonly, copy)NSString *password;

@property (nonatomic, readonly, copy)NSString *startDate;

@property (nonatomic, readonly, copy) NSString *endDate;

@property (nonatomic, readonly, copy) NSString *roomNum;


@end
