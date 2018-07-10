//
//  BaseOrderDetailModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "OrderHotelModel.h"
#import "OrderModel.h"
#import "BaseOrderInvoiceModel.h"
#import "OrderCheckInsModel.h"   

@interface BaseOrderDetailModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, strong) OrderModel *orderJson;//订单信息

@property (nonatomic, readonly, strong) OrderHotelModel *hotelJson;//酒店信息

@property (nonatomic, readonly, strong) BaseOrderInvoiceModel *invoiceJson;

@property (nonatomic, readonly, strong) NSArray *childOrderInfoJar;

@end
