//
//  EditInvoiceAddressRequest.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IRequest.h"

@interface EditInvoiceAddressRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property (nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *appUserID;

@property (nonatomic, copy) NSString *invoiceAddressID;

@property (nonatomic,copy) NSString *recipient;

@property (nonatomic,copy) NSString *phone;

@property (nonatomic,copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic,copy) NSString *area;

@property (nonatomic,copy) NSString *address;



@end
