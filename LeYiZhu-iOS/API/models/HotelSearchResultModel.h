//
//  HotelSearchResultModel.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/1.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface HotelSearchResultModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, readonly, copy) NSString * hotelID;

@property(nonatomic, readonly, copy) NSString * hotelName;

@property(nonatomic, readonly, copy) NSString * address;

@property(nonatomic, readonly, copy) NSString *lowestPrice;

@property(nonatomic, readonly, copy) NSString *distance;

@property(nonatomic, readonly, copy) NSString *imgPath;

@property(nonatomic, readonly, copy) NSString *type;

@property(nonatomic, readonly, copy) NSString *avgSatisfaction;

@end
