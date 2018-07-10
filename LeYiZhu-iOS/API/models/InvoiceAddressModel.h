//
//  InvoiceAddressModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface InvoiceAddressModel : MTLModel<MTLJSONSerializing>


@property (nonatomic, readonly, copy) NSString *invoiceAddressID;

@property (nonatomic, readonly, copy) NSString *userId;

@property (nonatomic, readonly, copy) NSString *recipient;

@property (nonatomic, readonly, copy) NSString *phone;

@property (nonatomic, readonly, copy) NSString *province;

@property (nonatomic, readonly, copy) NSString *city;

@property (nonatomic, readonly, copy) NSString *area;

@property (nonatomic, readonly, copy) NSString *address;

@property (nonatomic, readonly, copy) NSString *createTime;

@property (nonatomic, readonly, strong) NSNumber *status;

@property (nonatomic, readonly, strong) NSNumber *useAmount;//使用次数

@end
