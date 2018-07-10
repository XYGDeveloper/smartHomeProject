//
//  HotelRoomsModel.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface HotelRoomsModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *roomTypeID;
@property (nonatomic, readonly, copy) NSString * roomType;
@property(nonatomic, readonly, copy) NSString *imgPath;
@property(nonatomic, readonly, copy) NSString *price;
@property(nonatomic, readonly, copy) NSString *roomSize;
@property(nonatomic, readonly, copy) NSString *bedType;
@property(nonatomic, readonly, copy) NSString *capacity;
@property(nonatomic, readonly, copy) NSString *isWIFI;
@property(nonatomic, readonly, strong) NSNumber *validRoomSize;
@property(nonatomic, readonly, copy) NSString *openstatus; //Y是  N否
@property(nonatomic, readonly, copy) NSString *vipprice;
@property(nonatomic, readonly, strong) NSNumber *roomTypeStatus; //1（有空房）2（满房） 3（部分满房）
@property(nonatomic, readonly, copy) NSString *prompt;

@end
