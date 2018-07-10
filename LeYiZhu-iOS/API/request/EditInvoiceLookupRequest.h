//
//  EditInvoiceLookupRequest.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IRequest.h"

@interface EditInvoiceLookupRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property (nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *appUserID;

@property (nonatomic,copy) NSString *lookupID;

@property (nonatomic,strong) NSNumber *type;

@property (nonatomic,copy) NSString *lookUp;

@property (nonatomic, copy) NSString *taxNumber;

@end
