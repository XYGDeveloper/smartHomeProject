//
//  LookupModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/7/15.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface LookupModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *lookupID;

@property (nonatomic, readonly, copy) NSString *userId;

@property (nonatomic, readonly, strong) NSNumber *type;

@property (nonatomic, readonly, copy) NSString *lookUp;//发票抬头

@property (nonatomic, readonly, copy) NSString *taxNumber;

@property (nonatomic, readonly, copy) NSString *createTime;

@property (nonatomic, readonly, strong) NSNumber *status;//状态

@property (nonatomic, readonly, strong) NSNumber *useAmount;//使用次数

@end
