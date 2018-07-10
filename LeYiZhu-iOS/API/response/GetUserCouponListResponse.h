//
//  GetUserCouponListResponse.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/9.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "BaseCouponListModel.h"

@interface GetUserCouponListResponse : AbstractResponse

@property (nonatomic, readonly, strong) BaseCouponListModel * baseCouponList;

@end
