//
//  createOrderModel.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2016/12/7.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface createOrderModel : MTLModel<MTLJSONSerializing>

@property (nonatomic, readonly, copy)  NSString *orderNo;

@property (nonatomic, readonly, strong) NSNumber *orderType;

@end
