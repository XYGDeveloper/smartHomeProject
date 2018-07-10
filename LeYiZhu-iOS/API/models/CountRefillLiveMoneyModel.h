//
//  CountRefillLiveMoneyModel.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/4/12.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CountRefillLiveMoneyModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy) NSString *deductible;

@property (nonatomic, readonly, copy) NSString *stayMoneySum;

@property (nonatomic, readonly, copy) NSString *depositSum;

@property (nonatomic, readonly, copy) NSString *actualPayment;

@property (nonatomic, readonly, strong) NSArray *childOrderInfoJar;

@property (nonatomic, readonly, copy) NSString  *coupondetatilid;

@property (nonatomic, readonly, strong) NSNumber *coupontype;

@property (nonatomic, readonly, copy) NSString *coupondenominat;

@property (nonatomic, readonly, copy) NSString *coupondiscount;

@property (nonatomic, readonly, copy) NSString *totalDiscount;


@end
