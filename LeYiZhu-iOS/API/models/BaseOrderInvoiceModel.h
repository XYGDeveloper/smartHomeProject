//
//  OrderInvoiceModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/23.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BaseOrderInvoiceModel : MTLModel<MTLJSONSerializing>

@property (nonatomic ,readonly, assign) NSNumber *invoiceType; //发票类型

@property (nonatomic ,readonly, copy) NSString *invoiceDetail;

@property (nonatomic ,readonly, copy) NSString *lookup;//发票抬头

@property (nonatomic ,readonly, copy) NSString *taxNumber;//税号

@property (nonatomic ,readonly, copy) NSString *recipient;

@property (nonatomic, readonly, copy) NSString *phone;

@property (nonatomic, readonly, copy) NSString *invoiceremark;

@property (nonatomic, readonly, copy) NSString *address;

@property (nonatomic, readonly, strong) NSNumber *mailType;

@property (nonatomic, readonly, strong) NSString *email;

@end
