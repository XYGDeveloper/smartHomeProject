//
//  BaseInvoiceAddressListModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>


@interface BaseInvoiceAddressListModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, strong) NSNumber *addressJarSize;

@property (nonatomic, readonly, strong) NSArray *addressJar;

@end
