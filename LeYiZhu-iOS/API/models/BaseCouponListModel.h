//
//  BaseCouponListModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/9.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BaseCouponListModel : MTLModel<MTLJSONSerializing>

@property (nonatomic ,readonly, strong) NSArray *couponjar;

@end