//
//  LYZHotelDetailModel.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "HotelRoomsModel.h"
#import "HotelCommentsModel.h"

@interface LYZHotelDetailModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, readonly, copy)NSString *hotelID;

@property(nonatomic, readonly, copy)NSString * hotelName;

@property(nonatomic, readonly, copy)NSString * address;

@property(nonatomic, readonly, copy)NSString * facility;//酒店设施

@property(nonatomic, readonly, copy)NSString * lowestPrice;
@property(nonatomic, readonly, copy)NSString * checkInInfo;//入住须知

@property(nonatomic, readonly, copy)NSString * introduction;//酒店介绍

@property(nonatomic, readonly, copy)NSString * distance;

@property(nonatomic, readonly, copy)NSString * commentCount;

@property(nonatomic, readonly, copy)NSString *avgSatisfaction;//酒店评分

@property(nonatomic, readonly, strong)NSArray *hotelImgs;

@property(nonatomic, readonly, strong)NSArray * roomTypes;

@property(nonatomic, readonly, strong)NSArray * comments;

@property (nonatomic, readonly, assign) NSNumber *isFavorite;

@property (nonatomic, readonly, copy) NSString *longitude;

@property (nonatomic, readonly, copy) NSString *latitude;

@property (nonatomic, readonly, strong) NSNumber *status;//酒店状态 （1 营业中 2 即将营业 3停业中）

@property (nonatomic, readonly, copy) NSString *tags;



@end
