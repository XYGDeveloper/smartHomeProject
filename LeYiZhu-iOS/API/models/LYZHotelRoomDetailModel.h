//
//  LYZHotelRoomDetailModel.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface LYZHotelRoomDetailModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString * roomTypeID;
@property (nonatomic, readonly, copy) NSString *roomType;
@property (nonatomic, readonly, copy) NSString *imgPath;
@property (nonatomic, readonly, copy) NSString *price;
@property (nonatomic, readonly, copy) NSString *isWIFI;
@property (nonatomic, readonly, copy) NSString *roomSize;
@property (nonatomic, readonly, copy) NSString *capacity;
@property (nonatomic, readonly, copy) NSString *bedType;
@property (nonatomic, readonly, copy) NSString *tips;
@property (nonatomic, readonly, copy) NSString *roomFloors;
@property (nonatomic, readonly, strong) NSArray *roomTypeImgs;
@property (nonatomic, readonly, copy) NSString *openstatus;
@property (nonatomic, readonly, copy) NSString *vipprice;
@property (nonatomic, readonly, copy) NSString *hotelid;
@property (nonatomic, readonly, copy) NSString *hotelname;
@property (nonatomic, readonly, copy) NSString *vipname;
@property (nonatomic, readonly, copy) NSString *vipcode;



@end
