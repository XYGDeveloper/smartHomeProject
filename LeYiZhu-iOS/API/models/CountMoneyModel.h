//
//  CountMoneyModel.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface CountMoneyModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy)NSNumber *payNum;//预定房间数

@property (nonatomic, readonly, copy)NSNumber *liveDay;

@property (nonatomic, readonly, copy)NSString *deposit;//押金

@property (nonatomic, readonly, copy)NSString *stayMoneySum;//房费总价

@property (nonatomic, readonly, copy)NSString *depositSum;//总押金

@property (nonatomic, readonly, copy)NSString *actualPayment;//实际支付金额

@property (nonatomic, readonly, copy)NSString *coupondetatilid;

@property (nonatomic, readonly, strong)NSNumber *coupontype;//优惠券类型(0.无优惠券1.现金券 2.折扣券)

@property (nonatomic, readonly, copy)NSString *coupondenominat;

@property (nonatomic, readonly, copy)NSString *coupondiscount;

@property (nonatomic, readonly, strong)NSArray *roomPrice;//房费

@property (nonatomic, readonly, copy)NSString *totalDiscount;




@end
