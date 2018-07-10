//
//  RoomPriceInfo.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/12/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface RoomPriceInfo : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *minPrice;
@property (nonatomic, readonly, copy) NSString *vipMinPrice;
@property (nonatomic, readonly, copy) NSString *realPrice;
@property (nonatomic, readonly, strong) NSArray *roomPrices;
@property (nonatomic, readonly, copy) NSString *coupondetatilid;
@property (nonatomic, readonly, copy) NSString *coupondenominat;
@property (nonatomic, readonly, copy) NSString *coupondiscount;
@property (nonatomic, readonly, assign) NSNumber *coupontype;
@property (nonatomic, readonly, copy) NSString *couponName;

@end
