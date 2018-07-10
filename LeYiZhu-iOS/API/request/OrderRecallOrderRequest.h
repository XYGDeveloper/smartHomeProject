//
//  OrderRecallOrderRequest.h
//  LeYiZhu-iOS
//
//  Created by smart home on 2017/1/21.
//  Copyright © 2017年 lyz. All rights reserved.
//

#import "IRequest.h"

@interface OrderRecallOrderRequest : AbstractRequest

@property (nonatomic, copy) NSString *versioncode;

@property (nonatomic, copy) NSString *devicenum;

@property (nonatomic, copy) NSString *fromtype;

@property (nonatomic, copy) NSString *orderNO;

@property (nonatomic, copy) NSString *orderType;

@end
