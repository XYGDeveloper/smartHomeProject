//
//  BaseRefillInfoModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "OrderHotelModel.h"

@interface BaseRefillInfoModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, strong) NSArray  *childOrderInfoJar;

@property (nonatomic, readonly, strong) OrderHotelModel *hotelJson;

@property (nonatomic, readonly, strong) NSString *userPhone;

@property (nonatomic, readonly, copy) NSString  *coupondetatilid;

@property (nonatomic, readonly, strong) NSNumber *coupontype;

@property (nonatomic, readonly, copy) NSString *coupondenominat;

@property (nonatomic, readonly, copy) NSString *coupondiscount;


@end
