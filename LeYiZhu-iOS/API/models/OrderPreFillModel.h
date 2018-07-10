//
//  OrderPreFillModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/3/11.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface OrderPreFillModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *name;

@property (nonatomic, readonly, strong) NSNumber *paperworkType;

@property (nonatomic, readonly, copy) NSString *paperworkNum;

@property (nonatomic, readonly, copy) NSString *livePhone;//入住人手机号

@property (nonatomic, readonly, copy) NSString *phone;

@property (nonatomic, readonly, copy) NSString *liveUserId;

@property (nonatomic, readonly, copy) NSString *coupondetatilid;

@property (nonatomic, readonly, copy) NSString *coupondenominat;

@property (nonatomic, readonly, copy) NSString *coupondiscount;

@property (nonatomic, readonly, assign) NSNumber *coupontype;

@end
