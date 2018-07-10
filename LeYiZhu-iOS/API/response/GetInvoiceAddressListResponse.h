//
//  GetInvoiceAddressListResponse.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AbstractResponse.h"
#import "BaseInvoiceAddressListModel.h"

@interface GetInvoiceAddressListResponse : AbstractResponse

@property (nonatomic,readonly ,strong)  BaseInvoiceAddressListModel *baseInvoiceAddress;

@end
