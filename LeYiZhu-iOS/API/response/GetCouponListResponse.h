//
//  GetCouponListResponse.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/3.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "AbstractResponse.h"
@class BaseCouponListModel;
@interface GetCouponListResponse : AbstractResponse

@property (nonatomic, readonly, strong) BaseCouponListModel *baseCoupon;

@end
