//
//  GetCouponListRequest.h
//  LeYiZhu-iOS
//
//  Created by mac on 2017/8/3.
//  Copyright © 2017年 乐易住智能科技. All rights reserved.
//

#import "IRequest.h"

@interface GetCouponListRequest : AbstractRequest


@property (nonatomic, copy)NSString *roomprice;

@property (nonatomic, copy)NSString *couponstatus;

@property (nonatomic,copy) NSString *limit;

@property (nonatomic, copy) NSString *pages;


@end
