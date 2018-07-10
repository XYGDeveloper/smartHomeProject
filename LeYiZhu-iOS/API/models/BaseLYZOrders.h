//
//  BaseLYZOrders.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "OrderModel.h"
#import "OrderHotelModel.h"


@interface BaseLYZOrders : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, strong) OrderModel *orderJson;//订单信息

@property (nonatomic, readonly, strong) OrderHotelModel *hotelJson;//酒店信息

@end
