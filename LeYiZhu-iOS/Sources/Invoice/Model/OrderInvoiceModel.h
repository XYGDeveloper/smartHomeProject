//
//  OrderInvoiceModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2016/12/22.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InvoiceTitleModel.h"
#import "RecieverInfoModel.h"


typedef enum : NSUInteger {
    OrderInvoiceType_none = 0,
    OrderInvoiceType_Electronic ,
    OrderInvoiceType_Paper
} OrderInvoiceType;

@interface OrderInvoiceModel : NSObject

@property (nonatomic,assign) OrderInvoiceType type;//发票类型

@property (nonatomic,copy) NSString * detail;//发票明细

@property (nonatomic,strong) InvoiceTitleModel * title;//抬头

@property (nonatomic, strong) RecieverInfoModel *recieverInfo;

@property (nonatomic,copy) NSString * invoiceremark;//备注信息

@property (nonatomic, copy) NSString * postType;


@end
