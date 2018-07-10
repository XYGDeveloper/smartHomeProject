//
//  AlipayOrderModel.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface AlipayOrderModel : MTLModel<MTLJSONSerializing>

@property(nonatomic, readonly, copy) NSString *orderNo;

@property (nonatomic, readonly, copy) NSString *orderInfo;

@end
