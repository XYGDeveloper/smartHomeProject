//
//  AlipayOrderInfoResponse.h
//  LeYiZhu-iOS
//
//  Created by 陈 雪峰 on 16/12/3.
//  Copyright © 2016年 lyz. All rights reserved.
//

#import "AbstractResponse.h"
#import "AlipayOrderModel.h"


@interface AlipayOrderInfoResponse : AbstractResponse

//@property (nonatomic, readonly, strong) AlipayOrderModel *alipayOrder;


@property (nonatomic, readonly, strong) NSString *alipayOrder;


@end
